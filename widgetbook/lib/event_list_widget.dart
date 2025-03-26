import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/enums/api_call_state.dart';
import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/events_widget.dart';
import 'package:clashbot_flutter/services/clashbot_service_impl.dart';
import 'package:clashbot_flutter/services/discord_service_impl.dart';
import 'package:clashbot_flutter/services/riot_resources_service_impl.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/error_handler.store.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/utils/mock_utils.dart';

@UseCase(name: "Default", type: EventsListWidget)
Widget buildEventListWidget(BuildContext context) {
  var apiClient = ApiClient();
  var clashBotUser = ClashBotUser(
    discordId: "1",
    champions: [],
    role: Role.TOP,
    serverId: 'server1',
    selectedServers: ['server1'],
    preferredServers: ['server1', 'server2'],
  );
  ClashStore clashStoreW5Tournies = new MockClashStore(
    clashBotUser,
    [
      ClashTournament(
        'ARAM Clash',
        '1',
        DateTime.now(),
        DateTime.now().add(Duration(days: 1)),
      ),
      ClashTournament(
        'ARAM Clash',
        '2',
        DateTime.now(),
        DateTime.now().add(Duration(days: 1)),
      ),
      ClashTournament(
        'Summoner\'s Cup',
        '1',
        DateTime.now(),
        DateTime.now().add(Duration(days: 1)),
      ),
      ClashTournament(
        'Summoner\'s Cup',
        '2',
        DateTime.now(),
        DateTime.now().add(Duration(days: 1)),
      ),
      ClashTournament(
        'Summoner\'s Cup',
        '3',
        DateTime.now(),
        DateTime.now().add(Duration(days: 1)),
      ),
      ClashTournament(
        'Summoner\'s Cup',
        '4',
        DateTime.now(),
        DateTime.now().add(Duration(days: 1)),
      ),
    ],
    [
      ClashTeam(
        '1',
        'Mock Team 1',
        'Mock Tournament 1',
        '1',
        {
          Role.TOP: PlayerDetails('1', 'Player 1', []),
          Role.JG: PlayerDetails('2', 'Player 2', []),
          Role.MID: PlayerDetails('3', 'Player 3', []),
          Role.SUPP: PlayerDetails('5', 'Player 5', []),
        },
        '460520499680641035',
        DateTime.now(),
      ),
    ],
    ApiCallState.error,
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
  );
  var mockDiscordDetailsStore = MockDiscordDetailsStore(
    buildGuilds(2),
    DiscordUser('1', 'Mock User', 'Mock#0001', 'avatar'),
    DiscordServiceImpl(setupOauth2Helper()),
    ErrorHandlerStore(),
  );
  var mockServers = buildMockServers(2);
  var applicationDetailsStore = MockApplicationDetailsStore(
    clashBotUser,
    mockServers,
    clashStoreW5Tournies,
    mockDiscordDetailsStore,
    RiotChampionStore(RiotResourceServiceImpl(), ErrorHandlerStore()),
    ErrorHandlerStore(),
  );
  return EventsListWidget(
    clashStore: clashStoreW5Tournies,
    applicationDetailsStore: applicationDetailsStore,
    discordDetailStore: mockDiscordDetailsStore,
  );
}
