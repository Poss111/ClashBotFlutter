// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clashbot_player.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClashPlayerStore on _ClashPlayerStore, Store {
  Computed<List<ClashTournament>>? _$availableTentativeTournamentsComputed;

  @override
  List<ClashTournament> get availableTentativeTournaments =>
      (_$availableTentativeTournamentsComputed ??=
              Computed<List<ClashTournament>>(
                  () => super.availableTentativeTournaments,
                  name: '_ClashPlayerStore.availableTentativeTournaments'))
          .value;
  Computed<int>? _$numberOfTeamsComputed;

  @override
  int get numberOfTeams =>
      (_$numberOfTeamsComputed ??= Computed<int>(() => super.numberOfTeams,
              name: '_ClashPlayerStore.numberOfTeams'))
          .value;
  Computed<int>? _$numberOfTentativeQueuesComputed;

  @override
  int get numberOfTentativeQueues => (_$numberOfTentativeQueuesComputed ??=
          Computed<int>(() => super.numberOfTentativeQueues,
              name: '_ClashPlayerStore.numberOfTentativeQueues'))
      .value;
  Computed<Map<String, List<ClashTeam>>>? _$mapOfClashTeamsToServerComputed;

  @override
  Map<String, List<ClashTeam>> get mapOfClashTeamsToServer =>
      (_$mapOfClashTeamsToServerComputed ??=
              Computed<Map<String, List<ClashTeam>>>(
                  () => super.mapOfClashTeamsToServer,
                  name: '_ClashPlayerStore.mapOfClashTeamsToServer'))
          .value;
  Computed<ObservableList<ClashTeam>>? _$filteredTeamsListComputed;

  @override
  ObservableList<ClashTeam> get filteredTeamsList =>
      (_$filteredTeamsListComputed ??= Computed<ObservableList<ClashTeam>>(
              () => super.filteredTeamsList,
              name: '_ClashPlayerStore.filteredTeamsList'))
          .value;
  Computed<ObservableList<TentativeQueue>>? _$filteredTentativeQueuesComputed;

  @override
  ObservableList<TentativeQueue> get filteredTentativeQueues =>
      (_$filteredTentativeQueuesComputed ??=
              Computed<ObservableList<TentativeQueue>>(
                  () => super.filteredTentativeQueues,
                  name: '_ClashPlayerStore.filteredTentativeQueues'))
          .value;
  Computed<bool>? _$canAddMorePreferredChampionsComputed;

  @override
  bool get canAddMorePreferredChampions =>
      (_$canAddMorePreferredChampionsComputed ??= Computed<bool>(
              () => super.canAddMorePreferredChampions,
              name: '_ClashPlayerStore.canAddMorePreferredChampions'))
          .value;
  Computed<bool>? _$canAddMoreSelectedServersComputed;

  @override
  bool get canAddMoreSelectedServers => (_$canAddMoreSelectedServersComputed ??=
          Computed<bool>(() => super.canAddMoreSelectedServers,
              name: '_ClashPlayerStore.canAddMoreSelectedServers'))
      .value;
  Computed<bool>? _$clashBotUserDetailsLoadedComputed;

  @override
  bool get clashBotUserDetailsLoaded => (_$clashBotUserDetailsLoadedComputed ??=
          Computed<bool>(() => super.clashBotUserDetailsLoaded,
              name: '_ClashPlayerStore.clashBotUserDetailsLoaded'))
      .value;

  late final _$clashBotUserAtom =
      Atom(name: '_ClashPlayerStore.clashBotUser', context: context);

  @override
  ClashBotUser get clashBotUser {
    _$clashBotUserAtom.reportRead();
    return super.clashBotUser;
  }

  @override
  set clashBotUser(ClashBotUser value) {
    _$clashBotUserAtom.reportWrite(value, super.clashBotUser, () {
      super.clashBotUser = value;
    });
  }

  late final _$currentClashTeamsAtom =
      Atom(name: '_ClashPlayerStore.currentClashTeams', context: context);

  @override
  ObservableList<ClashTeam> get currentClashTeams {
    _$currentClashTeamsAtom.reportRead();
    return super.currentClashTeams;
  }

  @override
  set currentClashTeams(ObservableList<ClashTeam> value) {
    _$currentClashTeamsAtom.reportWrite(value, super.currentClashTeams, () {
      super.currentClashTeams = value;
    });
  }

  late final _$currentTentativeQueuesAtom =
      Atom(name: '_ClashPlayerStore.currentTentativeQueues', context: context);

  @override
  ObservableList<TentativeQueue> get currentTentativeQueues {
    _$currentTentativeQueuesAtom.reportRead();
    return super.currentTentativeQueues;
  }

  @override
  set currentTentativeQueues(ObservableList<TentativeQueue> value) {
    _$currentTentativeQueuesAtom
        .reportWrite(value, super.currentTentativeQueues, () {
      super.currentTentativeQueues = value;
    });
  }

  late final _$showTeamsAtom =
      Atom(name: '_ClashPlayerStore.showTeams', context: context);

  @override
  bool get showTeams {
    _$showTeamsAtom.reportRead();
    return super.showTeams;
  }

  @override
  set showTeams(bool value) {
    _$showTeamsAtom.reportWrite(value, super.showTeams, () {
      super.showTeams = value;
    });
  }

  late final _$callInProgressAtom =
      Atom(name: '_ClashPlayerStore.callInProgress', context: context);

  @override
  bool get callInProgress {
    _$callInProgressAtom.reportRead();
    return super.callInProgress;
  }

  @override
  set callInProgress(bool value) {
    _$callInProgressAtom.reportWrite(value, super.callInProgress, () {
      super.callInProgress = value;
    });
  }

  late final _$selectedServerNameAtom =
      Atom(name: '_ClashPlayerStore.selectedServerName', context: context);

  @override
  String? get selectedServerName {
    _$selectedServerNameAtom.reportRead();
    return super.selectedServerName;
  }

  @override
  set selectedServerName(String? value) {
    _$selectedServerNameAtom.reportWrite(value, super.selectedServerName, () {
      super.selectedServerName = value;
    });
  }

  late final _$serverFilterAtom =
      Atom(name: '_ClashPlayerStore.serverFilter', context: context);

  @override
  String? get serverFilter {
    _$serverFilterAtom.reportRead();
    return super.serverFilter;
  }

  @override
  set serverFilter(String? value) {
    _$serverFilterAtom.reportWrite(value, super.serverFilter, () {
      super.serverFilter = value;
    });
  }

  late final _$tournamentNameFilterAtom =
      Atom(name: '_ClashPlayerStore.tournamentNameFilter', context: context);

  @override
  String? get tournamentNameFilter {
    _$tournamentNameFilterAtom.reportRead();
    return super.tournamentNameFilter;
  }

  @override
  set tournamentNameFilter(String? value) {
    _$tournamentNameFilterAtom.reportWrite(value, super.tournamentNameFilter,
        () {
      super.tournamentNameFilter = value;
    });
  }

  late final _$tournamentDayFilterAtom =
      Atom(name: '_ClashPlayerStore.tournamentDayFilter', context: context);

  @override
  String? get tournamentDayFilter {
    _$tournamentDayFilterAtom.reportRead();
    return super.tournamentDayFilter;
  }

  @override
  set tournamentDayFilter(String? value) {
    _$tournamentDayFilterAtom.reportWrite(value, super.tournamentDayFilter, () {
      super.tournamentDayFilter = value;
    });
  }

  late final _$championsAtom =
      Atom(name: '_ClashPlayerStore.champions', context: context);

  @override
  ObservableList<String> get champions {
    _$championsAtom.reportRead();
    return super.champions;
  }

  @override
  set champions(ObservableList<String> value) {
    _$championsAtom.reportWrite(value, super.champions, () {
      super.champions = value;
    });
  }

  late final _$subscriptionsAtom =
      Atom(name: '_ClashPlayerStore.subscriptions', context: context);

  @override
  ObservableMap<String, Subscription> get subscriptions {
    _$subscriptionsAtom.reportRead();
    return super.subscriptions;
  }

  @override
  set subscriptions(ObservableMap<String, Subscription> value) {
    _$subscriptionsAtom.reportWrite(value, super.subscriptions, () {
      super.subscriptions = value;
    });
  }

  late final _$selectedServersAtom =
      Atom(name: '_ClashPlayerStore.selectedServers', context: context);

  @override
  ObservableList<String> get selectedServers {
    _$selectedServersAtom.reportRead();
    return super.selectedServers;
  }

  @override
  set selectedServers(ObservableList<String> value) {
    _$selectedServersAtom.reportWrite(value, super.selectedServers, () {
      super.selectedServers = value;
    });
  }

  late final _$createUserAsyncAction =
      AsyncAction('_ClashPlayerStore.createUser', context: context);

  @override
  Future<ClashBotUser> createUser(
      String defaultServerId, List<String> selectedServersToUse) {
    return _$createUserAsyncAction
        .run(() => super.createUser(defaultServerId, selectedServersToUse));
  }

  late final _$refreshClashBotUserDetailsAsyncAction = AsyncAction(
      '_ClashPlayerStore.refreshClashBotUserDetails',
      context: context);

  @override
  Future<void> refreshClashBotUserDetails() {
    return _$refreshClashBotUserDetailsAsyncAction
        .run(() => super.refreshClashBotUserDetails());
  }

  late final _$addChampionAsyncAction =
      AsyncAction('_ClashPlayerStore.addChampion', context: context);

  @override
  Future<void> addChampion(String name) {
    return _$addChampionAsyncAction.run(() => super.addChampion(name));
  }

  late final _$removeChampionAsyncAction =
      AsyncAction('_ClashPlayerStore.removeChampion', context: context);

  @override
  Future<void> removeChampion(String name) {
    return _$removeChampionAsyncAction.run(() => super.removeChampion(name));
  }

  late final _$overwriteChampionsAsyncAction =
      AsyncAction('_ClashPlayerStore.overwriteChampions', context: context);

  @override
  Future<void> overwriteChampions(List<String> newChampions) {
    return _$overwriteChampionsAsyncAction
        .run(() => super.overwriteChampions(newChampions));
  }

  late final _$overwriteSelectedServersAsyncAction = AsyncAction(
      '_ClashPlayerStore.overwriteSelectedServers',
      context: context);

  @override
  Future<void> overwriteSelectedServers(List<String> selectedServerIds) {
    return _$overwriteSelectedServersAsyncAction
        .run(() => super.overwriteSelectedServers(selectedServerIds));
  }

  late final _$addSelectedServerAsyncAction =
      AsyncAction('_ClashPlayerStore.addSelectedServer', context: context);

  @override
  Future<void> addSelectedServer(String selectedServerId) {
    return _$addSelectedServerAsyncAction
        .run(() => super.addSelectedServer(selectedServerId));
  }

  late final _$removeSelectedServerAsyncAction =
      AsyncAction('_ClashPlayerStore.removeSelectedServer', context: context);

  @override
  Future<void> removeSelectedServer(String selectedServerId) {
    return _$removeSelectedServerAsyncAction
        .run(() => super.removeSelectedServer(selectedServerId));
  }

  late final _$refreshTeamListAsyncAction =
      AsyncAction('_ClashPlayerStore.refreshTeamList', context: context);

  @override
  Future<void> refreshTeamList() {
    return _$refreshTeamListAsyncAction.run(() => super.refreshTeamList());
  }

  late final _$refreshTentativeQueueAsyncAction =
      AsyncAction('_ClashPlayerStore.refreshTentativeQueue', context: context);

  @override
  Future<void> refreshTentativeQueue() {
    return _$refreshTentativeQueueAsyncAction
        .run(() => super.refreshTentativeQueue());
  }

  late final _$createTeamAsyncAction =
      AsyncAction('_ClashPlayerStore.createTeam', context: context);

  @override
  Future<void> createTeam(String name, Role role, String serverId,
      String tournamentName, String tournamentDay) {
    return _$createTeamAsyncAction.run(() =>
        super.createTeam(name, role, serverId, tournamentName, tournamentDay));
  }

  late final _$removeFromTeamAsyncAction =
      AsyncAction('_ClashPlayerStore.removeFromTeam', context: context);

  @override
  Future<void> removeFromTeam(String teamId) {
    return _$removeFromTeamAsyncAction.run(() => super.removeFromTeam(teamId));
  }

  late final _$addToTeamAsyncAction =
      AsyncAction('_ClashPlayerStore.addToTeam', context: context);

  @override
  Future<void> addToTeam(Role role, String teamId) {
    return _$addToTeamAsyncAction.run(() => super.addToTeam(role, teamId));
  }

  late final _$createTentativeQueueAsyncAction =
      AsyncAction('_ClashPlayerStore.createTentativeQueue', context: context);

  @override
  Future<void> createTentativeQueue(
      String serverId, String tournamentName, String tournamentDay) {
    return _$createTentativeQueueAsyncAction.run(() =>
        super.createTentativeQueue(serverId, tournamentName, tournamentDay));
  }

  late final _$removeFromTentativeQueueAsyncAction = AsyncAction(
      '_ClashPlayerStore.removeFromTentativeQueue',
      context: context);

  @override
  Future<void> removeFromTentativeQueue(String tentativeId) {
    return _$removeFromTentativeQueueAsyncAction
        .run(() => super.removeFromTentativeQueue(tentativeId));
  }

  late final _$addToTentativeQueueAsyncAction =
      AsyncAction('_ClashPlayerStore.addToTentativeQueue', context: context);

  @override
  Future<void> addToTentativeQueue(String tentativeId) {
    return _$addToTentativeQueueAsyncAction
        .run(() => super.addToTentativeQueue(tentativeId));
  }

  late final _$toggleSubscriptionAsyncAction =
      AsyncAction('_ClashPlayerStore.toggleSubscription', context: context);

  @override
  Future<void> toggleSubscription(SubscriptionType type) {
    return _$toggleSubscriptionAsyncAction
        .run(() => super.toggleSubscription(type));
  }

  late final _$_ClashPlayerStoreActionController =
      ActionController(name: '_ClashPlayerStore', context: context);

  @override
  void setCallInProgess() {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.setCallInProgess');
    try {
      return super.setCallInProgess();
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void callFinished() {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.callFinished');
    try {
      return super.callFinished();
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showTeamsView() {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.showTeamsView');
    try {
      return super.showTeamsView();
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void showTentativeView() {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.showTentativeView');
    try {
      return super.showTentativeView();
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterByServer(String serverId) {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.filterByServer');
    try {
      return super.filterByServer(serverId);
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterByTournamentName(String tournamentName) {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.filterByTournamentName');
    try {
      return super.filterByTournamentName(tournamentName);
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void filterByTournamentDay(String tournamentDay) {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.filterByTournamentDay');
    try {
      return super.filterByTournamentDay(tournamentDay);
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addClashTeam(ClashTeam clashTeamToAdd) {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.addClashTeam');
    try {
      return super.addClashTeam(clashTeamToAdd);
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeClashTeams(ClashTeam clashTeamToRemove) {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.removeClashTeams');
    try {
      return super.removeClashTeams(clashTeamToRemove);
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateClashTeam(ClashTeam updatedClashTeam) {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.updateClashTeam');
    try {
      return super.updateClashTeam(updatedClashTeam);
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTentativeQueue(TentativeQueue tentativeQueueToAdd) {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.addTentativeQueue');
    try {
      return super.addTentativeQueue(tentativeQueueToAdd);
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTentativeQueue(TentativeQueue tentativeQueueToRemove) {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.removeTentativeQueue');
    try {
      return super.removeTentativeQueue(tentativeQueueToRemove);
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateTentativeQueue(TentativeQueue updatedTentativeQueue) {
    final _$actionInfo = _$_ClashPlayerStoreActionController.startAction(
        name: '_ClashPlayerStore.updateTentativeQueue');
    try {
      return super.updateTentativeQueue(updatedTentativeQueue);
    } finally {
      _$_ClashPlayerStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
clashBotUser: ${clashBotUser},
currentClashTeams: ${currentClashTeams},
currentTentativeQueues: ${currentTentativeQueues},
showTeams: ${showTeams},
callInProgress: ${callInProgress},
selectedServerName: ${selectedServerName},
serverFilter: ${serverFilter},
tournamentNameFilter: ${tournamentNameFilter},
tournamentDayFilter: ${tournamentDayFilter},
champions: ${champions},
subscriptions: ${subscriptions},
selectedServers: ${selectedServers},
availableTentativeTournaments: ${availableTentativeTournaments},
numberOfTeams: ${numberOfTeams},
numberOfTentativeQueues: ${numberOfTentativeQueues},
mapOfClashTeamsToServer: ${mapOfClashTeamsToServer},
filteredTeamsList: ${filteredTeamsList},
filteredTentativeQueues: ${filteredTentativeQueues},
canAddMorePreferredChampions: ${canAddMorePreferredChampions},
canAddMoreSelectedServers: ${canAddMoreSelectedServers},
clashBotUserDetailsLoaded: ${clashBotUserDetailsLoaded}
    ''';
  }
}
