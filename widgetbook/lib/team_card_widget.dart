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
import 'package:clashbot_flutter/stores/clash_events.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash_team.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/notification_handler.store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';
import 'package:widgetbook_workspace/utils/mock_utils.dart';

@UseCase(name: "Default", type: TeamCard)
Widget buildTeamCardWidget(BuildContext context) {
  var clashUser = ClashBotUser(
    discordId: "1",
    champions: [],
    role: Role.top,
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
    NotificationHandlerStore(),
  );
  var mockClashStore = MockClashStore(
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
      NotificationHandlerStore(),
    ),
    NotificationHandlerStore(),
  );
  var mockApplicationDetailsStore = new MockApplicationDetailsStore(
    clashUser,
    mockServers,
    mockClashStore,
    ClashEventsStore(mockClashStore, NotificationHandlerStore()),
    mockDiscordDetailsStore,
    MockRiotChampionStore(
      RiotResourceServiceImpl(),
      NotificationHandlerStore(),
    ),
    NotificationHandlerStore(),
  );
  return Center(
    child: TeamCard(
      applicationDetailsStore: mockApplicationDetailsStore,
      discordDetailsStore: mockDiscordDetailsStore,
      team: ClashTeamStore(
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
              return ObservableMap.of({
                Role.top: PlayerDetails('123456789', []),
                Role.jg: PlayerDetails('2', []),
                Role.mid: PlayerDetails('3', []),
                Role.bot: PlayerDetails('5', []),
                Role.supp: PlayerDetails('5', []),
              });
            case 1:
              return ObservableMap.of({
                Role.top: PlayerDetails('1', []),
                Role.jg: PlayerDetails('2', []),
                Role.mid: PlayerDetails('3', []),
                Role.bot: PlayerDetails('5', []),
                Role.supp: null,
              });
            case 2:
              return ObservableMap.of({
                Role.top: PlayerDetails('1', []),
                Role.jg: PlayerDetails('2', []),
                Role.mid: PlayerDetails('3', []),
                Role.bot: null,
                Role.supp: null,
              });
            case 3:
              return ObservableMap.of({
                Role.top: PlayerDetails('1', []),
                Role.mid: PlayerDetails('3', []),
                Role.jg: null,
                Role.bot: null,
                Role.supp: null,
              });
            case 4:
              return ObservableMap.of({
                Role.top: PlayerDetails('1', []),
                Role.mid: null,
                Role.jg: null,
                Role.bot: null,
                Role.supp: null,
              });
            case 5:
              return ObservableMap.of({
                Role.top: null,
                Role.mid: null,
                Role.jg: null,
                Role.bot: null,
                Role.supp: null,
              });
            default:
              return ObservableMap.of({
                Role.top: PlayerDetails('1', []),
                Role.jg: PlayerDetails('2', []),
                Role.mid: PlayerDetails('3', []),
                Role.supp: PlayerDetails('5', []),
              });
          }
        }(),
        '123456789',
        DateTime.now(),
      ),
    ),
  );
}
