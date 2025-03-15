import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/user.dart';
import 'package:clashbot_flutter/pages/home/page/home_v2.dart';
import 'package:clashbot_flutter/services/clashbot_service.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:mobx/mobx.dart';
import 'dart:developer' as developer;

import 'package:table_calendar/table_calendar.dart';

part 'clash.store.g.dart';

class ClashStore = _ClashStore with _$ClashStore;

abstract class _ClashStore with Store {
  final ClashBotService _clashService;
  final ApplicationDetailsStore _applicationDetailsStore;

  _ClashStore(this._clashService, this._applicationDetailsStore) {
    reaction((_) => _applicationDetailsStore.id, (_) {
      refreshClashTournaments();
    });
    reaction((_) => _applicationDetailsStore.preferredServers, (_) {
      resetSelectedServers();
      refreshClashTeams();
    });
  }

  @observable
  ObservableList<String> selectedServers = ObservableList();

  @action
  void resetSelectedServers() {
    selectedServers =
        ObservableList.of(_applicationDetailsStore.preferredServers);
  }

  @action
  void setSelectedServer(List<String> servers) {
    selectedServers = ObservableList.of(servers);
  }

  @action
  void addSelectedServer(String server) {
    if (_applicationDetailsStore.preferredServers.contains(server) &&
        !selectedServers.contains(server)) {
      selectedServers.add(server);
    }
  }

  @action
  void removeSelectedServer(String server) {
    selectedServers.remove(server);
  }

  @observable
  bool filterByDay = false;

  @action
  void turnOnDayFilter() {
    filterByDay = true;
  }

  @action
  void turnOffDayFilter() {
    filterByDay = false;
  }

  @observable
  DateTime filterDate = DateTime.now();

  @action
  void setFilterDate(DateTime date) {
    filterDate = date;
  }

  @observable
  ObservableList<ClashTournament> tournaments = ObservableList();

  @computed
  Map<String, List<ClashTournament>> get tournamentsByNameAndDay {
    Map<String, List<ClashTournament>> tournamentsByNameAndDay = {};
    for (var t in tournaments) {
      var key = t.tournamentName + t.tournamentDay;
      if (tournamentsByNameAndDay.containsKey(key)) {
        tournamentsByNameAndDay[key]!.add(t);
      } else {
        tournamentsByNameAndDay[key] = [t];
      }
    }
    return tournamentsByNameAndDay;
  }

  @observable
  ObservableList<ClashTeam> clashTeams = ObservableList();

  @computed
  Map<ClashTournament, List<ClashTeam>> get tournamentsToTeams {
    Map<ClashTournament, List<ClashTeam>> tournamentsToTeams = {};
    for (var t in tournaments) {
      tournamentsToTeams[t] = clashTeams.where((team) {
        return team.tournamentName + team.tournamentDay ==
                t.tournamentName + t.tournamentDay &&
            selectedServers.contains(team.serverId);
      }).toList();
    }
    return tournamentsToTeams;
  }

  @computed
  Map<ClashTournament, List<ClashTeam>>
      get tournamentsToTeamsFilteredToADayIfActive {
    Map<ClashTournament, List<ClashTeam>> ogTeams = tournamentsToTeams;
    if (filterByDay) {
      developer.log("Filtering by day");
      ogTeams = ogTeams.map((key, value) {
        return MapEntry(
            key,
            value.where((team) {
              return isSameDay(key.startTime, filterDate);
            }).toList());
      });
    }
    developer.log("Not filtering by day");
    return ogTeams;
  }

  @computed
  ObservableList<Event> get events {
    List<Event> events = [];
    for (var entry in tournamentsToTeams.entries) {
      for (var team in entry.value) {
        events.add(Event(
          date: entry.key.startTime,
          title: '${entry.key.tournamentName} ${entry.key.tournamentDay}',
          description: "An event",
          team: team,
        ));
      }
    }
    return ObservableList.of(events);
  }

  @action
  void setEvents(List<ClashTeam> events) {
    this.clashTeams = ObservableList.of(events);
  }

  @action
  Future<void> refreshClashTournaments() async {
    tournaments = ObservableList.of(
        await _clashService.retrieveTournaments(_applicationDetailsStore.id));
  }

  @action
  Future<void> refreshClashTeams() async {
    var futureClashTeams = await _clashService.getClashTeams(
        _applicationDetailsStore.id, _applicationDetailsStore.preferredServers);
    clashTeams = ObservableList.of(futureClashTeams);
  }

  DateTime roundUpToEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  DateTime roundDownToDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
