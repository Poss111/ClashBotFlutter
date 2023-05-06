// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_team_form.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateTeamFormStore on _CreateTeamFormStoreBase, Store {
  Computed<bool>? _$ableToSubmitComputed;

  @override
  bool get ableToSubmit =>
      (_$ableToSubmitComputed ??= Computed<bool>(() => super.ableToSubmit,
              name: '_CreateTeamFormStoreBase.ableToSubmit'))
          .value;

  late final _$teamNameAtom =
      Atom(name: '_CreateTeamFormStoreBase.teamName', context: context);

  @override
  String? get teamName {
    _$teamNameAtom.reportRead();
    return super.teamName;
  }

  @override
  set teamName(String? value) {
    _$teamNameAtom.reportWrite(value, super.teamName, () {
      super.teamName = value;
    });
  }

  late final _$clashTournamentAtom =
      Atom(name: '_CreateTeamFormStoreBase.clashTournament', context: context);

  @override
  ClashTournament? get clashTournament {
    _$clashTournamentAtom.reportRead();
    return super.clashTournament;
  }

  @override
  set clashTournament(ClashTournament? value) {
    _$clashTournamentAtom.reportWrite(value, super.clashTournament, () {
      super.clashTournament = value;
    });
  }

  late final _$serverIdAtom =
      Atom(name: '_CreateTeamFormStoreBase.serverId', context: context);

  @override
  String? get serverId {
    _$serverIdAtom.reportRead();
    return super.serverId;
  }

  @override
  set serverId(String? value) {
    _$serverIdAtom.reportWrite(value, super.serverId, () {
      super.serverId = value;
    });
  }

  late final _$roleAtom =
      Atom(name: '_CreateTeamFormStoreBase.role', context: context);

  @override
  Role? get role {
    _$roleAtom.reportRead();
    return super.role;
  }

  @override
  set role(Role? value) {
    _$roleAtom.reportWrite(value, super.role, () {
      super.role = value;
    });
  }

  late final _$submitAsyncAction =
      AsyncAction('_CreateTeamFormStoreBase.submit', context: context);

  @override
  Future<void> submit() {
    return _$submitAsyncAction.run(() => super.submit());
  }

  @override
  String toString() {
    return '''
teamName: ${teamName},
clashTournament: ${clashTournament},
serverId: ${serverId},
role: ${role},
ableToSubmit: ${ableToSubmit}
    ''';
  }
}
