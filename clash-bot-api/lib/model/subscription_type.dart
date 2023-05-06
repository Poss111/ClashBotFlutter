//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

/// The type of User subscription.
class SubscriptionType {
  /// Instantiate a new enum with the provided [value].
  const SubscriptionType._(this.value);

  /// The underlying value of this enum member.
  final String value;

  @override
  String toString() => value;

  String toJson() => value;

  static const DISCORD_MONDAY_NOTIFICATION = SubscriptionType._(r'DISCORD_MONDAY_NOTIFICATION');

  /// List of all possible values in this [enum][SubscriptionType].
  static const values = <SubscriptionType>[
    DISCORD_MONDAY_NOTIFICATION,
  ];

  static SubscriptionType? fromJson(dynamic value) => SubscriptionTypeTypeTransformer().decode(value);

  static List<SubscriptionType>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SubscriptionType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SubscriptionType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SubscriptionType] to String,
/// and [decode] dynamic data back to [SubscriptionType].
class SubscriptionTypeTypeTransformer {
  factory SubscriptionTypeTypeTransformer() => _instance ??= const SubscriptionTypeTypeTransformer._();

  const SubscriptionTypeTypeTransformer._();

  String encode(SubscriptionType data) => data.value;

  /// Decodes a [dynamic value][data] to a SubscriptionType.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SubscriptionType? decode(dynamic data, {bool allowNull = true}) {
    if (data != null) {
      switch (data.toString()) {
        case r'DISCORD_MONDAY_NOTIFICATION': return SubscriptionType.DISCORD_MONDAY_NOTIFICATION;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// Singleton [SubscriptionTypeTypeTransformer] instance.
  static SubscriptionTypeTypeTransformer? _instance;
}

