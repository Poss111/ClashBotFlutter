import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/enums/api_call_state.dart';
import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/pages/home/page/home_v2.dart';
import 'package:clashbot_flutter/services/clashbot_service_impl.dart';
import 'package:clashbot_flutter/services/discord_service_impl.dart';
import 'package:clashbot_flutter/services/riot_resources_service_impl.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/error_handler.store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

List<ClashTournament> buildTournaments(int count) {
  return List.generate(
    count,
    (index) => ClashTournament(
      'Tournament $index',
      '$index',
      DateTime.now(),
      DateTime.now().add(Duration(days: 1)),
    ),
  );
}

List<ClashTeam> buildClashTeams(int count) {
  return List.generate(
    count,
    (index) => ClashTeam(
      '$index',
      'Mock Team $index',
      'Mock Tournament $index',
      '$index',
      {
        Role.TOP: PlayerDetails('$index', 'Player $index', []),
        Role.JG: PlayerDetails('${index + 1}', 'Player ${index + 1}', []),
        Role.MID: PlayerDetails('${index + 2}', 'Player ${index + 2}', []),
        Role.SUPP: PlayerDetails('${index + 3}', 'Player ${index + 3}', []),
      },
      '123456789',
      DateTime.now(),
    ),
  );
}

List<DiscordGuild> buildGuilds(int count) {
  return List.generate(
    count,
    (index) => DiscordGuildWColor(
      id: '$index',
      name: 'Mock Guild $index',
      icon: 'icon',
      owner: index == 0,
      color: Colors.primaries[index % Colors.primaries.length],
    ),
  );
}

class MockApplicationDetailsStore extends ApplicationDetailsStore {
  MockApplicationDetailsStore(
    ClashBotUser mockClashBotUser,
    List<String> mockPreferredServers,
    super._clashStore,
    super._discordDetailsStore,
    super._riotChampionStore,
    super._errorHandlerStore,
  ) {
    clashBotUser = mockClashBotUser;
    clashBotUser.preferredServers = ObservableList.of(mockPreferredServers);
  }
}

class MockDiscordDetailsStore extends DiscordDetailsStore {
  MockDiscordDetailsStore(
    List<DiscordGuild> guilds,
    DiscordUser discordUser,
    super.discordService,
    super._errorHandlerStore,
  ) {
    discordGuilds = ObservableList.of(guilds);
    this.discordUser = discordUser;
  }
}

class MockClashStore extends ClashStore {
  ApiCallState originalTournamentsApiCallState = ApiCallState.success;
  MockClashStore(
    ClashBotUser clashBotUser,
    List<ClashTournament> tournaments,
    List<ClashTeam> clashTeams,
    ApiCallState tournamentsApiCallStateToBeSet,
    ApiCallState teamsApiCallState,
    ApiCallState userApiCallState,
    super._clashService,
    super._errorhandlerStore,
  ) {
    this.tournamentsApiCallState = tournamentsApiCallStateToBeSet;
    this.originalTournamentsApiCallState = tournamentsApiCallStateToBeSet;
    this.teamsApiCallState = teamsApiCallState;
    this.userApiCallState = userApiCallState;
    this.clashBotUser = clashBotUser;
    this.tournaments = ObservableList.of(tournaments);
    this.clashTeams = ObservableList.of(clashTeams);
  }

  @override
  Future<void> refreshClashTournaments(String id) async {
    setTournamentsApiCallState(ApiCallState.loading);
    await Future.delayed(Duration(seconds: 1), () {
      setTournamentsApiCallState(originalTournamentsApiCallState);
    });
  }
}

class MockRiotChampionStore extends RiotChampionStore {
  MockRiotChampionStore(super._riotResourcesService, super._errorHandlerStore);
}

List<String> buildMockServers(int numberOfServers) {
  List<String> servers = [];
  for (var i = 0; i < numberOfServers; i++) {
    servers.add('$i');
  }
  return servers;
}

List<DiscordGuild> buildMockDiscordGuilds(List<String> servers) {
  List<DiscordGuild> guilds = [];
  for (var i = 0; i < servers.length; i++) {
    guilds.add(DiscordGuild(servers[i], 'Mock Guild $i', '123456789', false));
  }
  return guilds;
}
