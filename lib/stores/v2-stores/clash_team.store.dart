import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:mobx/mobx.dart';

part 'clash_team.store.g.dart';

class ClashTeamStore = _ClashTeamStore with _$ClashTeamStore;

abstract class _ClashTeamStore with Store {
  _ClashTeamStore(this.id, this.name, this.tournamentName, this.tournamentDay,
      this.members, this.serverId, this.lastUpdatedAt);

  _ClashTeamStore.fromTeam(Team team) {
    id = team.id ?? '';
    name = team.name ?? '';
    tournamentName = team.tournament?.tournamentName ?? '';
    tournamentDay = team.tournament?.tournamentDay ?? '';
    serverId = team.serverId ?? '';
    lastUpdatedAt = team.lastUpdatedAt ?? DateTime.now();
    members = ObservableMap<Role, PlayerDetails?>();
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

  _ClashTeamStore.fromClashTeam(ClashTeam clashTeam) {
    id = clashTeam.id;
    name = clashTeam.name;
    tournamentName = clashTeam.tournamentName;
    tournamentDay = clashTeam.tournamentDay;
    serverId = clashTeam.serverId;
    lastUpdatedAt = clashTeam.lastUpdatedAt;
    members = ObservableMap<Role, PlayerDetails?>();
    members.addAll(clashTeam.members);
  }

  late String id;
  late String serverId;
  late String tournamentName;
  late String tournamentDay;

  @observable
  late String name;

  @observable
  late ObservableMap<Role, PlayerDetails?> members;

  @observable
  late DateTime lastUpdatedAt;

  @action
  void updateName(String newName) {
    name = newName;
  }

  @action
  void updateMember(Role role, String id, List<String> champions) {
    print("clash_team.store:          Updating member $id");
    if (members[role] == null) {
      print("clash_team.store:          Found member $id");
      // Remove player from other role
      members.forEach((key, value) {
        if (value?.id == id) {
          print(
              "clash_team.store:          Removing member $id from role $key");
          members[key] = null;
        }
      });
      print("clash_team.store:          Adding member $id to role $role");
      members[role] = PlayerDetails(
        id,
        champions,
      );
    }
  }

  @action
  void removeMember(String discordId) {
    print("clash_team.store:          Removing member $discordId");
    members.removeWhere((key, value) => value?.id == discordId);
  }

  @action
  void updateLastUpdatedAt(DateTime newDate) {
    lastUpdatedAt = newDate;
  }
}
