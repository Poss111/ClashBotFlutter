import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Player Details", () {
    test('Test TeamPlayer to PlayerDetails mapping', () async {
      var teamPlayer = TeamPlayer(
          discordId: '123', champions: List.of([Champion(name: 'Aatrox')]));
      var expectedPlayerDetails = PlayerDetails("123", ['Aatrox']);
      expect(PlayerDetails.teamPlayerDetailsToPlayerDetails(teamPlayer),
          expectedPlayerDetails);
    });
  });

  group("Clash Team", () {
    test('Test Team to ClashTeam mapping', () async {
      var teamPlayer = TeamPlayer(
          discordId: '123', champions: List.of([Champion(name: 'Aatrox')]));
      var team = Team(
          id: "ct-123-123-123",
          name: 'Some Team Name',
          serverId: '123',
          tournament: BaseTournament(
              tournamentName: 'awesome_sauce', tournamentDay: '1'),
          lastUpdatedAt: DateTime(2023, 2, 1, 12, 51, 0, 0, 0),
          playerDetails: TeamPlayerDetails(top: teamPlayer));
      var expectedPlayerDetails = PlayerDetails("123", ['Aatrox']);
      var expectedClashTeam = ClashTeam(
          'ct-123-123-123',
          'Some Team Name',
          'awesome_sauce',
          '1',
          {Role.top: expectedPlayerDetails},
          '123',
          DateTime.now());
      expect(ClashTeam.teamToClashTeam(team), expectedClashTeam);
    });
    test('No Players - Test Team to ClashTeam mapping', () async {
      var team = Team(
          id: "ct-123-123-123",
          name: 'Some Team Name',
          serverId: '123',
          tournament: BaseTournament(
              tournamentName: 'awesome_sauce', tournamentDay: '1'));
      var expectedClashTeam = ClashTeam(
          'ct-123-123-123',
          'Some Team Name',
          'awesome_sauce',
          '1',
          {},
          '123',
          DateTime(2023, 2, 1, 12, 51, 0, 0, 0));
      expect(ClashTeam.teamToClashTeam(team), expectedClashTeam);
    });

    test('All Players - Test Team to ClashTeam mapping', () async {
      var topPlayer = TeamPlayer(
          discordId: '123', champions: List.of([Champion(name: 'Aatrox')]));
      var jgPlayer = TeamPlayer(
          discordId: '124', champions: List.of([Champion(name: 'Nocturn')]));
      var midPlayer = TeamPlayer(
          discordId: '125', champions: List.of([Champion(name: 'Anivia')]));
      var botPlayer = TeamPlayer(
          discordId: '126', champions: List.of([Champion(name: 'Jhin')]));
      var suppPlayer = TeamPlayer(
          discordId: '127', champions: List.of([Champion(name: 'Karma')]));
      var team = Team(
          id: "ct-123-123-123",
          name: 'Some Team Name',
          serverId: '123',
          tournament: BaseTournament(
              tournamentName: 'awesome_sauce', tournamentDay: '1'),
          playerDetails: TeamPlayerDetails(
              top: topPlayer,
              jg: jgPlayer,
              mid: midPlayer,
              bot: botPlayer,
              supp: suppPlayer));
      var expectedTopPlayerDetails = PlayerDetails("123", ['Aatrox']);
      var expectedJgPlayerDetails = PlayerDetails("124", ['Nocturn']);
      var expectedMidPlayerDetails = PlayerDetails("125", ['Anivia']);
      var expectedBotPlayerDetails = PlayerDetails("126", ['Jhin']);
      var expectedSuppPlayerDetails = PlayerDetails("127", ['Karma']);
      var expectedClashTeam = ClashTeam(
          'ct-123-123-123',
          'Some Team Name',
          'awesome_sauce',
          '1',
          {
            Role.top: expectedTopPlayerDetails,
            Role.jg: expectedJgPlayerDetails,
            Role.mid: expectedMidPlayerDetails,
            Role.bot: expectedBotPlayerDetails,
            Role.supp: expectedSuppPlayerDetails
          },
          '123',
          DateTime.now());
      expect(ClashTeam.teamToClashTeam(team), expectedClashTeam);
    });
  });
}
