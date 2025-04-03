import 'dart:convert';

import 'package:clash_bot_api/api.dart';
import 'dart:developer' as developer;

import 'package:clashbot_flutter/models/clash_bot_event.dart';

class ClashEvent {
  String id;
  String serverId;
  String causedBy;
  ClashBotEvent eventType;

  ClashEvent(this.id, this.serverId, this.causedBy, this.eventType);

  static ClashEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final String id = json['id'];
    final String serverId = json['serverId'];
    final String causedBy = json['causedBy'] ?? 'Unknown';
    final ClashBotEvent eventType = ClashBotEvent.values.firstWhere((e) =>
        e.toString().toLowerCase() == '${json['eventType']}'.toLowerCase());
    return ClashEvent(id, serverId, causedBy, eventType);
  }

  static ClashEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final String id = json['id'];
    final String serverId = json['serverId'];
    final String causedBy = json['causedBy'] ?? 'Unknown';
    final ClashBotEvent eventType = ClashBotEvent.values.firstWhere((e) =>
        e.toString().toLowerCase() == '${json['eventType']}'.toLowerCase());
    return ClashEvent(id, serverId, causedBy, eventType);
  }
}

class ClashTeamEvent extends ClashEvent {
  TeamPayloadEvent payload;

  ClashTeamEvent(
      super.id, super.serverId, super.causedBy, super.eventType, this.payload);

  static ClashTeamEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final Team? team = Team.fromJson(json['team']);
    final ClashBotEvent eventType = ClashBotEvent.values.firstWhere((e) =>
        e.toString().toLowerCase() == '${json['eventType']}'.toLowerCase());
    final String id = json['id'];
    final String serverId = json['serverId'];
    final String causedBy = json['causedBy'] ?? 'Unknown';
    return ClashTeamEvent(id, serverId, causedBy, eventType,
        TeamPayloadEvent.fromJson(json['payload']));
  }

  static ClashTeamEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final Team? team = Team.fromJson(json['team']);
    final ClashBotEvent eventType = ClashBotEvent.values.firstWhere((e) =>
        e.toString().toLowerCase() == '${json['eventType']}'.toLowerCase());
    final String id = json['id'];
    final String serverId = json['serverId'];
    final String causedBy = json['causedBy'] ?? 'Unknown';
    return ClashTeamEvent(id, serverId, causedBy, eventType,
        TeamPayloadEvent.fromJson(json['payload']));
  }
}

class TeamPayloadEvent {
  String id;
  String name;
  String serverId;
  PlayerDetailsEvent playerDetails;
  TournamentEvent tournament;
  DateTime lastUpdatedAt;

  TeamPayloadEvent(this.id, this.name, this.serverId, this.playerDetails,
      this.tournament, this.lastUpdatedAt);

  static TeamPayloadEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final String id = json['id'];
    final String name = json['name'];
    final String serverId = json['serverId'];
    final PlayerDetailsEvent playerDetails =
        PlayerDetailsEvent.fromJson(json['playerDetails']);
    final TournamentEvent tournament =
        TournamentEvent.fromJson(json['tournament']);
    final DateTime lastUpdatedAt = DateTime.parse(json['lastUpdatedAt']);
    return TeamPayloadEvent(
        id, name, serverId, playerDetails, tournament, lastUpdatedAt);
  }

  static TeamPayloadEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final String id = json['id'];
    final String name = json['name'];
    final String serverId = json['serverId'];
    final PlayerDetailsEvent playerDetails =
        PlayerDetailsEvent.fromJson(json['playerDetails']);
    final TournamentEvent tournament =
        TournamentEvent.fromJson(json['tournament']);
    final DateTime lastUpdatedAt = DateTime.parse(json['lastUpdatedAt']);
    return TeamPayloadEvent(
        id, name, serverId, playerDetails, tournament, lastUpdatedAt);
  }
}

class PlayerDetailsEvent {
  PlayerEvent? top;
  PlayerEvent? bot;
  PlayerEvent? mid;
  PlayerEvent? jg;
  PlayerEvent? supp;

  PlayerDetailsEvent(this.top, this.bot, this.mid, this.jg, this.supp);

  static PlayerDetailsEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final PlayerEvent? top =
        json['top'] != null ? PlayerEvent.fromJson(json['top']) : null;
    final PlayerEvent? bot =
        json['bot'] != null ? PlayerEvent.fromJson(json['bot']) : null;
    final PlayerEvent? mid =
        json['mid'] != null ? PlayerEvent.fromJson(json['mid']) : null;
    final PlayerEvent? jg =
        json['jg'] != null ? PlayerEvent.fromJson(json['jg']) : null;
    final PlayerEvent? supp =
        json['supp'] != null ? PlayerEvent.fromJson(json['supp']) : null;
    return PlayerDetailsEvent(top, bot, mid, jg, supp);
  }

  static PlayerDetailsEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final PlayerEvent? top =
        json['top'] != null ? PlayerEvent.fromJson(json['top']) : null;
    final PlayerEvent? bot =
        json['bot'] != null ? PlayerEvent.fromJson(json['bot']) : null;
    final PlayerEvent? mid =
        json['mid'] != null ? PlayerEvent.fromJson(json['mid']) : null;
    final PlayerEvent? jg =
        json['jg'] != null ? PlayerEvent.fromJson(json['jg']) : null;
    final PlayerEvent? supp =
        json['supp'] != null ? PlayerEvent.fromJson(json['supp']) : null;
    return PlayerDetailsEvent(top, bot, mid, jg, supp);
  }
}

class PlayerEvent {
  String discordId;
  List<String>? champions;

  PlayerEvent(this.discordId, [this.champions]);

  static PlayerEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final String discordId = json['discordId'];
    final List<String>? champions =
        json['champions'] != null ? List<String>.from(json['champions']) : null;
    return PlayerEvent(discordId, champions);
  }

  static PlayerEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final String discordId = json['discordId'];
    final List<String>? champions =
        json['champions'] != null ? List<String>.from(json['champions']) : null;
    return PlayerEvent(discordId, champions);
  }
}

class TournamentEvent {
  String tournamentName;
  String tournamentDay;

  TournamentEvent(this.tournamentName, this.tournamentDay);

  static TournamentEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final String tournamentName = json['name'];
    final String tournamentDay = json['day'];
    return TournamentEvent(tournamentName, tournamentDay);
  }

  static TournamentEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final String tournamentName = json['name'];
    final String tournamentDay = json['day'];
    return TournamentEvent(tournamentName, tournamentDay);
  }
}

class ClashTentativeEvent extends ClashEvent {
  TentativeEvent payload;

  ClashTentativeEvent(
      super.id, super.serverId, super.causedBy, super.eventType, this.payload);

  static ClashTentativeEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final Tentative? tentative = Tentative.fromJson(json['tentative']);
    final ClashBotEvent eventType = ClashBotEvent.values.firstWhere((e) =>
        e.toString().toLowerCase() == '${json['eventType']}'.toLowerCase());
    final String id = json['id'];
    final String serverId = json['serverId'];
    final String causedBy = json['causedBy'] ?? 'Unknown';
    final TentativeEvent payload = TentativeEvent(tentative);
    return ClashTentativeEvent(id, serverId, causedBy, eventType, payload);
  }

  static ClashTentativeEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final Tentative? tentative = Tentative.fromJson(json['tentative']);
    final ClashBotEvent eventType = ClashBotEvent.values.firstWhere((e) =>
        e.toString().toLowerCase() == '${json['eventType']}'.toLowerCase());
    final String id = json['id'];
    final String serverId = json['serverId'].toString();
    final String causedBy = json['causedBy'] ?? 'Unknown';
    final TentativeEvent payload = TentativeEvent(tentative);
    return ClashTentativeEvent(id, serverId, causedBy, eventType, payload);
  }
}

class TentativeEvent {
  Tentative? tentative;

  TentativeEvent(this.tentative);

  static TentativeEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final Tentative? tentative = Tentative.fromJson(json['tentative']);
    return TentativeEvent(tentative);
  }

  static TentativeEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final Tentative? tentative = Tentative.fromJson(json['tentative']);
    return TentativeEvent(tentative);
  }
}

class ClashTeamRemovalEvent extends ClashEvent {
  UserRemovalEvent payload;
  ClashTeamRemovalEvent(
      super.id, super.serverId, super.causedBy, super.eventType, this.payload);

  static ClashTeamRemovalEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final Team? team = Team.fromJson(json['team']);
    final ClashBotEvent eventType = ClashBotEvent.values.firstWhere((e) =>
        e.toString().toLowerCase() == '${json['eventType']}'.toLowerCase());
    final String id = json['id'];
    final String serverId = json['serverId'];
    final String causedBy = json['causedBy'] ?? 'Unknown';
    return ClashTeamRemovalEvent(id, serverId, causedBy, eventType,
        UserRemovalEvent.fromJson(json['payload']));
  }

  static ClashTeamRemovalEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final Team? team = Team.fromJson(json['team']);
    final ClashBotEvent eventType = ClashBotEvent.values.firstWhere((e) =>
        e.toString().toLowerCase() == '${json['eventType']}'.toLowerCase());
    final String id = json['id'];
    final String serverId = json['serverId'];
    final String causedBy = json['causedBy'] ?? 'Unknown';
    return ClashTeamRemovalEvent(id, serverId, causedBy, eventType,
        UserRemovalEvent.fromJson(json['payload']));
  }
}

class UserRemovalEvent {
  String teamId;
  String discordId;

  UserRemovalEvent(this.teamId, this.discordId);

  static UserRemovalEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final String teamId = json['teamId'];
    final String discordId = json['discordId'];
    return UserRemovalEvent(teamId, discordId);
  }

  static UserRemovalEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final String teamId = json['teamId'];
    final String discordId = json['discordId'];
    return UserRemovalEvent(teamId, discordId);
  }
}

class ClashTeamJoinedEvent extends ClashEvent {
  UserJoinedEvent payload;
  ClashTeamJoinedEvent(
      super.id, super.serverId, super.causedBy, super.eventType, this.payload);

  static ClashTeamJoinedEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final Team? team = Team.fromJson(json['team']);
    final ClashBotEvent eventType = ClashBotEvent.values.firstWhere((e) =>
        e.toString().toLowerCase() == '${json['eventType']}'.toLowerCase());
    final String id = json['id'];
    final String serverId = json['serverId'];
    final String causedBy = json['causedBy'] ?? 'Unknown';
    return ClashTeamJoinedEvent(id, serverId, causedBy, eventType,
        UserJoinedEvent.fromJson(json['payload']));
  }

  static ClashTeamJoinedEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final Team? team = Team.fromJson(json['team']);
    final ClashBotEvent eventType = ClashBotEvent.values.firstWhere((e) =>
        e.toString().toLowerCase() == '${json['eventType']}'.toLowerCase());
    final String id = json['id'];
    final String serverId = json['serverId'];
    final String causedBy = json['causedBy'] ?? 'Unknown';
    return ClashTeamJoinedEvent(id, serverId, causedBy, eventType,
        UserJoinedEvent.fromJson(json['payload']));
  }
}

class UserJoinedEvent {
  String teamId;
  PlayerDetailsEvent playerDetails;

  UserJoinedEvent(this.teamId, this.playerDetails);

  static UserJoinedEvent fromJson(data) {
    final Map<String, dynamic> json = data;
    final String teamId = json['teamId'];
    final PlayerDetailsEvent playerDetails =
        PlayerDetailsEvent.fromJson(json['playerDetails']);
    return UserJoinedEvent(teamId, playerDetails);
  }

  static UserJoinedEvent fromJsonString(String data) {
    final Map<String, dynamic> json = jsonDecode(data);
    final String teamId = json['teamId'];
    final PlayerDetailsEvent playerDetails =
        PlayerDetailsEvent.fromJson(json['playerDetails']);
    return UserJoinedEvent(teamId, playerDetails);
  }
}
