import 'package:clash_bot_api/api.dart';
import 'package:collection/collection.dart';

class TentativeQueue {
  late String id;
  late String tournamentName;
  late String tournamentDay;
  late String serverId;
  late List<String> users;
  late DateTime lastUpdatedAt;

  TentativeQueue(this.id, this.serverId, this.tournamentName, this.tournamentDay, this.users, this.lastUpdatedAt);

  static TentativeQueue? tentativeToTentativeQueue(Tentative? tentative) {
    if (null == tentative) {
      return null;
    }
    List<String> usersList = List.empty(growable: true);
    usersList.addAll(
        tentative.tentativePlayers.map((player) => player.discordId ?? ''));
    return TentativeQueue(
        tentative.id ?? '',
        tentative.serverId ?? '',
        tentative.tournamentDetails?.tournamentName ?? '',
        tentative.tournamentDetails?.tournamentDay ?? '',
        usersList,
        tentative.lastUpdatedAt ?? DateTime.now());
  }

  @override
  String toString() {
    return 'TentativeQueue ( id: $id, serverId: $serverId, tournament: $tournamentName $tournamentDay, users: $users, lastUpdatedAt: $lastUpdatedAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TentativeQueue &&
        o.id == id &&
        o.serverId == serverId &&
        o.tournamentName == tournamentName &&
        o.tournamentDay == tournamentDay &&
        o.lastUpdatedAt == lastUpdatedAt &&
        const ListEquality().equals(o.users, users);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        serverId.hashCode ^
        tournamentName.hashCode ^
        tournamentDay.hashCode ^
        lastUpdatedAt.hashCode ^
        users.hashCode;
  }
}
