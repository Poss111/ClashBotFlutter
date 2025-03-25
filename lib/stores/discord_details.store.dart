import 'dart:async';

import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/services/discord_service.dart';
import 'package:clashbot_flutter/stores/v2-stores/error_handler.store.dart';
import 'package:mobx/mobx.dart';
import 'dart:developer' as developer;

part 'discord_details.store.g.dart';

class DiscordDetailsStore = _DiscordDetailsStore with _$DiscordDetailsStore;

abstract class _DiscordDetailsStore with Store {
  final DiscordService _discordService;
  final ErrorHandlerStore _errorHandlerStore;
  _DiscordDetailsStore(this._discordService, this._errorHandlerStore);

  @observable
  DiscordUser discordUser = DiscordUser('0', 'Not Logged In', 'N/A', '');

  @observable
  ObservableList<DiscordGuild> discordGuilds = ObservableList<DiscordGuild>();

  @observable
  ObservableMap<String, String> discordIdToName = ObservableMap();

  @observable
  ObservableList<String> callsInProgress = ObservableList();

  @computed
  bool get loadingData => callsInProgress.isNotEmpty;

  @computed
  bool get userHasLoggedIn => discordUser.id != '0';

  @computed
  bool get guildDetailsLoaded => discordGuildMap.isNotEmpty;

  @computed
  Map<String, DiscordGuild> get discordGuildMap =>
      {for (var guild in discordGuilds) guild.id: guild};

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
  Future<void> fetchUserDetails(String discordId) async {
    addCallInProgress('fetchUserDetails');
    var foundUser;
    try {
      foundUser = await _discordService.fetchUserDetails(discordId);
      discordIdToName.putIfAbsent(discordId, () => foundUser.username);
    } on Exception catch (error) {
      _errorHandlerStore.errorMessage =
          'Failed to fetch Discord User details due to ${error.toString()}';
    }
    removeCallInProgress('fetchUserDetails');
  }

  @action
  Future<void> fetchCurrentUserDetails() async {
    addCallInProgress('fetchCurrentUserDetails');
    final future = _discordService.fetchCurrentUserDetails();
    try {
      DiscordUser updatedUser = await future;
      discordUser = updatedUser.copy();
      discordIdToName.putIfAbsent(updatedUser.id, () => updatedUser.username);
    } on Exception catch (error) {
      _errorHandlerStore.errorMessage =
          'Failed to fetch Discord User details due to ${error.toString()}';
    }
    removeCallInProgress('fetchCurrentUserDetails');
  }

  @action
  Future<void> fetchUserGuilds() async {
    addCallInProgress('fetchUserGuilds');
    final future = _discordService.fetchUserGuilds();
    try {
      List<DiscordGuild> guilds = await future;
      discordGuilds.clear();
      discordGuilds.addAll(guilds);
    } on Exception catch (error) {
      _errorHandlerStore.errorMessage = error.toString();
    }
    removeCallInProgress('fetchUserGuilds');
  }
}
