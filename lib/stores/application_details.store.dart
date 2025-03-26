import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_notification.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/services/clashbot_service.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/error_handler.store.dart';
import 'package:collection/collection.dart';
import 'package:mobx/mobx.dart';
import 'dart:developer' as developer;

import 'package:url_launcher/url_launcher.dart';

part 'application_details.store.g.dart';

class ApplicationDetailsStore = _ApplicationDetailsStore
    with _$ApplicationDetailsStore;

abstract class _ApplicationDetailsStore with Store {
  late DiscordDetailsStore _discordDetailsStore;
  late RiotChampionStore _riotChampionStore;
  final ClashStore _clashStore;
  final ErrorHandlerStore _errorHandlerStore;
  _ApplicationDetailsStore(this._clashStore, this._discordDetailsStore,
      this._riotChampionStore, this._errorHandlerStore) {
    reaction((_) => _discordDetailsStore.discordUser, (_) {
      if (_discordDetailsStore.discordUser.id != '0') {
        _clashStore.refreshClashBotUser(_discordDetailsStore.discordUser.id);
        _clashStore.refreshSelectedServers();
        _discordDetailsStore.fetchUserGuilds();
      }
    });
    reaction((_) => _clashStore.clashBotUser, (_) {
      if (_clashStore.clashBotUser.discordId != '0' &&
          !_clashStore.refreshingUser) {
        _clashStore
            .refreshClashTournaments(_clashStore.clashBotUser.discordId!);
        _clashStore.refreshClashTeams(_clashStore.clashBotUser.discordId!,
            _clashStore.clashBotUser.selectedServers);
        setPreferredServers(_clashStore.clashBotUser.selectedServers);
      }
    });
  }

  @observable
  ClashBotUser clashBotUser = ClashBotUser();

  @observable
  ObservableList<ClashNotification> notifications = ObservableList();

  @observable
  ObservableList<String> preferredServers = ObservableList();

  @computed
  bool get isLoggedIn =>
      _discordDetailsStore.userHasLoggedIn && clashBotUser.discordId != '0';

  // Create map of String to subscription
  @computed
  ObservableMap<String, Subscription> get subscription =>
      ObservableMap.of(Map<String, Subscription>.fromIterable(
        clashBotUser.subscriptions,
        key: (e) => e.key,
        value: (e) => e as Subscription,
      ));

  @computed
  ObservableList<String> get sortedSelectedServers =>
      ObservableList.of(clashBotUser.selectedServers.sorted());

  @computed
  List<ClashNotification> get sortedNotifications =>
      notifications.sortedBy((element) => element.timestamp);

  @computed
  List<ClashNotification> get unreadNotifications =>
      notifications.where((notification) => !notification.read).toList();

  @action
  void setPreferredServers(List<String> servers) {
    developer.log(
        "ApplicationDetailsStore:             setPreferredServers $servers");
    preferredServers = ObservableList.of(servers);
  }

  @action
  void refreshDiscordUser() {
    _discordDetailsStore.fetchCurrentUserDetails();
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
  Future<void> createUser(String id, List<String> preferredServers) async {
    try {
      _clashStore.createPlayer(id, _discordDetailsStore.discordUser.username,
          preferredServers.first);
      _clashStore.createSelectedServers(id, preferredServers);
      _clashStore.refreshClashBotUser(id);
    } on Exception catch (issue) {
      _errorHandlerStore.errorMessage =
          'Failed to create new Clash Bot User, please try again.';
      rethrow;
    }
  }
}
