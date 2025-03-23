import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/pages/errorPages/whoops_page.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/calendar_widget.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/team_card.dart';
import 'package:clashbot_flutter/services/clashbot_service_impl.dart';
import 'package:clashbot_flutter/services/discord_service_impl.dart';
import 'package:clashbot_flutter/services/riot_resources_service_impl.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/error_handler.store.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class MockApplicationDetailsStore extends ApplicationDetailsStore {
  MockApplicationDetailsStore(
      ClashBotUser mockClashBotUser,
      super._clashStore,
      super._discordDetailsStore,
      super._riotChampionStore,
      super._errorHandlerStore);

  @override
  ClashBotUser get clashBotUser => ClashBotUser(
        discordId: '123456789',
        champions: [],
        role: Role.TOP,
        serverId: 'server1',
        selectedServers: [
          'server1',
        ],
        preferredServers: ['server1', 'server2'],
      );
}

class MockDiscordDetailsStore extends DiscordDetailsStore {
  MockDiscordDetailsStore(List<DiscordGuild> guilds, DiscordUser user,
      super.discordService, super._errorHandlerStore);
}

class MockClashStore extends ClashStore {
  MockClashStore(
      ClashBotUser clashBotUser,
      List<ClashTournament> tournaments,
      List<ClashTeam> clashTeams,
      super._clashService,
      super._errorhandlerStore);
}

class MockRiotChampionStore extends RiotChampionStore {
  MockRiotChampionStore(super._riotResourcesService, super._errorHandlerStore);
}

void main() {
  var loggedInUserId = '123456789';
  var clashUser = ClashBotUser(
    discordId: loggedInUserId,
    champions: [],
    role: Role.TOP,
    serverId: 'server1',
    selectedServers: [
      'server1',
    ],
    preferredServers: ['server1', 'server2'],
  );
  var guilds = [
    DiscordGuild('1', 'Mock Guild 1', '123456789', false),
    DiscordGuild('2', 'Mock Guild 2', '123456789', false),
  ];
  var tournaments = [
    ClashTournament('1', 'Mock Tournament 1', DateTime.now(), DateTime.now()),
    ClashTournament('2', 'Mock Tournament 2', DateTime.now(), DateTime.now()),
  ];
  var clashTeams = [
    ClashTeam(
      '1',
      'Mock Team 1',
      tournaments[0].tournamentName,
      tournaments[0].tournamentDay,
      {
        Role.TOP: PlayerDetails('1', 'Player 1', []),
        Role.JG: PlayerDetails('2', 'Player 2', []),
        Role.MID: PlayerDetails('3', 'Player 3', []),
        Role.SUPP: PlayerDetails('5', 'Player 5', []),
      },
      '123456789',
      DateTime.now(),
    ),
    ClashTeam(
      '2',
      'Mock Team 2',
      tournaments[0].tournamentName,
      tournaments[0].tournamentDay,
      {
        Role.TOP: PlayerDetails('1', 'Player 1', []),
        Role.JG: PlayerDetails('2', 'Player 2', []),
        Role.MID: PlayerDetails('3', 'Player 3', []),
        Role.SUPP: PlayerDetails('5', 'Player 5', []),
      },
      '123456789',
      DateTime.now(),
    ),
  ];
  var discordUser = DiscordUser(
      loggedInUserId, 'mock_username', '123456789', "mock_discriminator");
  runApp(MultiProvider(providers: [
    Provider<ApiClient>(create: (_) => ApiClient(basePath: "http://localhost")),
    Provider<ErrorHandlerStore>(create: (_) => ErrorHandlerStore()),
    ProxyProvider<ErrorHandlerStore, DiscordDetailsStore>(
        update: (_, errorHandlerStore, __) {
      return MockDiscordDetailsStore(guilds, discordUser,
          DiscordServiceImpl(setupOauth2Helper()), errorHandlerStore);
    }),
    ProxyProvider<ErrorHandlerStore, RiotChampionStore>(
        update: (_, errorHandlerStore, __) => MockRiotChampionStore(
            RiotResourceServiceImpl(), errorHandlerStore)),
    ProxyProvider2<ErrorHandlerStore, ApiClient, ClashStore>(
        update: (_, errorHandlerStore, apiClient, __) => MockClashStore(
            clashUser,
            tournaments,
            clashTeams,
            ClashBotServiceImpl(
                UserApi(apiClient),
                TeamApi(apiClient),
                ChampionsApi(apiClient),
                SubscriptionApi(apiClient),
                TentativeApi(apiClient),
                TournamentApi(apiClient),
                errorHandlerStore),
            errorHandlerStore)),
    ProxyProvider4<ClashStore, ErrorHandlerStore, DiscordDetailsStore,
            RiotChampionStore, ApplicationDetailsStore>(
        update: (_, clashStore, errorHandlerStore, discordDetailsStore,
                riotChampionStore, __) =>
            MockApplicationDetailsStore(clashUser, clashStore,
                discordDetailsStore, riotChampionStore, errorHandlerStore)),
  ], child: ClashBotStorybookApp()));
}

class ClashBotStorybookApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Storybook(initialStory: "4Filled", stories: [
      StoryCalendarWidgetWTournaments(context),
      StoryCalendarWidgetWTournamentsLoading(context),
      StoryTeamCard(),
      WhoopsPageStory()
    ]);
  }

  Story StoryTeamCard() {
    return Story(
        name: "4Filled",
        description: "A card for displaying team information",
        builder: (context) {
          return TeamCard(
              team: ClashTeam(
            '1',
            'Mock Team',
            'Tournament 1',
            '1',
            () {
              switch (context.knobs
                  .text(label: '# of missing roles', initial: '0')) {
                case '0':
                  return {
                    Role.TOP: PlayerDetails('123456789', 'Player 1', []),
                    Role.JG: PlayerDetails('2', 'Player 2', []),
                    Role.MID: PlayerDetails('3', 'Player 3', []),
                    Role.BOT: PlayerDetails('5', 'Player 4', []),
                    Role.SUPP: PlayerDetails('5', 'Player 5', []),
                  };
                case '1':
                  return {
                    Role.TOP: PlayerDetails('1', 'Player 1', []),
                    Role.JG: PlayerDetails('2', 'Player 2', []),
                    Role.MID: PlayerDetails('3', 'Player 3', []),
                    Role.BOT: PlayerDetails('5', 'Player 4', []),
                    Role.SUPP: null,
                  };
                case '2':
                  return {
                    Role.TOP: PlayerDetails('1', 'Player 1', []),
                    Role.JG: PlayerDetails('2', 'Player 2', []),
                    Role.MID: PlayerDetails('3', 'Player 3', []),
                    Role.BOT: null,
                    Role.SUPP: null,
                  };
                case '3':
                  return {
                    Role.TOP: PlayerDetails('1', 'Player 1', []),
                    Role.MID: PlayerDetails('3', 'Player 3', []),
                    Role.JG: null,
                    Role.BOT: null,
                    Role.SUPP: null,
                  };
                case '4':
                  return {
                    Role.TOP: PlayerDetails('1', 'Player 1', []),
                    Role.JG: null,
                    Role.MID: null,
                    Role.BOT: null,
                    Role.SUPP: null,
                  };
                case '5':
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
          ));
        });
  }

  Story WhoopsPageStory() {
    return Story(
      name: "WhoopsPage",
      description: "A page for that the app is not usable.",
      builder: (context) {
        return const WhoopsPage();
      },
    );
  }

  Story StoryCalendarWidgetWTournamentsLoading(BuildContext context) {
    DiscordDetailsStore discordDetailsStore =
        context.read<DiscordDetailsStore>();
    ClashStore clashStoreW5Tournies = new MockClashStore(
        context.read<ApplicationDetailsStore>().clashBotUser,
        [
          ClashTournament('1', 'Mock Tournament 1', DateTime.now(),
              DateTime.now().add(Duration(days: 1))),
          ClashTournament('2', 'Mock Tournament 2', DateTime.now(),
              DateTime.now().add(Duration(days: 1))),
          ClashTournament('3', 'Mock Tournament 3', DateTime.now(),
              DateTime.now().add(Duration(days: 1))),
          ClashTournament('4', 'Mock Tournament 4', DateTime.now(),
              DateTime.now().add(Duration(days: 1))),
          ClashTournament('5', 'Mock Tournament 5', DateTime.now(),
              DateTime.now().add(Duration(days: 1))),
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
            '123456789',
            DateTime.now(),
          )
        ],
        new ClashBotServiceImpl(
            new UserApi(context.read<ApiClient>()),
            new TeamApi(context.read<ApiClient>()),
            new ChampionsApi(context.read<ApiClient>()),
            new SubscriptionApi(context.read<ApiClient>()),
            new TentativeApi(context.read<ApiClient>()),
            new TournamentApi(context.read<ApiClient>()),
            new ErrorHandlerStore()),
        context.read<ErrorHandlerStore>());
    clashStoreW5Tournies.addCallInProgress('getTournaments');
    return Story(
      name: "Widgets/Calendar/loading",
      description: "ClashBot's main calendar widget loading",
      builder: (context) {
        return CalendarWidget(
            focusedDay: DateTime.now(),
            selectedDay: DateTime.now(),
            clashStore: clashStoreW5Tournies,
            discordDetailsStore: discordDetailsStore);
      },
    );
  }
}

Story StoryCalendarWidgetWTournaments(BuildContext context) {
  DiscordDetailsStore discordDetailsStore = context.read<DiscordDetailsStore>();
  ClashStore clashStoreW5Tournies = new MockClashStore(
      context.read<ApplicationDetailsStore>().clashBotUser,
      [
        ClashTournament('1', 'Mock Tournament 1', DateTime.now(),
            DateTime.now().add(Duration(days: 1))),
        ClashTournament('2', 'Mock Tournament 2', DateTime.now(),
            DateTime.now().add(Duration(days: 1))),
        ClashTournament('3', 'Mock Tournament 3', DateTime.now(),
            DateTime.now().add(Duration(days: 1))),
        ClashTournament('4', 'Mock Tournament 4', DateTime.now(),
            DateTime.now().add(Duration(days: 1))),
        ClashTournament('5', 'Mock Tournament 5', DateTime.now(),
            DateTime.now().add(Duration(days: 1))),
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
        )
      ],
      new ClashBotServiceImpl(
          new UserApi(context.read<ApiClient>()),
          new TeamApi(context.read<ApiClient>()),
          new ChampionsApi(context.read<ApiClient>()),
          new SubscriptionApi(context.read<ApiClient>()),
          new TentativeApi(context.read<ApiClient>()),
          new TournamentApi(context.read<ApiClient>()),
          new ErrorHandlerStore()),
      context.read<ErrorHandlerStore>());
  return Story(
    name: "Widgets/Calendar/filled",
    description: "ClashBot's main calendar widget filled",
    builder: (context) {
      return CalendarWidget(
          focusedDay: DateTime.now(),
          selectedDay: DateTime.now(),
          clashStore: clashStoreW5Tournies,
          discordDetailsStore: discordDetailsStore);
    },
  );
}
