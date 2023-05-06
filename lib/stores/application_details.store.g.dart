// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'application_details.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ApplicationDetailsStore on _ApplicationDetailsStore, Store {
  Computed<List<ClashNotification>>? _$sortedNotificationsComputed;

  @override
  List<ClashNotification> get sortedNotifications =>
      (_$sortedNotificationsComputed ??= Computed<List<ClashNotification>>(
              () => super.sortedNotifications,
              name: '_ApplicationDetailsStore.sortedNotifications'))
          .value;
  Computed<List<ClashNotification>>? _$unreadNotificationsComputed;

  @override
  List<ClashNotification> get unreadNotifications =>
      (_$unreadNotificationsComputed ??= Computed<List<ClashNotification>>(
              () => super.unreadNotifications,
              name: '_ApplicationDetailsStore.unreadNotifications'))
          .value;
  Computed<bool>? _$isLoggedInComputed;

  @override
  bool get isLoggedIn =>
      (_$isLoggedInComputed ??= Computed<bool>(() => super.isLoggedIn,
              name: '_ApplicationDetailsStore.isLoggedIn'))
          .value;

  late final _$idAtom =
      Atom(name: '_ApplicationDetailsStore.id', context: context);

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  late final _$tournamentsAtom =
      Atom(name: '_ApplicationDetailsStore.tournaments', context: context);

  @override
  ObservableList<ClashTournament> get tournaments {
    _$tournamentsAtom.reportRead();
    return super.tournaments;
  }

  @override
  set tournaments(ObservableList<ClashTournament> value) {
    _$tournamentsAtom.reportWrite(value, super.tournaments, () {
      super.tournaments = value;
    });
  }

  late final _$errorAtom =
      Atom(name: '_ApplicationDetailsStore.error', context: context);

  @override
  String get error {
    _$errorAtom.reportRead();
    return super.error;
  }

  @override
  set error(String value) {
    _$errorAtom.reportWrite(value, super.error, () {
      super.error = value;
    });
  }

  late final _$notificationsAtom =
      Atom(name: '_ApplicationDetailsStore.notifications', context: context);

  @override
  ObservableList<ClashNotification> get notifications {
    _$notificationsAtom.reportRead();
    return super.notifications;
  }

  @override
  set notifications(ObservableList<ClashNotification> value) {
    _$notificationsAtom.reportWrite(value, super.notifications, () {
      super.notifications = value;
    });
  }

  late final _$getTournamentsAsyncAction =
      AsyncAction('_ApplicationDetailsStore.getTournaments', context: context);

  @override
  Future<void> getTournaments() {
    return _$getTournamentsAsyncAction.run(() => super.getTournaments());
  }

  late final _$loadUserDetailsAsyncAction =
      AsyncAction('_ApplicationDetailsStore.loadUserDetails', context: context);

  @override
  Future<void> loadUserDetails() {
    return _$loadUserDetailsAsyncAction.run(() => super.loadUserDetails());
  }

  late final _$_ApplicationDetailsStoreActionController =
      ActionController(name: '_ApplicationDetailsStore', context: context);

  @override
  void triggerError(String errorMessage) {
    final _$actionInfo = _$_ApplicationDetailsStoreActionController.startAction(
        name: '_ApplicationDetailsStore.triggerError');
    try {
      return super.triggerError(errorMessage);
    } finally {
      _$_ApplicationDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void notifyUser(ClashNotification clashNotification) {
    final _$actionInfo = _$_ApplicationDetailsStoreActionController.startAction(
        name: '_ApplicationDetailsStore.notifyUser');
    try {
      return super.notifyUser(clashNotification);
    } finally {
      _$_ApplicationDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void readNotification(String uuid) {
    final _$actionInfo = _$_ApplicationDetailsStoreActionController.startAction(
        name: '_ApplicationDetailsStore.readNotification');
    try {
      return super.readNotification(uuid);
    } finally {
      _$_ApplicationDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void unsubscribeFromServer(String serverId) {
    final _$actionInfo = _$_ApplicationDetailsStoreActionController.startAction(
        name: '_ApplicationDetailsStore.unsubscribeFromServer');
    try {
      return super.unsubscribeFromServer(serverId);
    } finally {
      _$_ApplicationDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void subscribeToServer(String serverId) {
    final _$actionInfo = _$_ApplicationDetailsStoreActionController.startAction(
        name: '_ApplicationDetailsStore.subscribeToServer');
    try {
      return super.subscribeToServer(serverId);
    } finally {
      _$_ApplicationDetailsStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
id: ${id},
tournaments: ${tournaments},
error: ${error},
notifications: ${notifications},
sortedNotifications: ${sortedNotifications},
unreadNotifications: ${unreadNotifications},
isLoggedIn: ${isLoggedIn}
    ''';
  }
}
