// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_tentative_form.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateTentativeFormStore on _CreateTentativeFormStoreBase, Store {
  Computed<bool>? _$ableToSubmitComputed;

  @override
  bool get ableToSubmit =>
      (_$ableToSubmitComputed ??= Computed<bool>(() => super.ableToSubmit,
              name: '_CreateTentativeFormStoreBase.ableToSubmit'))
          .value;

  late final _$clashTournamentAtom = Atom(
      name: '_CreateTentativeFormStoreBase.clashTournament', context: context);

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
      Atom(name: '_CreateTentativeFormStoreBase.serverId', context: context);

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

  late final _$submitAsyncAction =
      AsyncAction('_CreateTentativeFormStoreBase.submit', context: context);

  @override
  Future<void> submit() {
    return _$submitAsyncAction.run(() => super.submit());
  }

  @override
  String toString() {
    return '''
clashTournament: ${clashTournament},
serverId: ${serverId},
ableToSubmit: ${ableToSubmit}
    ''';
  }
}
