import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/enums/api_call_state.dart';
import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/services/clashbot_service_impl.dart';
import 'package:clashbot_flutter/services/discord_service_impl.dart';
import 'package:clashbot_flutter/services/riot_resources_service_impl.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash_team.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/notification_handler.store.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

// Import the widget from your app
import 'package:clashbot_flutter/pages/home/page/widgets/calendar_widget.dart';
import 'package:widgetbook_workspace/utils/mock_utils.dart';

@widgetbook.UseCase(name: 'Loading', type: CalendarWidget)
Widget buildCoolButtonUseCase(BuildContext context) {
  List<ClashTournament> tournaments = buildTournaments(1);
  List<ClashTeamStore> clashTeams = buildClashTeams(2);
  List<DiscordGuild> guilds = buildGuilds(1);
  CalendarWidgetDependencies calendarWidgetDependencies =
      buildCalendarWidgetDependencies(
        tournaments,
        clashTeams,
        guilds,
        ApiCallState.loading,
        ApiCallState.loading,
        ApiCallState.loading,
      );
  return CalendarWidget(
    focusedDay: DateTime.now(),
    selectedDay: DateTime.now(),
    clashStore: calendarWidgetDependencies.clashStore,
    discordDetailsStore: calendarWidgetDependencies.discordDetailsStore,
  );
}

@widgetbook.UseCase(name: 'Default', type: CalendarWidget)
Widget buildCalendarStory(BuildContext context) {
  int numberOfTournaments = context.knobs.int.slider(
    label: 'Number of Tournaments',
    min: 1,
    max: 10,
    initialValue: 1,
  );
  List<ClashTournament> tournaments = buildTournaments(numberOfTournaments);
  List<ClashTeamStore> clashTeams = buildClashTeams(2);
  List<DiscordGuild> guilds = buildGuilds(1);
  CalendarWidgetDependencies calendarWidgetDependencies =
      buildCalendarWidgetDependencies(
        tournaments,
        clashTeams,
        guilds,
        ApiCallState.success,
        ApiCallState.loading,
        ApiCallState.loading,
      );

  return CalendarWidget(
    focusedDay: DateTime.now(),
    selectedDay: DateTime.now(),
    clashStore: calendarWidgetDependencies.clashStore,
    discordDetailsStore: calendarWidgetDependencies.discordDetailsStore,
  );
}

@widgetbook.UseCase(name: 'Error', type: CalendarWidget)
Widget buildCalendarStoryError(BuildContext context) {
  int numberOfTournaments = context.knobs.int.slider(
    label: 'Number of Tournaments',
    min: 1,
    max: 10,
    initialValue: 1,
  );
  List<ClashTournament> tournaments = buildTournaments(numberOfTournaments);
  List<ClashTeamStore> clashTeams = buildClashTeams(2);
  List<DiscordGuild> guilds = buildGuilds(1);
  CalendarWidgetDependencies calendarWidgetDependencies =
      buildCalendarWidgetDependencies(
        tournaments,
        clashTeams,
        guilds,
        ApiCallState.error,
        ApiCallState.loading,
        ApiCallState.loading,
      );

  return CalendarWidget(
    focusedDay: DateTime.now(),
    selectedDay: DateTime.now(),
    clashStore: calendarWidgetDependencies.clashStore,
    discordDetailsStore: calendarWidgetDependencies.discordDetailsStore,
  );
}

class CalendarWidgetDependencies {
  final ClashStore clashStore;
  final DiscordDetailsStore discordDetailsStore;
  final RiotChampionStore riotChampionStore;
  final NotificationHandlerStore errorHandlerStore;

  CalendarWidgetDependencies(
    this.clashStore,
    this.discordDetailsStore,
    this.riotChampionStore,
    this.errorHandlerStore,
  );
}

CalendarWidgetDependencies buildCalendarWidgetDependencies(
  List<ClashTournament> tournaments,
  List<ClashTeamStore> clashTeams,
  List<DiscordGuild> guilds,
  ApiCallState tournamentsApiCallState,
  ApiCallState teamsApiCallState,
  ApiCallState userApiCallState,
) {
  DiscordDetailsStore discordDetailsStore = MockDiscordDetailsStore(
    guilds,
    DiscordUser('1', 'Mock User', 'icon', '1'),
    DiscordServiceImpl(setupOauth2Helper()),
    NotificationHandlerStore(),
  );
  var clashUser = ClashBotUser(
    discordId: "1",
    champions: [],
    role: Role.top,
    serverId: 'server1',
    selectedServers: ['server1'],
    preferredServers: ['server1', 'server2'],
  );
  var apiClient = ApiClient();
  ClashStore clashStore = MockClashStore(
    clashUser,
    tournaments,
    clashTeams,
    tournamentsApiCallState,
    teamsApiCallState,
    userApiCallState,
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
  clashStore.addCallInProgress('getTournaments');
  return CalendarWidgetDependencies(
    clashStore,
    discordDetailsStore,
    MockRiotChampionStore(
      RiotResourceServiceImpl(),
      NotificationHandlerStore(),
    ),
    NotificationHandlerStore(),
  );
}
