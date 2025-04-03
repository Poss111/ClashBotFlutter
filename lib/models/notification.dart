class Notification {
  String message;
  NotificationType type;

  Notification(this.message, this.type);

  Notification.error(this.message) : type = NotificationType.ERROR;

  Notification.info(this.message) : type = NotificationType.INFO;

  Notification.debug(this.message) : type = NotificationType.DEBUG;

  Notification.warning(this.message) : type = NotificationType.WARNING;
}

class NotificationType {
  const NotificationType._(this.value, this.color);

  final String value;
  final String color;

  @override
  String toString() => value;

  String toJson() => value;

  static const ERROR = NotificationType._(r'ERROR', r'#F44336');
  static const INFO = NotificationType._(r'INFO', r'#4CAF50');
  static const DEBUG = NotificationType._(r'DEBUG', r'#2196F3');
  static const WARNING = NotificationType._(r'WARNING', r'#FFC107');

  /// List of all possible values in this [enum][NotificationType].
  static const values = <NotificationType>[
    ERROR,
    INFO,
    DEBUG,
    WARNING,
  ];

  static NotificationType? fromJson(dynamic value) =>
      NotificationTransformer().decode(value);

  static List<NotificationType>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <NotificationType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = NotificationType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ClashBotEvent] to String,
/// and [decode] dynamic data back to [ClashBotEvent].
class NotificationTransformer {
  factory NotificationTransformer() =>
      _instance ??= const NotificationTransformer._();

  const NotificationTransformer._();

  String encode(NotificationType data) => data.value;

  /// Decodes a [dynamic value][data] to a EventType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  NotificationType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case 'ERROR':
          return NotificationType.ERROR;
        case 'INFO':
          return NotificationType.INFO;
        case 'DEBUG':
          return NotificationType.DEBUG;
        case 'WARNING':
          return NotificationType.WARNING;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [NotificationTransformer] instance.
  static NotificationTransformer? _instance;
}
