import 'package:clashbot_flutter/models/lol_champion.dart';
import 'package:clashbot_flutter/services/riot_resources_service.dart';
import 'package:clashbot_flutter/services/riot_resources_service_impl.dart';
import 'package:mobx/mobx.dart';

import 'package:validators/validators.dart';
part 'league_champion_form.store.g.dart';

class LeagueChampionForm extends _LeagueChampionFormBase with _$LeagueChampionForm {
  LeagueChampionForm(LoLChampionsData lChampionsData) : super(lChampionsData) { }
}

abstract class _LeagueChampionFormBase with Store {
  final LoLChampionsData lChampionsData;
  _LeagueChampionFormBase(this.lChampionsData) {}

  @observable
  String? error;

  @observable
  String championName = '';

  List<String> championsNames = List.empty(growable: true);

  late ReactionDisposer _disposer;

  void initValidator() async {
    championsNames = lChampionsData.data?.keys.toList() ?? [];
    _disposer = reaction((_) => championName, validateUsername);
  }

  @action
  Future validateUsername(String value) async {
    if (isNull(value) || value.isEmpty) {
      error = 'Cannot be blank';
      return;
    }

    try {
      var championNameCheck = ObservableFuture(checkValidLoLChampionName(value));

      error = null;

      final isValid = await championNameCheck;
      if (!isValid) {
        error = '$value is not a valid LoL Champion name';
        return;
      }
    } on Object catch (_) {
      error = null;
    }

    error = null;
  }

  Future checkValidLoLChampionName(String value) async {
    await Future.delayed(const Duration(milliseconds: 500));

    return championsNames.contains(value);
  }

  void dispose() {
    _disposer();
  }
  
  
}
