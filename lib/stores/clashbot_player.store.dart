import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/models/tentative_queue.dart';
import 'package:clashbot_flutter/services/clashbot_service.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:mobx/mobx.dart';
import 'dart:developer' as developer;

import 'package:validators/validators.dart';

part 'clashbot_player.store.g.dart';

class ClashPlayerStore = _ClashPlayerStore with _$ClashPlayerStore;

abstract class _ClashPlayerStore with Store {
  final ClashBotService _clashBotService;
  final ApplicationDetailsStore _applicationDetailsStore;
  _ClashPlayerStore(this._clashBotService, this._applicationDetailsStore);

  @observable
  ClashBotUser clashBotUser = ClashBotUser();

  @observable
  ObservableList<ClashTeam> currentClashTeams = ObservableList<ClashTeam>();

  @observable
  ObservableList<TentativeQueue> currentTentativeQueues = ObservableList<TentativeQueue>();

  @computed
  List<ClashTournament> get availableTentativeTournaments => _applicationDetailsStore.tournaments.toSet().difference(currentTentativeQueues.map((element) => ClashTournament(element.tournamentName, element.tournamentDay, DateTime.now(), DateTime.now())).toSet()).toList();

  @observable
  bool showTeams = true;

  @observable
  bool callInProgress = false;

  @observable
  String? selectedServerName;

  @observable
  String? serverFilter;

  @observable
  String? tournamentNameFilter;

  @observable
  String? tournamentDayFilter;

  @computed
  int get numberOfTeams => currentClashTeams.length;

  @computed
  int get numberOfTentativeQueues => currentTentativeQueues.length;

  @computed
  Map<String, List<ClashTeam>> get mapOfClashTeamsToServer => group.call();

  Map<String, List<ClashTeam>> group() {
    Map<String, List<ClashTeam>> groupedMap = {};
      for (var team in currentClashTeams) {
        if (null == groupedMap[team.serverId]) {
          groupedMap[team.serverId] = [team];
        } else {
          groupedMap[team.serverId]?.add(team);
        }
      }
    return groupedMap;
  }

  @computed
  ObservableList<ClashTeam> get filteredTeamsList => filter.call();

  ObservableList<ClashTeam> filter() {
    var copy;
    List filters = [];
    if (!isNull(serverFilter)) {
      filters.add((element) => element.serverId == serverFilter);
    } if (!isNull(tournamentNameFilter)) {
      filters.add((element) => element.tournamentName == tournamentNameFilter);
    } if (!isNull(tournamentDayFilter)) {
      filters.add((element) => element.tournamentDay == tournamentDayFilter);
    }
    copy = currentClashTeams;

    if (filters.isNotEmpty) {
      for (var filter in filters) {
        copy = copy.where(filter).toList();
      }
    }
    return ObservableList.of([...copy.where((element) => null == element.members || element.members.isNotEmpty)]);
  }

  @computed
  ObservableList<TentativeQueue> get filteredTentativeQueues => filterTentativeQueues.call();

  ObservableList<TentativeQueue> filterTentativeQueues() {
    var copy;
    List filters = [];
    if (!isNull(serverFilter)) {
      filters.add((element) => element.serverId == serverFilter);
    } if (!isNull(tournamentNameFilter)) {
      filters.add((element) => element.tournamentName == tournamentNameFilter);
    } if (!isNull(tournamentDayFilter)) {
      filters.add((element) => element.tournamentDay == tournamentDayFilter);
    }

    if (filters.isEmpty) {
      return currentTentativeQueues;
    } else {
      copy = currentTentativeQueues;
      for (var filter in filters) {
        copy = copy.where(filter).toList();
      }
    
      return ObservableList.of([...copy]);
    }
  }

  @observable
  ObservableList<String> champions = ObservableList<String>();

  @computed
  bool get canAddMorePreferredChampions => champions.length < 5;

  @observable
  ObservableMap<String, Subscription> subscriptions =
      ObservableMap<String, Subscription>();

  @observable
  ObservableList<String> selectedServers = ObservableList<String>();

  @computed
  bool get canAddMoreSelectedServers => selectedServers.length < 5;

  @computed
  bool get clashBotUserDetailsLoaded => !isNull(clashBotUser.discordId);

  @action
  void setCallInProgess() {
    developer.log("Call in Progess!");
    callInProgress = true;
  }

  @action
  void callFinished() {
    developer.log("Call Finished!");
    callInProgress = false;
  }

  @action
  void showTeamsView() {
    showTeams = true;
  }

  @action
  void showTentativeView() {
    showTeams = false;
  }

  @action
  void filterByServer(String serverId) {
    serverFilter = serverId;
  }

  @action
  void filterByTournamentName(String tournamentName) {
    tournamentNameFilter = tournamentName;
  }

  @action
  void filterByTournamentDay(String tournamentDay) {
    tournamentDayFilter = tournamentDay;
  }

  @action
  Future<ClashBotUser> createUser(
      String defaultServerId, List<String> selectedServersToUse) async {
    try {
      clashBotUser = await _clashBotService.createPlayer(
          _applicationDetailsStore.id,  
          _applicationDetailsStore.discordDetailsStore.discordUser.username, 
          defaultServerId);
      var updatedSelectedServers = await _clashBotService.createSelectedServers(
          _applicationDetailsStore.id, selectedServersToUse);
      clashBotUser.selectedServers = updatedSelectedServers;
      selectedServers.clear();
      selectedServers.addAll(updatedSelectedServers);
      serverFilter = updatedSelectedServers.first;
      champions.clear();
      champions.addAll(clashBotUser.champions.map((champ) => champ.name ?? ''));
      developer.log(clashBotUser.champions.toString());
      return clashBotUser;
    } on Exception catch (error) {
      _applicationDetailsStore.error =
          'Failed to create new Clash Bot User, please try again.';
      developer.log('Failed to create new Clash Bot User', error: error);
      rethrow;
    }
  }

  @action
  Future<void> refreshClashBotUserDetails() async {
    try {
      if (!_applicationDetailsStore.discordDetailsStore.detailsLoaded) {
        _applicationDetailsStore.error = 'User is not logged in to discord, cannot retrieve details.';
      } else {
        var loggedInUser = await _clashBotService.getPlayer(_applicationDetailsStore.id);
        clashBotUser = loggedInUser;
        selectedServers.clear();
        selectedServers.addAll(clashBotUser.selectedServers);
        serverFilter = clashBotUser.selectedServers.first;
        champions.clear();
        champions.addAll(clashBotUser.champions.map((champ) => champ.name ?? ''));
        developer.log(clashBotUser.champions.toString());
      }
    } on Exception catch (error) {
      _applicationDetailsStore.error =
          'Failed to retrieve Clash Bot User details, please try again.';
      developer.log('Failed to retrieve Clash Bot User details', error: error);
      rethrow;
    }
  }

  @action
  Future<void> addChampion(String name) async {
    try {
      if (!champions.contains(name)) {
        await _clashBotService.updateChampions(
            _applicationDetailsStore.id, name);
        champions.add(name);
      }
    } on Exception catch (error) {
      _applicationDetailsStore.error = 'Failed to add champion.';
      developer.log('Failed to add champion.', error: error);
    }
  }

  @action
  Future<void> removeChampion(String name) async {
    try {
      await _clashBotService.removeChampion(
          _applicationDetailsStore.id, name);
      champions.removeWhere((champName) => champName == name);
    } on Exception catch (error) {
      _applicationDetailsStore.error = 'Failed to remove champion.';
      developer.log('Failed to remove champion.', error: error);
    }
  }

  @action
  Future<void> overwriteChampions(List<String> newChampions) async {
    try {
      var updatedChampions = await _clashBotService.overwriteChampions(
          _applicationDetailsStore.id, newChampions);
      champions.clear();
      champions.addAll(updatedChampions);
    } on Exception catch (error) {
      _applicationDetailsStore.error = 'Failed to overwrite champions.';
      developer.log('Failed to overwrite champions.', error: error);
    }
  }

  @action
  Future<void> overwriteSelectedServers(List<String> selectedServerIds) async {
    try {
      var updatedSelectedServers = await _clashBotService.createSelectedServers(
          _applicationDetailsStore.id, selectedServerIds);
      selectedServers.clear();
      selectedServers.addAll(updatedSelectedServers);
      serverFilter = selectedServers.first;
    } on Exception catch (error) {
      _applicationDetailsStore.error =
          'Failed to overwrite selected Discord Servers.';
      developer.log('Failed to overwrite selected Discord Servers.',
          error: error);
    }
  }

  @action
  Future<void> addSelectedServer(String selectedServerId) async {
    try {
      await _clashBotService.updateSelectedServers(
          _applicationDetailsStore.id, [ selectedServerId ]);
      selectedServers.add(selectedServerId);
      serverFilter = selectedServers.first;
      _applicationDetailsStore.subscribeToServer(selectedServerId);
    } on Exception catch (error) {
      _applicationDetailsStore.error = 'Failed to add selected Discord Server.';
      developer.log('Failed to add selected Discord Server.', error: error);
    }
  }

  @action
  Future<void> removeSelectedServer(String selectedServerId) async {
    try {
      await _clashBotService.removeSelectedServers(
          _applicationDetailsStore.id, [selectedServerId]);
      selectedServers
          .removeWhere((serverId) => serverId == selectedServerId);
      serverFilter = selectedServers.first;
      _applicationDetailsStore.unsubscribeFromServer(selectedServerId);
    } on Exception catch (error) {
      _applicationDetailsStore.error =
          'Failed to remove selected Discord Server.';
      developer.log('Failed to remove selected Discord Server.', error: error);
    }
  }

  @action
  Future<void> refreshTeamList() async {
    try {
      var listOfClashTeams =
          await _clashBotService.getClashTeams(_applicationDetailsStore.id, clashBotUser.selectedServers);
      currentClashTeams.clear();
      currentClashTeams.addAll(listOfClashTeams.where((element) => element.members.isNotEmpty));
    } on Exception catch (error) {
      _applicationDetailsStore.error = 'Failed to refresh Clash Bot Teams.';
      developer.log('Failed to refresh Clash Bot Teams.', error: error);
    }
  }

  @action
  void addClashTeam(ClashTeam clashTeamToAdd) {
    currentClashTeams.add(clashTeamToAdd);
  }

  @action
  void removeClashTeams(ClashTeam clashTeamToRemove) {
    currentClashTeams
        .removeWhere((clashTeam) => clashTeam.id == clashTeamToRemove.id);
  }

  @action
  void updateClashTeam(ClashTeam updatedClashTeam) {
    List<ClashTeam> foundTeam = currentClashTeams.where((team) {
      return team.id == updatedClashTeam.id;
    }).toList();
    if (foundTeam.isNotEmpty) {
      currentClashTeams
          .remove(foundTeam[0]);
    }
    currentClashTeams.add(updatedClashTeam);
  }

  @action
  Future<void> refreshTentativeQueue() async {
    try {
      var listOfTentativeQueues = await _clashBotService
          .getTentativeQueues(_applicationDetailsStore.id, clashBotUser.selectedServers);
      currentTentativeQueues.clear();
      currentTentativeQueues.addAll(listOfTentativeQueues);
    } on Exception catch (error) {
      _applicationDetailsStore.error =
          'Failed to refresh Clash Bot Tentative Queues.';
      developer.log('Failed to refresh Clash Bot Tentative Queues.',
          error: error);
    }
  }

  @action
  void addTentativeQueue(TentativeQueue tentativeQueueToAdd) {
    currentTentativeQueues.add(tentativeQueueToAdd);
  }

  @action
  void removeTentativeQueue(TentativeQueue tentativeQueueToRemove) {
    currentTentativeQueues.removeWhere(
        (tentativeQueue) => tentativeQueue.id == tentativeQueueToRemove.id);
  }

  @action
  void updateTentativeQueue(TentativeQueue updatedTentativeQueue) {
    List<TentativeQueue> foundTeam = currentTentativeQueues.where((tentativeQueue) {
      return tentativeQueue.id == updatedTentativeQueue.id && tentativeQueue.lastUpdatedAt.compareTo(updatedTentativeQueue.lastUpdatedAt) <= 0;
    }).toList();
    if (foundTeam.isNotEmpty) {
      currentTentativeQueues
          .remove(foundTeam[0]);
    }
    currentTentativeQueues.removeWhere(
        (tentativeQueue) => tentativeQueue.id == updatedTentativeQueue.id);
    currentTentativeQueues.add(updatedTentativeQueue);
  }

  @action
  Future<void> createTeam(String name, Role role, String serverId, String tournamentName,
      String tournamentDay) async {
    try {
      setCallInProgess();
      var createTeam = await _clashBotService.createClashTeam(_applicationDetailsStore.id, name, role,
          serverId, tournamentName, tournamentDay);
      updateClashTeam(createTeam);
    } on Exception catch (error) {
      _applicationDetailsStore.error = 'Failed to create Clash Bot Team.';
      developer.log('Failed to create Clash Bot Team.', error: error);
    }
    callFinished();
  }

  @action
  Future<void> removeFromTeam(String teamId) async {
    try {
      setCallInProgess();
      var updatedTeam = await _clashBotService.removeFromTeam(
          _applicationDetailsStore.id, teamId);
      updateClashTeam(updatedTeam);
    } on Exception catch (error) {
      _applicationDetailsStore.error =
          'Failed to remove you from Clash Bot Team.';
      developer.log('Failed to remove you from Clash Bot Team.', error: error);
    }
    callFinished();
  }

  @action
  Future<void> addToTeam(Role role, String teamId) async {
    try {
      setCallInProgess();
      var updatedTeam = await _clashBotService.addToTeam(
          _applicationDetailsStore.id, role, teamId);
      updateClashTeam(updatedTeam);
    } on Exception catch (error) {
      _applicationDetailsStore.error =
          'Failed to add you to the Clash Bot Team.';
      developer.log('Failed to add you to the Clash Bot Team.', error: error);
    }
    callFinished();
  }

  @action
  Future<void> createTentativeQueue(String serverId,
      String tournamentName, String tournamentDay) async {
    try {
      setCallInProgess();
      var createdTentativeQueue = await _clashBotService.createTentativeQueue(
          _applicationDetailsStore.id, serverId, tournamentName, tournamentDay);
      updateTentativeQueue(createdTentativeQueue);
    } on Exception catch (error) {
      _applicationDetailsStore.error = 'Failed to create Tentative Queue.';
      developer.log('Failed to create Tentative Queue.', error: error);
    }
    callFinished();
  }

  @action
  Future<void> removeFromTentativeQueue(String tentativeId) async {
    try {
      var updatedTentativeQueue = await _clashBotService.removeFromTentativeQueue(
          _applicationDetailsStore.id, tentativeId);
      updateTentativeQueue(updatedTentativeQueue);
    } on Exception catch (error) {
      _applicationDetailsStore.error =
          'Failed to remove you from Tentative Queue.';
      developer.log('Failed to remove you from Tentative Queue.', error: error);
    }
  }

  @action
  Future<void> addToTentativeQueue(String tentativeId) async {
    try {
      var updatedTentativeQueue = await _clashBotService.addToTentativeQueue(
          _applicationDetailsStore.id, tentativeId);
      updateTentativeQueue(updatedTentativeQueue);
    } on Exception catch (error) {
      _applicationDetailsStore.error = 'Failed to add you to Tentative Queue.';
      developer.log('Failed to add you to Tentative Queue.', error: error);
    }
  }

  @action
  Future<void> toggleSubscription(SubscriptionType type) async {
    try {
      Subscription? update;
      if (subscriptions[type.value]?.isOn ?? false) {
        update = await _clashBotService.unsubscribe(
                  _applicationDetailsStore.id, type);
      } else {
        update = await _clashBotService.subscribe(
                  _applicationDetailsStore.id, type);
      }
      if (null != update) {
        subscriptions[type.value] = update;
      }
    } on Exception catch (error) {
      _applicationDetailsStore.error = 'Failed to subscribe to ${type.value}';
      developer.log('Failed to subscribe to ${type.value}', error: error);
    }
  }
}
