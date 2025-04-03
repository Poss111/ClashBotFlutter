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

    test('fromJsonString creates a valid ClashEvent object', () {
      final jsonString =
          '{"id": "event1", "serverId": 123, "causedBy": "user1"}';

      final clashEvent = ClashEvent.fromJsonString(jsonString);

      expect(clashEvent.id, 'event1');
      expect(clashEvent.serverId, 123);
      expect(clashEvent.causedBy, 'user1');
    });
  });

  group('ClashTeamEvent', () {
    test('fromJson creates a valid ClashTeamEvent object', () {
      final data = {
        'id': 'event2',
        'serverId': 456,
        'causedBy': 'user2',
        'team': {'name': 'Team A'},
        'eventType': 'teamCreated',
      };

      final clashTeamEvent = ClashTeamEvent.fromJson(data);

      expect(clashTeamEvent.id, 'event2');
      expect(clashTeamEvent.serverId, 456);
      expect(clashTeamEvent.causedBy, 'user2');
      expect(clashTeamEvent.payload..name, 'Team A');
      expect(clashTeamEvent.eventType, ClashBotEvent.TEAM_CREATE);
    });

    test('fromJsonString creates a valid ClashTeamEvent object', () {
      final jsonString =
          '{"id": "event2", "serverId": 456, "causedBy": "user2", "team": {"name": "Team A"}, "eventType": "teamCreated"}';

      final clashTeamEvent = ClashTeamEvent.fromJsonString(jsonString);

      expect(clashTeamEvent.id, 'event2');
      expect(clashTeamEvent.serverId, 456);
      expect(clashTeamEvent.causedBy, 'user2');
      expect(clashTeamEvent.payload.name, 'Team A');
      expect(clashTeamEvent.eventType, ClashBotEvent.TEAM_CREATE);
    });
  });

  group('ClashTentativeEvent', () {
    test('fromJson creates a valid ClashTentativeEvent object', () {
      final data = {
        'id': 'event3',
        'serverId': 789,
        'causedBy': 'user3',
        'tentative': {'status': 'pending'},
        'eventType': 'tentativeUpdated',
      };

      final clashTentativeEvent = ClashTentativeEvent.fromJson(data);

      expect(clashTentativeEvent.id, 'event3');
      expect(clashTentativeEvent.serverId, 789);
      expect(clashTentativeEvent.causedBy, 'user3');
      expect(
          clashTentativeEvent.eventType, ClashBotEvent.TENTATIVE_QUEUE_UPDATE);
    });

    test('fromJsonString creates a valid ClashTentativeEvent object', () {
      final jsonString =
          '{"id": "event3", "serverId": 789, "causedBy": "user3", "tentative": {"status": "pending"}, "eventType": "tentativeUpdated"}';

      final clashTentativeEvent =
          ClashTentativeEvent.fromJsonString(jsonString);

      expect(clashTentativeEvent.id, 'event3');
      expect(clashTentativeEvent.serverId, 789);
      expect(clashTentativeEvent.causedBy, 'user3');
      expect(
          clashTentativeEvent.eventType, ClashBotEvent.TENTATIVE_QUEUE_UPDATE);
    });
  });
}
