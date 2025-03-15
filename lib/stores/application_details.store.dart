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

part 'application_details.store.g.dart';

class ApplicationDetailsStore extends _ApplicationDetailsStore
    with _$ApplicationDetailsStore {
  ApplicationDetailsStore(
      DiscordService discordService,
      ClashBotService clashBotService,
      RiotResourcesService riotResourcesService,
      ClashBotEventsService clashBotEventsService)
      : super(discordService, clashBotService, riotResourcesService,
            clashBotEventsService) {
    discordDetailsStore = DiscordDetailsStore(_discordService, this);
    riotChampionStore = RiotChampionStore(_riotResourcesService, this);
  }
}

abstract class _ApplicationDetailsStore with Store {
  late DiscordDetailsStore discordDetailsStore;
  final DiscordService _discordService;
  final ClashBotService _clashBotService;
  late RiotChampionStore riotChampionStore;
  final RiotResourcesService _riotResourcesService;
  final ClashBotEventsService _clashBotEventsService;
  _ApplicationDetailsStore(this._discordService, this._clashBotService,
      this._riotResourcesService, this._clashBotEventsService) {
    reaction((_) => id, (_) {
      refreshClashBotUser();
      refreshSelectedServers();
    });
  }

  @observable
  String id = '0';

  @observable
  ClashBotUser clashBotUser = ClashBotUser();

  // Create map of String to subscription
  @computed
  ObservableMap<String, Subscription> get subscription =>
      ObservableMap.of(Map<String, Subscription>.fromIterable(
        clashBotUser.subscriptions,
        key: (e) => e.key,
        value: (e) => e as Subscription,
      ));

  @observable
  ObservableList<String> preferredServers = ObservableList();

  @computed
  ObservableList<String> get sortedSelectedServers =>
      ObservableList.of(clashBotUser.selectedServers.sorted());

  @action
  Future<void> refreshSelectedServers() async {
    preferredServers.clear();
    var userDetails = await _clashBotService.getPlayer(id);
    developer.log(userDetails.selectedServers.toString());
    preferredServers = ObservableList.of(userDetails.selectedServers);
    developer.log("Preferred: " + preferredServers.toString());
  }

  @action
  Future<void> refreshClashBotUser() async {
    clashBotUser = await _clashBotService.getPlayer(id);
  }

  @observable
  String error = '';

  @observable
  ObservableList<ClashNotification> notifications = ObservableList();

  @computed
  List<ClashNotification> get sortedNotifications =>
      notifications.sortedBy((element) => element.timestamp);

  @computed
  List<ClashNotification> get unreadNotifications =>
      notifications.where((notification) => !notification.read).toList();

  @computed
  bool get isLoggedIn =>
      discordDetailsStore.detailsLoaded && clashBotUser.discordId != '0';

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
    var notification =
        notifications.firstWhere((element) => element.uuid == uuid);
    notification.read = true;
    notifications.removeWhere((element) => element.uuid == uuid);
    notifications.add(notification);
  }

  @action
  void unsubscribeFromServer(String serverId) {
    // _clashBotEventsService.removeSubscription(serverId);
  }

  @action
  void subscribeToServer(String serverId) {
    // _clashBotEventsService.setupSubscription(
    //     id, serverId, notifyUser, loggedInClashUser, discordDetailsStore);
  }

  @action
  Future<void> loadUserDetails() async {
    try {
      await Future.wait([
        discordDetailsStore.loadEverything(),
        riotChampionStore.refreshChampionData()
      ]);
      // _clashBotEventsService.connectClient(() {
      //   for (var serverId in loggedInClashUser.preferredServers) {
      //     _clashBotEventsService.setupSubscription(
      //         id, serverId, notifyUser, loggedInClashUser, discordDetailsStore);
      //   }
      // }, (dynamic error) {
      //   developer.log("Websocket connection failure.", error: error);
      //   error = "Failed to connect to Server events.";
      // });
    } catch (error) {
      developer.log("Failed to load user.", error: error);
      this.error = 'Failed to load :(, please try again later.';
    }
  }

  @action
  Future<ClashBotUser> createUser(
      String defaultServerId, List<String> selectedServersToUse) async {
    try {
      clashBotUser = await _clashBotService.createPlayer(
          id, discordDetailsStore.discordUser.username, defaultServerId);
      var updatedSelectedServers = await _clashBotService.createSelectedServers(
          id, selectedServersToUse);
      clashBotUser.selectedServers = updatedSelectedServers;
      preferredServers.clear();
      preferredServers.addAll(updatedSelectedServers);
      return clashBotUser;
    } on Exception catch (issue) {
      error = 'Failed to create new Clash Bot User, please try again.';
      developer.log('Failed to create new Clash Bot User', error: issue);
      rethrow;
    }
  }
}
