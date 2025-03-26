import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/enums/api_call_state.dart';
import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/team_card.dart';
import 'package:clashbot_flutter/services/clashbot_service_impl.dart';
import 'package:clashbot_flutter/services/discord_service_impl.dart';
import 'package:clashbot_flutter/services/riot_resources_service_impl.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/error_handler.store.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/utils/mock_utils.dart';

@UseCase(name: "Default", type: TeamCard)
Widget buildTeamCardWidget(BuildContext context) {
  var clashUser = ClashBotUser(
    discordId: "1",
    champions: [],
    role: Role.TOP,
    serverId: 'server1',
    selectedServers: ['server1'],
    preferredServers: ['server1', 'server2'],
  );
  var mockServers = buildMockServers(2);
  var apiClient = ApiClient();
  var mockDiscordDetailsStore = MockDiscordDetailsStore(
    buildGuilds(2),
    DiscordUser('1', 'Mock User', 'Mock#0001', 'avatar'),
    DiscordServiceImpl(setupOauth2Helper()),
    ErrorHandlerStore(),
  );
  var mockApplicationDetailsStore = new MockApplicationDetailsStore(
    clashUser,
    mockServers,
    MockClashStore(
      clashUser,
      buildTournaments(2),
      buildClashTeams(2),
      ApiCallState.success,
      ApiCallState.success,
      ApiCallState.success,
      ClashBotServiceImpl(
        UserApi(apiClient),
        TeamApi(apiClient),
        ChampionsApi(apiClient),
        SubscriptionApi(apiClient),
        TentativeApi(apiClient),
        TournamentApi(apiClient),
        ErrorHandlerStore(),
      ),
      ErrorHandlerStore(),
    ),
    mockDiscordDetailsStore,
    MockRiotChampionStore(RiotResourceServiceImpl(), ErrorHandlerStore()),
    ErrorHandlerStore(),
  );
  return Center(
    child: TeamCard(
      applicationDetailsStore: mockApplicationDetailsStore,
      discordDetailsStore: mockDiscordDetailsStore,
      team: ClashTeam(
        '1',
        'Mock Team',
        'Tournament 1',
        '1',
        () {
          switch (context.knobs.int.slider(
            label: '# of missing roles',
            initialValue: 0,
            max: 5,
            min: 0,
          )) {
            case 0:
              return {
                Role.TOP: PlayerDetails('123456789', 'Player 1', []),
                Role.JG: PlayerDetails('2', 'Player 2', []),
                Role.MID: PlayerDetails('3', 'Player 3', []),
                Role.BOT: PlayerDetails('5', 'Player 4', []),
                Role.SUPP: PlayerDetails('5', 'Player 5', []),
              };
            case 1:
              return {
                Role.TOP: PlayerDetails('1', 'Player 1', []),
                Role.JG: PlayerDetails('2', 'Player 2', []),
                Role.MID: PlayerDetails('3', 'Player 3', []),
                Role.BOT: PlayerDetails('5', 'Player 4', []),
                Role.SUPP: null,
              };
            case 2:
              return {
                Role.TOP: PlayerDetails('1', 'Player 1', []),
                Role.JG: PlayerDetails('2', 'Player 2', []),
                Role.MID: PlayerDetails('3', 'Player 3', []),
                Role.BOT: null,
                Role.SUPP: null,
              };
            case 3:
              return {
                Role.TOP: PlayerDetails('1', 'Player 1', []),
                Role.MID: PlayerDetails('3', 'Player 3', []),
                Role.JG: null,
                Role.BOT: null,
                Role.SUPP: null,
              };
            case 4:
              return {
                Role.TOP: PlayerDetails('1', 'Player 1', []),
                Role.JG: null,
                Role.MID: null,
                Role.BOT: null,
                Role.SUPP: null,
              };
            case 5:
              return {
                Role.TOP: null,
                Role.JG: null,
                Role.MID: null,
                Role.BOT: null,
                Role.SUPP: null,
              };
            default:
              return {
                Role.TOP: PlayerDetails('1', 'Player 1', []),
                Role.JG: PlayerDetails('2', 'Player 2', []),
                Role.MID: PlayerDetails('3', 'Player 3', []),
                Role.SUPP: PlayerDetails('5', 'Player 5', []),
              };
          }
        }(),
        '123456789',
        DateTime.now(),
      ),
    ),
  );
}
