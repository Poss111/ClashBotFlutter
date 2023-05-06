// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riot_champion.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RiotChampionStore on _RiotChampionStoreBase, Store {
  Computed<List<String>>? _$championNamesComputed;

  @override
  List<String> get championNames => (_$championNamesComputed ??=
          Computed<List<String>>(() => super.championNames,
              name: '_RiotChampionStoreBase.championNames'))
      .value;
  Computed<bool>? _$championDataLoadedComputed;

  @override
  bool get championDataLoaded => (_$championDataLoadedComputed ??=
          Computed<bool>(() => super.championDataLoaded,
              name: '_RiotChampionStoreBase.championDataLoaded'))
      .value;

  late final _$lChampionsDataAtom =
      Atom(name: '_RiotChampionStoreBase.lChampionsData', context: context);

  @override
  LoLChampionsData get lChampionsData {
    _$lChampionsDataAtom.reportRead();
    return super.lChampionsData;
  }

  @override
  set lChampionsData(LoLChampionsData value) {
    _$lChampionsDataAtom.reportWrite(value, super.lChampionsData, () {
      super.lChampionsData = value;
    });
  }

  late final _$refreshChampionDataAsyncAction = AsyncAction(
      '_RiotChampionStoreBase.refreshChampionData',
      context: context);

  @override
  Future<void> refreshChampionData() {
    return _$refreshChampionDataAsyncAction
        .run(() => super.refreshChampionData());
  }

  @override
  String toString() {
    return '''
lChampionsData: ${lChampionsData},
championNames: ${championNames},
championDataLoaded: ${championDataLoaded}
    ''';
  }
}
