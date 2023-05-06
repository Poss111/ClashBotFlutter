// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_champion_form.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LeagueChampionForm on _LeagueChampionFormBase, Store {
  late final _$errorAtom =
      Atom(name: '_LeagueChampionFormBase.error', context: context);

  @override
  String? get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String? value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$championNameAtom =
      Atom(name: '_LeagueChampionFormBase.championName', context: context);

  @override
  String get championName {
    _$championNameAtom.reportRead();
    return super.championName;
  }

  @override
  set championName(String value) {
    _$championNameAtom.reportWrite(value, super.championName, () {
      super.championName = value;
    });
  }

  late final _$validateUsernameAsyncAction =
      AsyncAction('_LeagueChampionFormBase.validateUsername', context: context);

  @override
  Future<dynamic> validateUsername(String value) {
    return _$validateUsernameAsyncAction
        .run(() => super.validateUsername(value));
  }

  @override
  String toString() {
    return '''
error: ${error},
championName: ${championName}
    ''';
  }
}
