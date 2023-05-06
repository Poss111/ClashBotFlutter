import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/tentative_queue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Tentative Queue", () {
    test('Test TeamPlayer to PlayerDetails mapping', () async {
      var tentative = Tentative(id: "tq-1234", serverId: "1234", tournamentDetails: BaseTournament(tournamentName: "awesome_sauce", tournamentDay: "1"), tentativePlayers: [TentativePlayer(
        discordId: "1",
      )]);
      var expectedTentativeQueue = TentativeQueue("tq-1234", "1234", "awesome_sauce", "1", ["1"], DateTime.now());
      var actualTentativeQueue = TentativeQueue.tentativeToTentativeQueue(tentative);
      expect(actualTentativeQueue, expectedTentativeQueue);
    });
  });
}
