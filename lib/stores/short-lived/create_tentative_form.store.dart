import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';
part 'create_tentative_form.store.g.dart';

class CreateTentativeFormStore extends _CreateTentativeFormStoreBase with _$CreateTentativeFormStore{
  CreateTentativeFormStore(ApplicationDetailsStore applicationDetailsStore): super(applicationDetailsStore);
}

abstract class _CreateTentativeFormStoreBase with Store {
  ApplicationDetailsStore applicationDetailsStore;
  _CreateTentativeFormStoreBase(this.applicationDetailsStore);

  @observable
  ClashTournament? clashTournament;

  @observable
  String? serverId;

  @computed
  bool get ableToSubmit => null != clashTournament
    && !isNull(serverId);

  @action
  Future<void> submit() async {
    if (ableToSubmit) {
      await applicationDetailsStore.loggedInClashUser.createTentativeQueue(
        serverId!, 
        clashTournament!.tournamentName,
        clashTournament!.tournamentDay
      );
    }
  }
  
}