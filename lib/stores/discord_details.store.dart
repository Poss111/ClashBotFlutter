import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/services/discord_service.dart';
import 'package:mobx/mobx.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';
import 'dart:developer' as developer;

import 'application_details.store.dart';
part 'discord_details.store.g.dart';

class DiscordDetailsStore = _DiscordDetailsStore with _$DiscordDetailsStore;

abstract class _DiscordDetailsStore with Store {
  final DiscordService _discordService;
  final ApplicationDetailsStore _applicationDetailsStore;
  _DiscordDetailsStore(this._discordService, this._applicationDetailsStore) {
    reaction(
        (_) =>
            _applicationDetailsStore.id != '0' ||
            _applicationDetailsStore.id.isNotEmpty, (_) {
      loadEverything();
    });
  }

  @observable
  DiscordUser discordUser = DiscordUser('0', 'Not Logged In', 'N/A', '');

  @observable
  ObservableList<DiscordGuild> discordGuilds = ObservableList<DiscordGuild>();

  @observable
  ObservableMap<String, String> discordIdToName = ObservableMap();

  @observable
  String status = 'NOT_LOADED';

  @computed
  bool get detailsLoaded => discordUser.id != '0';

  @computed
  bool get guildDetailsLoaded => discordGuildMap.isNotEmpty;

  @computed
  Map<String, DiscordGuild> get discordGuildMap =>
      {for (var guild in discordGuilds) guild.id: guild};

  @action
  Future<DiscordUser> fetchUserDetails(String discordId) async {
    var foundUser;
    try {
      foundUser = await _discordService.fetchUserDetails(discordId);
      discordIdToName.putIfAbsent(discordId, () => foundUser.username);
    } on Exception catch (error) {}
    return foundUser;
  }

  @action
  Future<void> fetchCurrentUserDetails() async {
    status = 'LOADING';
    final future = _discordService.fetchCurrentUserDetails();
    try {
      DiscordUser updatedUser = await future;
      discordUser = updatedUser;
      _applicationDetailsStore.id = discordUser.id;
      discordIdToName.putIfAbsent(updatedUser.id, () => updatedUser.username);
      status = 'LOADED';
    } on Exception catch (error) {
      _applicationDetailsStore.error =
          'Failed to fetch Discord User details due to ${error.toString()}';
      status = 'NOT LOADED';
    }
  }

  @action
  Future<void> fetchUserGuilds() async {
    status = 'LOADING';
    final future = _discordService.fetchUserGuilds();
    try {
      List<DiscordGuild> guilds = await future;
      discordGuilds.clear();
      discordGuilds.addAll(guilds);
      status = 'LOADED';
    } on Exception catch (error) {
      _applicationDetailsStore.error = error.toString();
      status = 'NOT LOADED';
    }
  }

  @action
  Future<void> loadEverything() async {
    status = 'LOADING';
    try {
      // await _discordService.loginToDiscord();
      await Future.wait([fetchCurrentUserDetails(), fetchUserGuilds()]);

      _applicationDetailsStore.id = discordUser.id;

      status = 'LOADED';
    } on Exception catch (error) {
      _applicationDetailsStore.error = error.toString();
      status = 'NOT LOADED';
    }
  }
}
