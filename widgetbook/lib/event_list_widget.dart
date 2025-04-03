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
import 'package:clashbot_flutter/stores/clash_events.store.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash_team.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/notification_handler.store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/utils/mock_utils.dart';

@UseCase(name: "Default", type: EventsListWidget)
Widget buildEventListWidget(BuildContext context) {
  var apiClient = ApiClient();
  var clashBotUser = ClashBotUser(
    discordId: "1",
    champions: [],
    role: Role.top,
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
      ClashTeamStore(
        '1',
        'Mock Team 1',
        'Mock Tournament 1',
        '1',
        ObservableMap.of({
          Role.top: PlayerDetails('1', []),
          Role.jg: PlayerDetails('2', []),
          Role.mid: PlayerDetails('3', []),
          Role.supp: PlayerDetails('5', []),
        }),
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
      NotificationHandlerStore(),
    ),
    NotificationHandlerStore(),
  );
  var mockDiscordDetailsStore = MockDiscordDetailsStore(
    buildGuilds(2),
    DiscordUser('1', 'Mock User', 'Mock#0001', 'avatar'),
    DiscordServiceImpl(setupOauth2Helper()),
    NotificationHandlerStore(),
  );
  var mockServers = buildMockServers(2);
  var applicationDetailsStore = MockApplicationDetailsStore(
    clashBotUser,
    mockServers,
    clashStoreW5Tournies,
    ClashEventsStore(clashStoreW5Tournies, NotificationHandlerStore()),
    mockDiscordDetailsStore,
    RiotChampionStore(RiotResourceServiceImpl(), NotificationHandlerStore()),
    NotificationHandlerStore(),
  );
  return EventsListWidget(
    clashStore: clashStoreW5Tournies,
    applicationDetailsStore: applicationDetailsStore,
    discordDetailStore: mockDiscordDetailsStore,
  );
}
