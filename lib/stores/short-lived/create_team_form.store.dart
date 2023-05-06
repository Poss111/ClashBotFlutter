import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/clashbot_player.store.dart';
import 'package:mobx/mobx.dart';
import 'package:validators/validators.dart';
part 'create_team_form.store.g.dart';

class CreateTeamFormStore extends _CreateTeamFormStoreBase with _$CreateTeamFormStore {
  CreateTeamFormStore(ApplicationDetailsStore applicationDetailsStore): super(applicationDetailsStore);
}

abstract class _CreateTeamFormStoreBase with Store {
  ApplicationDetailsStore applicationDetailsStore;
  _CreateTeamFormStoreBase(this.applicationDetailsStore);

  @observable
  String? teamName;

  @observable
  ClashTournament? clashTournament;

  @observable
  String? serverId;

  @observable
  Role? role;

  @computed
  bool get ableToSubmit => !isNull(teamName)
    && null != clashTournament
    && !isNull(serverId)
    && null != role;

  @action
  Future<void> submit() async {
    if (ableToSubmit) {
      await applicationDetailsStore.loggedInClashUser.createTeam(
        teamName!,
        role!, 
        serverId!, 
        clashTournament!.tournamentName,
        clashTournament!.tournamentDay
      );
    }
  }
  
}