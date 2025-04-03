class ClashBotEvent {
  const ClashBotEvent._(this.value);

  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const TEAM_UPDATE = ClashBotEvent._(r'TEAM_UPDATE');
  static const TEAM_CREATE = ClashBotEvent._(r'TEAM_CREATE');
  static const TEAM_JOINED = ClashBotEvent._(r'TEAM_JOINED');
  static const TEAM_REMOVED_FROM = ClashBotEvent._(r'TEAM_REMOVED_FROM');
  static const TEAM_REMOVED = ClashBotEvent._(r'TEAM_REMOVED');
  static const TENTATIVE_QUEUE_UPDATE =
      ClashBotEvent._(r'TENTATIVE_QUEUE_UPDATE');
  static const TENTATIVE_QUEUE_CREATE =
      ClashBotEvent._(r'TENTATIVE_QUEUE_CREATE');
  static const TENTATIVE_QUEUE_JOINED =
      ClashBotEvent._(r'TENTATIVE_QUEUE_JOINED');
  static const TENTATIVE_QUEUE_REMOVED =
      ClashBotEvent._(r'TENTATIVE_QUEUE_REMOVED');

  /// List of all possible values in this [enum][ClashBotEvent].
  static const values = <ClashBotEvent>[
    TEAM_UPDATE,
    TEAM_CREATE,
    TEAM_JOINED,
    TEAM_REMOVED_FROM,
    TEAM_REMOVED,
    TENTATIVE_QUEUE_UPDATE,
    TENTATIVE_QUEUE_CREATE,
    TENTATIVE_QUEUE_JOINED,
    TENTATIVE_QUEUE_REMOVED,
  ];

  static ClashBotEvent? fromJson(dynamic value) =>
      ClashBotEventTypeTransformer().decode(value);

  static List<ClashBotEvent>? listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <ClashBotEvent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClashBotEvent.fromJson(row);
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
class ClashBotEventTypeTransformer {
  factory ClashBotEventTypeTransformer() =>
      _instance ??= const ClashBotEventTypeTransformer._();

  const ClashBotEventTypeTransformer._();

  String encode(ClashBotEvent data) => data.value;

  /// Decodes a [dynamic value][data] to a EventType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ClashBotEvent? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case 'team_update':
          return ClashBotEvent.TEAM_UPDATE;
        case 'team_create':
          return ClashBotEvent.TEAM_CREATE;
        case 'team_joined':
          return ClashBotEvent.TEAM_JOINED;
        case 'team_removed_from':
          return ClashBotEvent.TEAM_REMOVED_FROM;
        case 'team_removed':
          return ClashBotEvent.TEAM_REMOVED;
        case 'tentative_queue_update':
          return ClashBotEvent.TENTATIVE_QUEUE_UPDATE;
        case 'tentative_queue_create':
          return ClashBotEvent.TENTATIVE_QUEUE_CREATE;
        case 'tentative_queue_joined':
          return ClashBotEvent.TENTATIVE_QUEUE_JOINED;
        case 'tentative_queue_removed':
          return ClashBotEvent.TENTATIVE_QUEUE_REMOVED;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [ClashBotEventTypeTransformer] instance.
  static ClashBotEventTypeTransformer? _instance;
}
