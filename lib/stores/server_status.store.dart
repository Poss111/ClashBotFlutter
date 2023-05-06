
import 'package:clash_bot_api/api.dart';
import 'package:mobx/mobx.dart';
part 'server_status.store.g.dart';

class ServerStatusStore = _ServerStatusStore with _$ServerStatusStore;

abstract class _ServerStatusStore with Store {

  @observable
  ObservableList<Team> teams = ObservableList<Team>();

  @observable
  ObservableList<Tentative> tentatives = ObservableList<Tentative>();

  @action
  void addTeam(Team team) {
    teams.add(team);
  }

  @action
  void removeTeam(String id) {
    teams.removeWhere((team) => team.id == id);
  }

  @action
  void addTentative(Tentative tentative) {
    tentatives.add(tentative);
  }

  @action
  void removeTenantive(String id) {
    tentatives.removeWhere((tentative) => tentative.id == id);
  }

}