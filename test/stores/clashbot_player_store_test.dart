import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/services/clashbot_service.dart';
import 'package:clashbot_flutter/services/discord_service.dart';
import 'package:clashbot_flutter/services/riot_resources_service.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/clashbot_player.store.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart' as mockito;

import 'clashbot_player_store_test.mocks.dart';

// Fake class
class ClashBotServiceMock extends Fake implements ClashBotService {}

// Fake class
class ApplicationDetailsStoreMock extends Fake
    implements ApplicationDetailsStore {}

// Fake class
class DiscordServiceMock extends Fake implements DiscordService {}

// Fake class
class RiotResourcesServiceMock extends Fake implements RiotResourcesService {}

@GenerateMocks([
  ClashBotService,
  ApplicationDetailsStore,
  DiscordServiceMock,
  RiotResourcesServiceMock
])
void main() {
  late ClashBotService clashBotService;
  late ApplicationDetailsStore applicationDetailsStore;
  late DiscordService discordService;
  late RiotResourcesService resourcesService;

  setUp(() {});

  group('Clash Player Store', () {
    test('Test computed list of Clash Teams', () async {
      // Create mock object.
      clashBotService = MockClashBotService();
      discordService = DiscordServiceMock();
      resourcesService = RiotResourcesServiceMock();
      applicationDetailsStore = MockApplicationDetailsStore();
      mockito.when(applicationDetailsStore.id).thenReturn("1");
      final clashPlayerStore =
          ClashPlayerStore(clashBotService, applicationDetailsStore);
      clashPlayerStore.selectedServers = ObservableList.of(["0"]);
      var list = List.of([
        ClashTeam("1", "Some Name", "Awesome Sauce", "1",
            {Role.TOP: PlayerDetails("123", "", [])}, "1234", DateTime.now())
      ]);
      mockito
          .when(clashBotService.getClashTeams("1", []))
          .thenAnswer((_) async => list);
      await clashPlayerStore.refreshTeamList();
      expect(clashPlayerStore.numberOfTeams, 1);
    });

    test('Test computed Map for ClashTeams to Servers', () async {
      // Create mock object.
      clashBotService = MockClashBotService();
      discordService = DiscordServiceMock();
      resourcesService = RiotResourcesServiceMock();
      applicationDetailsStore = MockApplicationDetailsStore();
      mockito.when(applicationDetailsStore.id).thenReturn("1");
      final clashPlayerStore =
          ClashPlayerStore(clashBotService, applicationDetailsStore);
      clashPlayerStore.selectedServers = ObservableList.of(["0"]);
      var clashTeam = ClashTeam(
          "1", "Some Name", "Awesome Sauce", "1", {Role.TOP: PlayerDetails("123", "", [])}, "1234", DateTime.now());
      var list = List.of([clashTeam]);
      mockito
          .when(clashBotService.getClashTeams("1", []))
          .thenAnswer((_) async => list);
      await clashPlayerStore.refreshTeamList();
      expect(clashPlayerStore.mapOfClashTeamsToServer.length, 1);
      expect(clashPlayerStore.mapOfClashTeamsToServer["1234"], list);
    });

    test('Test - computed list of Clash teams that are filtered by Server id',
        () async {
      // Create mock object.
      clashBotService = MockClashBotService();
      discordService = DiscordServiceMock();
      resourcesService = RiotResourcesServiceMock();
      applicationDetailsStore = MockApplicationDetailsStore();
      mockito.when(applicationDetailsStore.id).thenReturn("1");
      final clashPlayerStore =
          ClashPlayerStore(clashBotService, applicationDetailsStore);
      clashPlayerStore.selectedServers = ObservableList.of(["0"]);
      var clashTeamOneServer1 = ClashTeam(
          "1", "Some Name", "Awesome Sauce", "1", {Role.TOP: PlayerDetails("123", "", [])}, "1234", DateTime.now());
      var clashTeamTwoServer2 = ClashTeam(
          "1", "Some Name", "Awesome Sauce", "1", {Role.TOP: PlayerDetails("123", "", [])}, "12345", DateTime.now());
      var clashTeamThreeServer1 = ClashTeam(
          "1", "Some Name", "Awesome Sauce", "1", {Role.TOP: PlayerDetails("123", "", [])}, "1234", DateTime.now());
      var clashTeamFourServer2 = ClashTeam(
          "2", "Some Name", "Awesome Sauce", "1", {Role.TOP: PlayerDetails("123", "", [])}, "12345", DateTime.now());
      var list = List.of([
        clashTeamOneServer1,
        clashTeamTwoServer2,
        clashTeamThreeServer1,
        clashTeamFourServer2
      ]);

      var expectedList = [...list];
      expectedList =
          expectedList.where((team) => team.serverId == "12345").toList();
      mockito
          .when(clashBotService.getClashTeams("1", []))
          .thenAnswer((_) async => list);
      clashPlayerStore.filterByServer("12345");
      await clashPlayerStore.refreshTeamList();
      expect(clashPlayerStore.filteredTeamsList.length, 2);
      expect(clashPlayerStore.filteredTeamsList, expectedList);
    });

    test(
        'Test - computed list of Clash teams that are filtered by Tournament Name',
        () async {
      // Create mock object.
      clashBotService = MockClashBotService();
      discordService = DiscordServiceMock();
      resourcesService = RiotResourcesServiceMock();
      applicationDetailsStore = MockApplicationDetailsStore();
      mockito.when(applicationDetailsStore.id).thenReturn("1");
      final clashPlayerStore =
          ClashPlayerStore(clashBotService, applicationDetailsStore);
      clashPlayerStore.selectedServers = ObservableList.of(["0"]);
      var clashTeamOneTournament1 = ClashTeam(
          "1", "Some Name", "Awesome Sauce", "1", {Role.TOP: PlayerDetails("123", "", [])}, "1234", DateTime.now());
      var clashTeamTwoTournament1 = ClashTeam(
          "1", "Some Name", "Awesome Sauce", "1", {Role.TOP: PlayerDetails("123", "", [])}, "1234", DateTime.now());
      var clashTeamThreeTournament2 = ClashTeam(
          "1", "Some Name", "Not so Awesome", "1", {}, "1234", DateTime.now());
      var clashTeamFourTournament1 = ClashTeam(
          "2", "Some Name", "Awesome Sauce", "1", {Role.TOP: PlayerDetails("123", "", [])}, "1234", DateTime.now());
      var list = List.of([
        clashTeamOneTournament1,
        clashTeamTwoTournament1,
        clashTeamThreeTournament2,
        clashTeamFourTournament1
      ]);

      var expectedList = [...list];
      expectedList = expectedList
          .where((team) => team.tournamentName == "Awesome Sauce")
          .toList();
      mockito
          .when(clashBotService.getClashTeams("1", []))
          .thenAnswer((_) async => list);
      clashPlayerStore.filterByTournamentName("Awesome Sauce");
      await clashPlayerStore.refreshTeamList();
      expect(clashPlayerStore.filteredTeamsList.length, 3);
      expect(clashPlayerStore.filteredTeamsList, expectedList);
    });

    test(
        'Test - computed list of Clash teams that are filtered by Server id and Tournament Name',
        () async {
      // Create mock object.
      clashBotService = MockClashBotService();
      discordService = DiscordServiceMock();
      resourcesService = RiotResourcesServiceMock();
      applicationDetailsStore = MockApplicationDetailsStore();
      mockito.when(applicationDetailsStore.id).thenReturn("1");
      final clashPlayerStore =
          ClashPlayerStore(clashBotService, applicationDetailsStore);
      clashPlayerStore.selectedServers = ObservableList.of(["0"]);
      var clashTeamOneServer1 = ClashTeam(
          "1", "Some Name", "Awesome Sauce", "1", {}, "1234", DateTime.now());
      var clashTeamTwoServer2 = ClashTeam(
          "1", "Some Name", "Not so Awesome", "1", {Role.TOP: PlayerDetails("123", "", [])}, "12345", DateTime.now());
      var clashTeamThreeServer1 = ClashTeam(
          "1", "Some Name", "Not so Awesome", "1", {}, "1234", DateTime.now());
      var clashTeamFourServer2 = ClashTeam(
          "2", "Some Name", "Awesome Sauce", "1", {}, "12345", DateTime.now());
      var list = List.of([
        clashTeamOneServer1,
        clashTeamTwoServer2,
        clashTeamThreeServer1,
        clashTeamFourServer2
      ]);

      var expectedList = [...list];
      expectedList = expectedList
          .where((team) =>
              team.serverId == "12345" &&
              team.tournamentName == "Not so Awesome")
          .toList();
      mockito
          .when(clashBotService.getClashTeams("1", []))
          .thenAnswer((_) async => list);
      clashPlayerStore.filterByServer("12345");
      clashPlayerStore.filterByTournamentName("Not so Awesome");
      await clashPlayerStore.refreshTeamList();
      expect(clashPlayerStore.filteredTeamsList.length, 1);
      expect(clashPlayerStore.filteredTeamsList, expectedList);
    });

    test(
        'Test - computed list of Clash teams that are filtered by Tournament Day',
        () async {
      // Create mock object.
      clashBotService = MockClashBotService();
      discordService = DiscordServiceMock();
      resourcesService = RiotResourcesServiceMock();
      applicationDetailsStore = MockApplicationDetailsStore();
      mockito.when(applicationDetailsStore.id).thenReturn("1");
      final clashPlayerStore =
          ClashPlayerStore(clashBotService, applicationDetailsStore);
      clashPlayerStore.selectedServers = ObservableList.of(["0"]);
      var clashTeamOneServer1 = ClashTeam(
          "1", "Some Name", "Awesome Sauce", "1", {Role.TOP: PlayerDetails("123", "", [])}, "1234", DateTime.now());
      var clashTeamTwoServer2 = ClashTeam(
          "1", "Some Name", "Not so Awesome", "2", {}, "12345", DateTime.now());
      var clashTeamThreeServer1 = ClashTeam(
          "1", "Some Name", "Not so Awesome", "3", {}, "1234", DateTime.now());
      var clashTeamFourServer2 = ClashTeam(
          "2", "Some Name", "Awesome Sauce", "1", {Role.TOP: PlayerDetails("123", "", [])}, "12345", DateTime.now());
      var list = List.of([
        clashTeamOneServer1,
        clashTeamTwoServer2,
        clashTeamThreeServer1,
        clashTeamFourServer2
      ]);

      var expectedList = [...list];
      expectedList =
          expectedList.where((team) => team.tournamentDay == "1").toList();
      mockito
          .when(clashBotService.getClashTeams("1", []))
          .thenAnswer((_) async => list);
      clashPlayerStore.filterByTournamentDay("1");
      await clashPlayerStore.refreshTeamList();
      expect(clashPlayerStore.filteredTeamsList.length, 2);
      expect(clashPlayerStore.filteredTeamsList, expectedList);
    });
  });
}
