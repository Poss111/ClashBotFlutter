import 'package:mobx/mobx.dart';
part 'settings_rail.store.g.dart';

class SettingsRailStore = _SettingsRailStoreBase with _$SettingsRailStore;

abstract class _SettingsRailStoreBase with Store {

  @observable
  int selectedIndex = 0;

  @action
  void changeIndex(int index) {
    selectedIndex = index;
  }
  
}