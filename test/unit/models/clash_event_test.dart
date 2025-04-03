import 'package:clashbot_flutter/models/clash_bot_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clashbot_flutter/models/clash_event.dart';
import 'package:clash_bot_api/api.dart';

void main() {
  group('ClashEvent', () {
    test('fromJson creates a valid ClashEvent object', () {
      const data = '''
        {
            "id": "ct-91ca1a97-054f-4e29-bdab-714f865293ba",
            "serverId": "123456",
            "summary": "Team created",
            "causedBy": null,
            "payload": {
                "id": "ct-91ca1a97-054f-4e29-bdab-714f865293ba",
                "serverId": "123456",
                "lastUpdatedAt": "2025-03-30T22:50:37.217685-05:00",
                "name": "Some Team 2",
                "playerDetails": {
                    "top": {
                        "discordId": "1",
                        "champions": []
                    },
                    "jg": null,
                    "mid": null,
                    "bot": {
                        "discordId": "2",
                        "champions": []
                    },
                    "supp": null
                },
                "tournament": {
                    "name": "ARAM",
                    "day": "2"
                }
            },
            "eventType": "TEAM_CREATE"
        }
      ''';

      final clashEvent = ClashTeamEvent.fromJsonString(data);

      expect(clashEvent.id, 'ct-91ca1a97-054f-4e29-bdab-714f865293ba');
      expect(clashEvent.serverId, "123456");
      expect(clashEvent.causedBy, "Unknown");
      expect(clashEvent.eventType, ClashBotEvent.TEAM_CREATE);
      expect(clashEvent.payload.name, 'Some Team 2');
      expect(clashEvent.payload.playerDetails.top?.discordId, '1');
      expect(clashEvent.payload.playerDetails.bot?.discordId, '2');
      expect(clashEvent.payload.playerDetails.top?.champions, []);
      expect(clashEvent.payload.playerDetails.bot?.champions, []);
      expect(clashEvent.payload.playerDetails.jg, null);
      expect(clashEvent.payload.playerDetails.mid, null);
      expect(clashEvent.payload.playerDetails.supp, null);
      expect(clashEvent.payload.tournament.tournamentName, "ARAM");
      expect(clashEvent.payload.tournament.tournamentDay, "2");
      expect(clashEvent.payload.lastUpdatedAt,
          DateTime.parse('2025-03-30T22:50:37.217685-05:00'));
      expect(clashEvent.payload.id, 'ct-91ca1a97-054f-4e29-bdab-714f865293ba');
    });
  });
}
