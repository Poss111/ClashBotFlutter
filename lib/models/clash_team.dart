import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_event.dart';
import 'package:clashbot_flutter/models/lol_champion.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:validators/validators.dart';

class ClashTeam {
  late String id;
  late String name;
  late String tournamentName;
  late String tournamentDay;
  late String serverId;
  late Map<Role, PlayerDetails?> members;
  late DateTime lastUpdatedAt;

  ClashTeam(this.id, this.name, this.tournamentName, this.tournamentDay,
      this.members, this.serverId, this.lastUpdatedAt);

  ClashTeam.fromTeam(Team team) {
    id = team.id ?? '';
    name = team.name ?? '';
    tournamentName = team.tournament?.tournamentName ?? '';
    tournamentDay = team.tournament?.tournamentDay ?? '';
    serverId = team.serverId ?? '';
    lastUpdatedAt = team.lastUpdatedAt ?? DateTime.now();
    members = {};
    if (null != team.playerDetails?.top) {
      members[Role.top] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.top);
    }
    if (null != team.playerDetails?.jg) {
      members[Role.jg] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.jg);
    }
    if (null != team.playerDetails?.mid) {
      members[Role.mid] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.mid);
    }
    if (null != team.playerDetails?.bot) {
      members[Role.bot] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.bot);
    }
    if (null != team.playerDetails?.supp) {
      members[Role.supp] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.supp);
    }
  }

  ClashTeam.fromTeamEvent(TeamPayloadEvent teamPayloadEvent) {
    id = teamPayloadEvent.id;
    name = teamPayloadEvent.name;
    tournamentName = teamPayloadEvent.tournament.tournamentName ?? '';
    tournamentDay = teamPayloadEvent.tournament.tournamentDay ?? '';
    serverId = teamPayloadEvent.serverId;
    lastUpdatedAt = teamPayloadEvent.lastUpdatedAt;
    members = {};
    if (null != teamPayloadEvent.playerDetails?.top) {
      members[Role.top] = PlayerDetails.playerDetailsEventToPlayerDetails(
          teamPayloadEvent.playerDetails.top);
    }
    if (null != teamPayloadEvent.playerDetails?.jg) {
      members[Role.jg] = PlayerDetails.playerDetailsEventToPlayerDetails(
          teamPayloadEvent.playerDetails.jg);
    }
    if (null != teamPayloadEvent.playerDetails?.mid) {
      members[Role.mid] = PlayerDetails.playerDetailsEventToPlayerDetails(
          teamPayloadEvent.playerDetails.mid);
    }
    if (null != teamPayloadEvent.playerDetails?.bot) {
      members[Role.bot] = PlayerDetails.playerDetailsEventToPlayerDetails(
          teamPayloadEvent.playerDetails.bot);
    }
    if (null != teamPayloadEvent.playerDetails?.supp) {
      members[Role.supp] = PlayerDetails.playerDetailsEventToPlayerDetails(
          teamPayloadEvent.playerDetails.supp);
    }
  }

  static ClashTeam? teamToClashTeam(Team? team) {
    if (null == team) {
      return null;
    }
    Map<Role, PlayerDetails?> mapOfPlayers = {};
    if (null != team.playerDetails?.top) {
      mapOfPlayers[Role.top] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.top);
    }
    if (null != team.playerDetails?.jg) {
      mapOfPlayers[Role.jg] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.jg);
    }
    if (null != team.playerDetails?.mid) {
      mapOfPlayers[Role.mid] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.mid);
    }
    if (null != team.playerDetails?.bot) {
      mapOfPlayers[Role.bot] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.bot);
    }
    if (null != team.playerDetails?.supp) {
      mapOfPlayers[Role.supp] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.supp);
    }
    return ClashTeam(
        team.id ?? '',
        team.name ?? '',
        team.tournament?.tournamentName ?? '',
        team.tournament?.tournamentDay ?? '',
        mapOfPlayers,
        team.serverId ?? '',
        team.lastUpdatedAt ?? DateTime.now());
  }

  ClashTeam merge(ClashTeam clashTeam) {
    if (!isNull(clashTeam.name)) {
      name = clashTeam.name;
    }
    if (null != clashTeam.lastUpdatedAt) {
      lastUpdatedAt = clashTeam.lastUpdatedAt;
    }
    if (null != clashTeam.serverId) {
      serverId = clashTeam.serverId;
    }
    if (null != clashTeam.members[Role.top]) {
      members[Role.top] = clashTeam.members[Role.top];
    }
    if (null != clashTeam.members[Role.jg]) {
      members[Role.jg] = clashTeam.members[Role.jg];
    }
    if (null != clashTeam.members[Role.mid]) {
      members[Role.mid] = clashTeam.members[Role.mid];
    }
    if (null != clashTeam.members[Role.bot]) {
      members[Role.bot] = clashTeam.members[Role.bot];
    }
    if (null != clashTeam.members[Role.supp]) {
      members[Role.supp] = clashTeam.members[Role.supp];
    }
    return this;
  }

  @override
  String toString() {
    return 'ClashTeam(id: $id, name: $name, tournament: $tournamentName $tournamentDay, serverid: $serverId, members: $members)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is ClashTeam &&
        o.id == id &&
        o.name == name &&
        o.tournamentName == tournamentName &&
        o.tournamentDay == tournamentDay &&
        o.serverId == serverId &&
        mapEquals(o.members, members);
  }
}

class PlayerDetails {
  late String id;
  late List<String> champions;

  PlayerDetails(this.id, this.champions);

  static PlayerDetails? teamPlayerDetailsToPlayerDetails(
      TeamPlayer? teamPlayer) {
    List<String> championNames = List.empty(growable: true);
    if (null != teamPlayer) {
      championNames
          .addAll(teamPlayer.champions.map((champ) => champ.name ?? ''));
      return PlayerDetails(teamPlayer.discordId ?? '', championNames);
    }
    return null;
  }

  static PlayerDetails? playerDetailsEventToPlayerDetails(
      PlayerEvent? playerEvent) {
    List<String> championNames = List.empty(growable: true);
    if (null != playerEvent) {
      if (playerEvent.champions == null) {
        return PlayerDetails(playerEvent.discordId ?? '', []);
      } else {
        championNames
            .addAll(playerEvent.champions!.map((champ) => champ ?? ''));
        return PlayerDetails(playerEvent.discordId ?? '', championNames);
      }
    }
    return null;
  }

  @override
  String toString() {
    return 'PlayerDetails(id: $id, champions: $champions)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PlayerDetails &&
        o.id == id &&
        const ListEquality().equals(o.champions, champions);
  }

  @override
  int get hashCode {
    return id.hashCode ^ champions.hashCode;
  }
}
