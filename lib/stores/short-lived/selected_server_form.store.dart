import 'package:mobx/mobx.dart';

part 'selected_server_form.store.g.dart';

class SelectedServerFormStore extends _SelectedServerFormStore
    with _$SelectedServerFormStore {}

abstract class _SelectedServerFormStore with Store {
  @observable
  ObservableList<String> listOfSelectedServers = ObservableList<String>();

  @observable
  String errorMessage = '';

  @computed
  bool get invalidState => errorMessage != '';

  @computed
  bool get ableToSubmit =>
      listOfSelectedServers.isNotEmpty && listOfSelectedServers.length < 6;

  bool get maxServersReached => listOfSelectedServers.length == 5;

  @observable
  bool submitting = false;

  @observable
  bool callFailed = false;

  @action
  void addServer(String serverId) {
    listOfSelectedServers.add(serverId);
  }

  @action
  void removeServer(String serverId) {
    listOfSelectedServers.remove(serverId);
  }

  @action
  void submittingForm() {
    submitting = true;
  }
}
