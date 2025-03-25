import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/enums/api_call_state.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/pages/home/page/home_v2.dart';
import 'package:clashbot_flutter/services/clashbot_service.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/error_handler.store.dart';
import 'package:mobx/mobx.dart';
import 'dart:developer' as developer;

import 'package:table_calendar/table_calendar.dart';

part 'clash.store.g.dart';

class ClashStore = _ClashStore with _$ClashStore;

abstract class _ClashStore with Store {
  final ClashBotService _clashService;
  final ErrorHandlerStore _errorhandlerStore;

  _ClashStore(this._clashService, this._errorhandlerStore);

  // Constants for network calls
  static const String refreshClashBotUserCall = "refreshClashBotUser";
  static const String refreshClashTournamentsCall = "refreshClashTournaments";
  static const String refreshClashTeamsCall = "refreshClashTeams";

  @observable
  ClashBotUser clashBotUser = ClashBotUser();

  @observable
  ObservableList<String> selectedServers = ObservableList();

  @observable
  bool filterByDay = false;

  @observable
  DateTime filterDate = DateTime.now();

  @observable
  ObservableList<ClashTournament> tournaments = ObservableList();

  @observable
  ObservableList<ClashTeam> clashTeams = ObservableList();

  @observable
  bool refreshingUser = false;

  @observable
  ObservableList<String> callsInProgress = ObservableList();

  @computed
  bool get isRefreshingData =>
      callsInProgress.contains(_ClashStore.refreshClashBotUserCall) ||
      callsInProgress.contains(_ClashStore.refreshClashTournamentsCall) ||
      callsInProgress.contains(_ClashStore.refreshClashTeamsCall);

  @observable
  ApiCallState tournamentsApiCallState = ApiCallState.idle;

  @observable
  ApiCallState teamsApiCallState = ApiCallState.idle;

  @observable
  ApiCallState userApiCallState = ApiCallState.idle;

  @action
  void setTournamentsApiCallState(ApiCallState state) {
    tournamentsApiCallState = state;
  }

  @action
  void setTeamsApiCallState(ApiCallState state) {
    teamsApiCallState = state;
  }

  @action
  void setUserApiCallState(ApiCallState state) {
    userApiCallState = state;
  }

  @action
  void addCallInProgress(String call) {
    callsInProgress.add(call);
  }

  @action
  void removeCallInProgress(String call) {
    callsInProgress.remove(call);
  }

  @action
  void clearCallsInProgress() {
    callsInProgress.clear();
  }

  @action
  Future<void> refreshClashBotUser(String id) async {
    refreshingUser = true;
    addCallInProgress(_ClashStore.refreshClashBotUserCall);
    setUserApiCallState(ApiCallState.loading);
    try {
      clashBotUser = await _clashService.getPlayer(id);
      setSelectedServer(clashBotUser.selectedServers);
      setUserApiCallState(ApiCallState.success);
    } catch (e) {
      setUserApiCallState(ApiCallState.error);
    }
    removeCallInProgress(_ClashStore.refreshClashBotUserCall);
    refreshingUser = false;
  }

  @action
  void refreshSelectedServers() {
    selectedServers = ObservableList.of(clashBotUser.selectedServers);
  }

  @action
  void setSelectedServer(List<String> servers) {
    selectedServers = ObservableList.of(servers);
  }

  @action
  void addSelectedServer(String server) {
    selectedServers.add(server);
  }

  @action
  void removeSelectedServer(String server) {
    selectedServers.remove(server);
  }

  @computed
  bool get canCreateTeam => filterByDay;

  @action
  void turnOnDayFilter() {
    filterByDay = true;
  }

  @action
  void turnOffDayFilter() {
    filterByDay = false;
  }

  @action
  void setFilterDate(DateTime date) {
    filterDate = date;
  }

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
      var teamy = ogTeams.map((key, value) {
        return MapEntry(
            key,
            value.where((team) {
              return isSameDay(key.startTime, filterDate);
            }).toList());
      });
      return teamy;
    }
    return ogTeams;
  }

  @computed
  ObservableList<HomeEvent> get events {
    List<HomeEvent> events = [];
    for (var entry in tournamentsToTeams.entries) {
      for (var team in entry.value) {
        events.add(HomeEvent(
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
  Future<void> refreshClashTournaments(String id) async {
    addCallInProgress(_ClashStore.refreshClashTournamentsCall);
    tournaments =
        ObservableList.of(await _clashService.retrieveTournaments(id));
    removeCallInProgress(_ClashStore.refreshClashTournamentsCall);
  }

  @action
  Future<void> refreshClashTeams(
      String id, List<String> preferredServers) async {
    addCallInProgress(_ClashStore.refreshClashTeamsCall);
    setTeamsApiCallState(ApiCallState.loading);
    var futureClashTeams;
    try {
      futureClashTeams =
          await _clashService.getClashTeams(id, preferredServers);
      setTeamsApiCallState(ApiCallState.success);
    } catch (e) {
      setTeamsApiCallState(ApiCallState.error);
    }
    clashTeams = ObservableList.of(futureClashTeams);
    removeCallInProgress(_ClashStore.refreshClashTeamsCall);
  }

  @action
  Future<void> createTeam(String id, String name, Role role,
      ClashTournament clashTournament, String serverId) async {
    await _clashService.createClashTeam(
        id,
        name,
        role,
        clashTournament.tournamentName,
        clashTournament.tournamentDay,
        serverId);
    refreshClashTeams(id, selectedServers);
  }

  @action
  Future<void> createPlayer(
      String id, String username, String preferredServers) async {
    await _clashService.createPlayer(id, username, preferredServers);
  }

  @action
  Future<void> createSelectedServers(
      String id, List<String> preferredServers) async {
    await _clashService.createSelectedServers(id, preferredServers);
  }

  DateTime roundUpToEndOfDay(DateTime date) {
    return DateTime(date.year, date.month, date.day, 23, 59, 59);
  }

  DateTime roundDownToDay(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
