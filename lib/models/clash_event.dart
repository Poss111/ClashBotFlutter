import 'package:clash_bot_api/api.dart';

class ClashEvent {
    String id;
    TeamEvent teamEvent;
    int serverId;
    String causedBy;

    ClashEvent(this.id, this.teamEvent, this.serverId, this.causedBy);
}

class TeamEvent {
    Team team;
    Tentative tentative;
    EventType eventType;

    TeamEvent(this.team, this.tentative, this.eventType);
}

enum EventType { created, updated, deleted }
