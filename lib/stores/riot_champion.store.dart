import 'package:clashbot_flutter/models/lol_champion.dart';
import 'package:clashbot_flutter/services/riot_resources_service.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:mobx/mobx.dart';
part 'riot_champion.store.g.dart';

class RiotChampionStore extends _RiotChampionStoreBase
    with _$RiotChampionStore {
  RiotChampionStore(RiotResourcesService riotResourcesService,
      ApplicationDetailsStore applicationDetailsStore)
      : super(riotResourcesService, applicationDetailsStore);
}

abstract class _RiotChampionStoreBase with Store {
  ApplicationDetailsStore _applicationDetailsStore;
  RiotResourcesService _riotResourcesService;
  _RiotChampionStoreBase(
      this._riotResourcesService, this._applicationDetailsStore) {
    reaction((_) => _applicationDetailsStore.id, (_) {
      refreshChampionData();
    });
  }

  @observable
  LoLChampionsData lChampionsData = LoLChampionsData();

  @computed
  List<String> get championNames => lChampionsData.data?.keys.toList() ?? [];

  @computed
  bool get championDataLoaded => null != lChampionsData.data;

  @action
  Future<void> refreshChampionData() async {
    var championData = await _riotResourcesService.getChampionDetails();
    lChampionsData = championData;
  }
}
