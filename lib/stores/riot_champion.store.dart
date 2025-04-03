import 'package:clashbot_flutter/models/lol_champion.dart';
import 'package:clashbot_flutter/services/riot_resources_service.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/notification_handler.store.dart';
import 'package:mobx/mobx.dart';
part 'riot_champion.store.g.dart';

class RiotChampionStore = _RiotChampionStore with _$RiotChampionStore;

abstract class _RiotChampionStore with Store {
  RiotResourcesService _riotResourcesService;
  NotificationHandlerStore _errorHandlerStore;
  _RiotChampionStore(this._riotResourcesService, this._errorHandlerStore);

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
