import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/enums/api_call_state.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/calendar_widget.dart';
import 'package:clashbot_flutter/services/clashbot_service_impl.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/error_handler.store.dart';
import 'package:clashbot_flutter/storybook_main.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

Story StoryCalendarWidgetWTournamentsLoading(BuildContext context) {
  DiscordDetailsStore discordDetailsStore = context.read<DiscordDetailsStore>();
  ClashStore clashStoreW5Tournies = new MockClashStore(
      context.read<ApplicationDetailsStore>().clashBotUser,
      [
        ClashTournament('ARAM Clash', '1', DateTime.now(),
            DateTime.now().add(Duration(days: 1))),
        ClashTournament('ARAM Clash', '2', DateTime.now(),
            DateTime.now().add(Duration(days: 1))),
        ClashTournament('Summoner\'s Cup', '1', DateTime.now(),
            DateTime.now().add(Duration(days: 1))),
        ClashTournament('Summoner\'s Cup', '2', DateTime.now(),
            DateTime.now().add(Duration(days: 1)))
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
      ApiCallState.loading,
      ApiCallState.loading,
      ApiCallState.loading,
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
      ApiCallState.success,
      ApiCallState.success,
      ApiCallState.success,
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

Story StoryCalendarWidgetFailedToFetchTournaments(BuildContext context) {
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
      ApiCallState.error,
      ApiCallState.success,
      ApiCallState.success,
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
    name: "Widgets/Calendar/failedToFetchTournaments",
    description: "Failed to fetch tournaments",
    builder: (context) {
      return CalendarWidget(
          focusedDay: DateTime.now(),
          selectedDay: DateTime.now(),
          clashStore: clashStoreW5Tournies,
          discordDetailsStore: discordDetailsStore);
    },
  );
}
