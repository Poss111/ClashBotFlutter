// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_server_form.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SelectedServerFormStore on _SelectedServerFormStore, Store {
  Computed<bool>? _$invalidStateComputed;

  @override
  bool get invalidState =>
      (_$invalidStateComputed ??= Computed<bool>(() => super.invalidState,
              name: '_SelectedServerFormStore.invalidState'))
          .value;
  Computed<bool>? _$ableToSubmitComputed;

  @override
  bool get ableToSubmit =>
      (_$ableToSubmitComputed ??= Computed<bool>(() => super.ableToSubmit,
              name: '_SelectedServerFormStore.ableToSubmit'))
          .value;

  late final _$listOfSelectedServersAtom = Atom(
      name: '_SelectedServerFormStore.listOfSelectedServers', context: context);

  @override
  ObservableList<String> get listOfSelectedServers {
    _$listOfSelectedServersAtom.reportRead();
    return super.listOfSelectedServers;
  }

  @override
  set listOfSelectedServers(ObservableList<String> value) {
    _$listOfSelectedServersAtom.reportWrite(value, super.listOfSelectedServers,
        () {
      super.listOfSelectedServers = value;
    });
  }

  late final _$errorMessageAtom =
      Atom(name: '_SelectedServerFormStore.errorMessage', context: context);

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$submittingAtom =
      Atom(name: '_SelectedServerFormStore.submitting', context: context);

  @override
  bool get submitting {
    _$submittingAtom.reportRead();
    return super.submitting;
  }

  @override
  set submitting(bool value) {
    _$submittingAtom.reportWrite(value, super.submitting, () {
      super.submitting = value;
    });
  }

  late final _$callFailedAtom =
      Atom(name: '_SelectedServerFormStore.callFailed', context: context);

  @override
  bool get callFailed {
    _$callFailedAtom.reportRead();
    return super.callFailed;
  }

  @override
  set callFailed(bool value) {
    _$callFailedAtom.reportWrite(value, super.callFailed, () {
      super.callFailed = value;
    });
  }

  late final _$_SelectedServerFormStoreActionController =
      ActionController(name: '_SelectedServerFormStore', context: context);

  @override
  void addServer(String serverId) {
    final _$actionInfo = _$_SelectedServerFormStoreActionController.startAction(
        name: '_SelectedServerFormStore.addServer');
    try {
      return super.addServer(serverId);
    } finally {
      _$_SelectedServerFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void removeServer(String serverId) {
    final _$actionInfo = _$_SelectedServerFormStoreActionController.startAction(
        name: '_SelectedServerFormStore.removeServer');
    try {
      return super.removeServer(serverId);
    } finally {
      _$_SelectedServerFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void submittingForm() {
    final _$actionInfo = _$_SelectedServerFormStoreActionController.startAction(
        name: '_SelectedServerFormStore.submittingForm');
    try {
      return super.submittingForm();
    } finally {
      _$_SelectedServerFormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listOfSelectedServers: ${listOfSelectedServers},
errorMessage: ${errorMessage},
submitting: ${submitting},
callFailed: ${callFailed},
invalidState: ${invalidState},
ableToSubmit: ${ableToSubmit}
    ''';
  }
}
