// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_status.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ServerStatusStore on _ServerStatusStore, Store {
  late final _$teamsAtom =
      Atom(name: '_ServerStatusStore.teams', context: context);

  @override
  ObservableList<Team> get teams {
    _$teamsAtom.reportRead();
    return super.teams;
  }

  @override
  set teams(ObservableList<Team> value) {
    _$teamsAtom.reportWrite(value, super.teams, () {
      super.teams = value;
    });
  }

  late final _$tentativesAtom =
      Atom(name: '_ServerStatusStore.tentatives', context: context);

  @override
  ObservableList<Tentative> get tentatives {
    _$tentativesAtom.reportRead();
    return super.tentatives;
  }

  @override
  set tentatives(ObservableList<Tentative> value) {
    _$tentativesAtom.reportWrite(value, super.tentatives, () {
      super.tentatives = value;
    });
  }

  late final _$_ServerStatusStoreActionController =
      ActionController(name: '_ServerStatusStore', context: context);

  @override
  void addTeam(Team team) {
    final _$actionInfo = _$_ServerStatusStoreActionController.startAction(
        name: '_ServerStatusStore.addTeam');
    try {
      return super.addTeam(team);
    } finally {
      _$_ServerStatusStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTeam(String id) {
    final _$actionInfo = _$_ServerStatusStoreActionController.startAction(
        name: '_ServerStatusStore.removeTeam');
    try {
      return super.removeTeam(id);
    } finally {
      _$_ServerStatusStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addTentative(Tentative tentative) {
    final _$actionInfo = _$_ServerStatusStoreActionController.startAction(
        name: '_ServerStatusStore.addTentative');
    try {
      return super.addTentative(tentative);
    } finally {
      _$_ServerStatusStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeTenantive(String id) {
    final _$actionInfo = _$_ServerStatusStoreActionController.startAction(
        name: '_ServerStatusStore.removeTenantive');
    try {
      return super.removeTenantive(id);
    } finally {
      _$_ServerStatusStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
teams: ${teams},
tentatives: ${tentatives}
    ''';
  }
}
