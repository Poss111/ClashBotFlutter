import 'dart:async';

import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/models/notification.dart';
import 'package:clashbot_flutter/services/discord_service.dart';
import 'package:clashbot_flutter/stores/v2-stores/notification_handler.store.dart';
import 'package:mobx/mobx.dart';
import 'dart:developer' as developer;

part 'discord_details.store.g.dart';

class DiscordDetailsStore = _DiscordDetailsStore with _$DiscordDetailsStore;

abstract class _DiscordDetailsStore with Store {
  final DiscordService _discordService;
  final NotificationHandlerStore _errorHandlerStore;
  _DiscordDetailsStore(this._discordService, this._errorHandlerStore);

  @observable
  DiscordUser discordUser = DiscordUser('0', 'Not Logged In', 'N/A', '');

  @observable
  ObservableList<DiscordGuild> discordGuilds = ObservableList<DiscordGuild>();

  @observable
  ObservableMap<String, String> discordIdToName = ObservableMap();

  @observable
  ObservableList<String> callsInProgress = ObservableList();

  @observable
  bool failedToLoad = false;

  @computed
  bool get loadingData => callsInProgress.isNotEmpty;

  @computed
  bool get userHasLoggedIn => discordUser.id != '0';

  @computed
  bool get guildDetailsLoaded => discordGuildMap.isNotEmpty;

  @computed
  Map<String, DiscordGuild> get discordGuildMap =>
      {for (var guild in discordGuilds) guild.id: guild};

  @computed
  bool get irreconcilableError => failedToLoad && discordUser.id == '0';

  @action
  void loadingUserDetailsFailed() {
    failedToLoad = true;
  }

  @action
  void userDetailsSuccessfullyLoaded() {
    failedToLoad = false;
  }

  @action
  void addCallInProgress(String call) {
    callsInProgress.add(call);
  }

  @action
  void removeCallInProgress(String call) {
    callsInProgress.remove(call);
  }

  @action
  void clearCallsInProgress() {
    callsInProgress.clear();
  }

  @action
  void pushForName(String discordId) {
    if (discordIdToName.containsKey(discordId) &&
        discordIdToName[discordId] != 'N/A') {
      return;
    }
    fetchUserDetails(discordId);
  }

  @action
  Future<void> fetchUserDetails(String discordId) async {
    addCallInProgress('fetchUserDetails');
    var foundUser;
    try {
      userDetailsSuccessfullyLoaded();
      foundUser = await _discordService.fetchUserDetails(discordId);
      discordIdToName.putIfAbsent(discordId, () => foundUser.username);
    } on Exception catch (error) {
      _errorHandlerStore.setNotification(Notification.error(
          'Failed to fetch Discord User details due to ${error.toString()}'));
    }
    removeCallInProgress('fetchUserDetails');
  }

  @action
  Future<void> fetchCurrentUserDetails() async {
    addCallInProgress('fetchCurrentUserDetails');
    final future = _discordService.fetchCurrentUserDetails();
    try {
      userDetailsSuccessfullyLoaded();
      DiscordUser updatedUser = await future;
      discordUser = updatedUser.copy();
      discordIdToName.putIfAbsent(updatedUser.id, () => updatedUser.username);
    } on Exception catch (error) {
      _errorHandlerStore.setNotification(Notification.error(
          'Failed to fetch Discord User details due to ${error.toString()}'));
      loadingUserDetailsFailed();
    }
    removeCallInProgress('fetchCurrentUserDetails');
  }

  @action
  Future<void> fetchUserGuilds() async {
    addCallInProgress('fetchUserGuilds');
    final future = _discordService.fetchUserGuilds();
    try {
      userDetailsSuccessfullyLoaded();
      List<DiscordGuild> guilds = await future;
      discordGuilds.clear();
      discordGuilds.addAll(guilds);
    } on Exception catch (error) {
      _errorHandlerStore.setNotification(Notification.error(error.toString()));
      loadingUserDetailsFailed();
    }
    removeCallInProgress('fetchUserGuilds');
  }
}
