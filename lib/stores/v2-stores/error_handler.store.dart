import 'package:mobx/mobx.dart';

part 'error_handler.store.g.dart';

class ErrorHandlerStore = _ErrorHandlerStore with _$ErrorHandlerStore;

abstract class _ErrorHandlerStore with Store {
  @observable
  String errorMessage = '';

  @action
  void setErrorMessage(String message) {
    errorMessage = message;
  }

  @action
  void clearErrorMessage() {
    errorMessage = '';
  }
}
