class ClashNotification {
  final String uuid;
  bool read;
  final String message;
  final String causedBy;
  final String serverId;
  final DateTime timestamp;

  ClashNotification(this.uuid, this.read, this.message, this.causedBy, this.serverId, this.timestamp);
}