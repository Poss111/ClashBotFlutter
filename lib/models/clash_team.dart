import 'package:clash_bot_api/api.dart';
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

  static ClashTeam? teamToClashTeam(Team? team) {
    if (null == team) {
      return null;
    }
    Map<Role, PlayerDetails?> mapOfPlayers = {};
    if (null != team.playerDetails?.top) {
      mapOfPlayers[Role.TOP] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.top);
    }
    if (null != team.playerDetails?.jg) {
      mapOfPlayers[Role.JG] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.jg);
    }
    if (null != team.playerDetails?.mid) {
      mapOfPlayers[Role.MID] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.mid);
    }
    if (null != team.playerDetails?.bot) {
      mapOfPlayers[Role.BOT] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
          team.playerDetails?.bot);
    }
    if (null != team.playerDetails?.supp) {
      mapOfPlayers[Role.SUPP] = PlayerDetails.teamPlayerDetailsToPlayerDetails(
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
    } if (null != clashTeam.lastUpdatedAt) {
      lastUpdatedAt = clashTeam.lastUpdatedAt;
    } if (null != clashTeam.serverId) {
      serverId = clashTeam.serverId;
    } if (null != clashTeam.members[Role.TOP]) {
      members[Role.TOP] = clashTeam.members[Role.TOP];
    } if (null != clashTeam.members[Role.JG]) {
      members[Role.JG] = clashTeam.members[Role.JG];
    } if (null != clashTeam.members[Role.MID]) {
      members[Role.MID] = clashTeam.members[Role.MID];
    } if (null != clashTeam.members[Role.BOT]) {
      members[Role.BOT] = clashTeam.members[Role.BOT];
    } if (null != clashTeam.members[Role.SUPP]) {
      members[Role.SUPP] = clashTeam.members[Role.SUPP];
    }
    return this;
  }

  @override
  String toString() {
    return 'ClashTeam(id: $id, name: $name, tournament: $tournamentName $tournamentDay, serverid: $serverId, members: $members)';
  }

  @override
  bool operator == (Object o) {
    if (identical(this, o)) return true;
    return o is ClashTeam &&
        o.id == id &&
        o.name == name &&
        o.tournamentName == tournamentName &&
        o.tournamentDay == tournamentDay &&
        o.serverId == serverId &&
        mapEquals(o.members,members);
  }
}

class PlayerDetails {
  late String id;
  late String name;
  late List<String> champions;

  PlayerDetails(this.id, this.name, this.champions);

  static PlayerDetails? teamPlayerDetailsToPlayerDetails(
      TeamPlayer? teamPlayer) {
    List<String> championNames = List.empty(growable: true);
    if (null != teamPlayer) {
      championNames
          .addAll(teamPlayer.champions.map((champ) => champ.name ?? ''));
      return PlayerDetails(
          teamPlayer.discordId ?? '', teamPlayer.name ?? '', championNames);
    }
    return null;
  }

  @override
  String toString() {
    return 'PlayerDetails(id: $id, name: $name, champions: $champions)';
  }

  @override
  bool operator == (Object o) {
    if (identical(this, o)) return true;
    return o is PlayerDetails &&
        o.id == id &&
        o.name == name &&
        const ListEquality().equals(o.champions, champions);
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ champions.hashCode;
  }

}
