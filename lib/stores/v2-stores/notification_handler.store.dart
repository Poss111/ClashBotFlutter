import 'package:clashbot_flutter/models/notification.dart';
import 'package:mobx/mobx.dart';

part 'notification_handler.store.g.dart';

class NotificationHandlerStore = _NotificationHandlerStore
    with _$NotificationHandlerStore;

abstract class _NotificationHandlerStore with Store {
  @observable
  Notification notification = Notification(
    '',
    NotificationType.ERROR,
  );

  @observable
  bool irreconcilable = false;

  @action
  void setIrreconcilable() {
    irreconcilable = true;
  }

  @action
  void clearIrreconcilable() {
    irreconcilable = false;
  }

  @action
  void setNotification(Notification notification) {
    this.notification = notification;
  }

  @action
  void clearNotification() {
    notification = Notification('', NotificationType.ERROR);
  }
}
