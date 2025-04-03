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
import 'package:clashbot_flutter/stores/clash_events.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash_team.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/notification_handler.store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

class MockApplicationDetailsStore extends ApplicationDetailsStore {
  MockApplicationDetailsStore(
      ClashBotUser mockClashBotUser,
      super._clashEventsStore,
      super._clashStore,
      super._discordDetailsStore,
      super._riotChampionStore,
      super._errorHandlerStore);

  @override
  ClashBotUser get clashBotUser => ClashBotUser(
        discordId: '123456789',
        champions: [],
        role: Role.top,
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
    role: Role.top,
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
        Role.top: PlayerDetails('1', []),
        Role.jg: PlayerDetails('2', []),
        Role.mid: PlayerDetails('3', []),
        Role.supp: PlayerDetails('5', []),
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
        Role.top: PlayerDetails('1', []),
        Role.jg: PlayerDetails('2', []),
        Role.mid: PlayerDetails('3', []),
        Role.supp: PlayerDetails('5', []),
      },
      '123456789',
      DateTime.now(),
    ),
  ];
  var discordUser = DiscordUser(
      loggedInUserId, 'mock_username', '123456789', "mock_discriminator");
  runApp(MultiProvider(providers: [
    Provider<ApiClient>(create: (_) => ApiClient(basePath: "http://localhost")),
    Provider<NotificationHandlerStore>(
        create: (_) => NotificationHandlerStore()),
    ProxyProvider<NotificationHandlerStore, DiscordDetailsStore>(
        update: (_, errorHandlerStore, __) {
      return MockDiscordDetailsStore(guilds, discordUser,
          DiscordServiceImpl(setupOauth2Helper()), errorHandlerStore);
    }),
    ProxyProvider<NotificationHandlerStore, RiotChampionStore>(
        update: (_, errorHandlerStore, __) => MockRiotChampionStore(
            RiotResourceServiceImpl(), errorHandlerStore)),
    ProxyProvider2<ClashStore, NotificationHandlerStore, ClashEventsStore>(
        update: (_, clashStore, errorHandlerStore, __) =>
            ClashEventsStore(clashStore, errorHandlerStore)),
    ProxyProvider2<NotificationHandlerStore, ApiClient, ClashStore>(
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
    ProxyProvider5<ClashStore, ClashEventsStore, NotificationHandlerStore,
            DiscordDetailsStore, RiotChampionStore, ApplicationDetailsStore>(
        update: (_, clashStore, clashEventsStore, errorHandlerStore,
                discordDetailsStore, riotChampionStore, __) =>
            MockApplicationDetailsStore(clashUser, clashStore, clashEventsStore,
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
              team: ClashTeamStore(
            '1',
            'Mock Team',
            'Tournament 1',
            '1',
            () {
              switch (context.knobs
                  .text(label: '# of missing roles', initial: '0')) {
                case '0':
                  return ObservableMap<Role, PlayerDetails?>.of({
                    Role.top: PlayerDetails('123456789', []),
                    Role.jg: PlayerDetails('2', []),
                    Role.mid: PlayerDetails('3', []),
                    Role.bot: PlayerDetails('5', []),
                    Role.supp: PlayerDetails('5', []),
                  });
                case '1':
                  return ObservableMap<Role, PlayerDetails?>.of({
                    Role.top: PlayerDetails('1', []),
                    Role.jg: PlayerDetails('2', []),
                    Role.mid: PlayerDetails('3', []),
                    Role.bot: PlayerDetails('5', []),
                    Role.supp: null,
                  });
                case '2':
                  return ObservableMap<Role, PlayerDetails?>.of({
                    Role.top: PlayerDetails('1', []),
                    Role.jg: PlayerDetails('2', []),
                    Role.mid: PlayerDetails('3', []),
                    Role.bot: null,
                    Role.supp: null,
                  });
                case '3':
                  return ObservableMap<Role, PlayerDetails?>.of({
                    Role.top: PlayerDetails('1', []),
                    Role.mid: PlayerDetails('3', []),
                    Role.jg: null,
                    Role.bot: null,
                    Role.supp: null,
                  });
                case '4':
                  return ObservableMap<Role, PlayerDetails?>.of({
                    Role.top: PlayerDetails('1', []),
                    Role.jg: null,
                    Role.mid: null,
                    Role.bot: null,
                    Role.supp: null,
                  });
                case '5':
                  return ObservableMap<Role, PlayerDetails?>.of({
                    Role.top: null,
                    Role.jg: null,
                    Role.mid: null,
                    Role.bot: null,
                    Role.supp: null,
                  });
                default:
                  return ObservableMap<Role, PlayerDetails?>.of({
                    Role.top: PlayerDetails('1', []),
                    Role.jg: PlayerDetails('2', []),
                    Role.mid: PlayerDetails('3', []),
                    Role.supp: PlayerDetails('5', []),
                  });
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
              Role.top: PlayerDetails('1', []),
              Role.jg: PlayerDetails('2', []),
              Role.mid: PlayerDetails('3', []),
              Role.supp: PlayerDetails('5', []),
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
            new NotificationHandlerStore()),
        context.read<NotificationHandlerStore>());
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
            Role.top: PlayerDetails('1', []),
            Role.jg: PlayerDetails('2', []),
            Role.mid: PlayerDetails('3', []),
            Role.supp: PlayerDetails('5', []),
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
          new NotificationHandlerStore()),
      context.read<NotificationHandlerStore>());
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
