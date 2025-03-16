import 'dart:async';

import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/services/discord_service.dart';
import 'package:mobx/mobx.dart';

import 'application_details.store.dart';
part 'discord_details.store.g.dart';

class DiscordDetailsStore = _DiscordDetailsStore with _$DiscordDetailsStore;

abstract class _DiscordDetailsStore with Store {
  final DiscordService _discordService;
  final ApplicationDetailsStore _applicationDetailsStore;
  _DiscordDetailsStore(this._discordService, this._applicationDetailsStore) {
    reaction((_) => _applicationDetailsStore.id, (_) {
      if (_applicationDetailsStore.id != '0' ||
          _applicationDetailsStore.id.isNotEmpty) {
        fetchUserGuilds();
      }
    });
  }

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
  Future<DiscordUser> fetchUserDetails(String discordId) async {
    callsInProgress.add('fetchUserDetails');
    var foundUser;
    try {
      foundUser = await _discordService.fetchUserDetails(discordId);
      discordIdToName.putIfAbsent(discordId, () => foundUser.username);
    } on Exception catch (error) {
      _applicationDetailsStore.error =
          'Failed to fetch Discord User details due to ${error.toString()}';
    }
    callsInProgress.remove('fetchUserDetails');
    return foundUser;
  }

  @action
  Future<void> fetchCurrentUserDetails() async {
    callsInProgress.add('fetchCurrentUserDetails');
    final future = _discordService.fetchCurrentUserDetails();
    try {
      DiscordUser updatedUser = await future;
      discordUser = updatedUser;
      _applicationDetailsStore.id = discordUser.id;
      discordIdToName.putIfAbsent(updatedUser.id, () => updatedUser.username);
    } on Exception catch (error) {
      _applicationDetailsStore.error =
          'Failed to fetch Discord User details due to ${error.toString()}';
    }
    callsInProgress.remove('fetchCurrentUserDetails');
  }

  @action
  Future<void> fetchUserGuilds() async {
    callsInProgress.add('fetchUserGuilds');
    final future = _discordService.fetchUserGuilds();
    try {
      List<DiscordGuild> guilds = await future;
      discordGuilds.clear();
      discordGuilds.addAll(guilds);
    } on Exception catch (error) {
      _applicationDetailsStore.error = error.toString();
    }
    callsInProgress.remove('fetchUserGuilds');
  }
}
