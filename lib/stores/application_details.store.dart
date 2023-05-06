import 'dart:convert';
import 'dart:math';

import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:clashbot_flutter/models/clash_notification.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/models/model_first_time.dart';
import 'package:clashbot_flutter/pages/home/home.dart';
import 'package:clashbot_flutter/services/clashbot_events_service.dart';
import 'package:clashbot_flutter/services/clashbot_service.dart';
import 'package:clashbot_flutter/services/discord_service.dart';
import 'package:clashbot_flutter/services/riot_resources_service.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:collection/collection.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart';
import 'package:mobx/mobx.dart';
import 'package:oauth2_client/oauth2_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;

import 'clashbot_player.store.dart';
part 'application_details.store.g.dart';

class ApplicationDetailsStore extends _ApplicationDetailsStore
    with _$ApplicationDetailsStore {
  ApplicationDetailsStore(
      DiscordService discordService, ClashBotService clashBotService, RiotResourcesService riotResourcesService, ClashBotEventsService clashBotEventsService)
      : super(discordService, clashBotService, riotResourcesService, clashBotEventsService) {
    discordDetailsStore = DiscordDetailsStore(_discordService, this);
    loggedInClashUser = ClashPlayerStore(_clashBotService, this);
    riotChampionStore = RiotChampionStore(_riotResourcesService, this);
  }
}

abstract class _ApplicationDetailsStore with Store {
  late DiscordDetailsStore discordDetailsStore;
  final DiscordService _discordService;
  late ClashPlayerStore loggedInClashUser;
  final ClashBotService _clashBotService;
  late RiotChampionStore riotChampionStore;
  final RiotResourcesService _riotResourcesService;
  final ClashBotEventsService _clashBotEventsService;
  _ApplicationDetailsStore(
    this._discordService,
    this._clashBotService,
    this._riotResourcesService,
    this._clashBotEventsService
  ) {}

  @observable
  String id = '0';

  @observable
  ObservableList<ClashTournament> tournaments =
      ObservableList<ClashTournament>();

  @observable
  String error = '';

  @observable
  ObservableList<ClashNotification> notifications = ObservableList();

  @computed
  List<ClashNotification> get sortedNotifications => notifications.sortedBy((element) => element.timestamp);

  @computed
  List<ClashNotification> get unreadNotifications => notifications.where((notification) => !notification.read).toList();

  @computed
  bool get isLoggedIn => discordDetailsStore.detailsLoaded && loggedInClashUser.clashBotUserDetailsLoaded;

  @action
  Future<void> getTournaments() async {
    var updatedTournaments = await _clashBotService.retrieveTournaments(id);
    tournaments.clear();
    tournaments.addAll(updatedTournaments);
  }

  @action
  void triggerError(String errorMessage) {
    error = errorMessage;
  }

  @action
  void notifyUser(ClashNotification clashNotification) {
    notifications.add(clashNotification);
  }

  @action
  void readNotification(String uuid) {
    var notification = notifications.firstWhere((element) => element.uuid == uuid);
    notification.read = true;
    notifications.removeWhere((element) => element.uuid == uuid);
    notifications.add(notification);
  }

  @action
  void unsubscribeFromServer(String serverId) {
    _clashBotEventsService.removeSubscription(serverId);
  }

  @action
  void subscribeToServer(String serverId) {
    _clashBotEventsService.setupSubscription(id, serverId, notifyUser, loggedInClashUser, discordDetailsStore);
  }

  @action
  Future<void> loadUserDetails() async {
    try {
      await Future.wait([
        discordDetailsStore.loadEverything(),
        riotChampionStore.refreshChampionData(),
        getTournaments()
      ]);
      await loggedInClashUser.refreshClashBotUserDetails();
      await Future.wait([
        loggedInClashUser.refreshTeamList(),
        loggedInClashUser.refreshTentativeQueue()
      ]);
      _clashBotEventsService.connectClient(() {
        for (var serverId in loggedInClashUser.selectedServers) { 
          _clashBotEventsService.setupSubscription(id, serverId, notifyUser, loggedInClashUser, discordDetailsStore);
        }
      },
      (dynamic error) {
        developer.log("Websocket connection failure.", error: error);
        error = "Failed to connect to Server events.";
      });
      
    } catch(error) {
      developer.log("Failed to load user.", error: error);
      this.error = 'Failed to load :(, please try again later.';
    }
  }

}
