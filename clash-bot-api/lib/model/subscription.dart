//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Subscription {
  /// Returns a new [Subscription] instance.
  Subscription({
    this.key,
    this.isOn,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  SubscriptionType? key;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  bool? isOn;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Subscription &&
     other.key == key &&
     other.isOn == isOn;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (key == null ? 0 : key!.hashCode) +
    (isOn == null ? 0 : isOn!.hashCode);

  @override
  String toString() => 'Subscription[key=$key, isOn=$isOn]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (key != null) {
      _json[r'key'] = key;
    } else {
      _json[r'key'] = null;
    }
    if (isOn != null) {
      _json[r'isOn'] = isOn;
    } else {
      _json[r'isOn'] = null;
    }
    return _json;
  }

  /// Returns a new [Subscription] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Subscription? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Subscription[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Subscription[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Subscription(
        key: SubscriptionType.fromJson(json[r'key']),
        isOn: mapValueOfType<bool>(json, r'isOn'),
      );
    }
    return null;
  }

  static List<Subscription>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Subscription>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Subscription.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Subscription> mapFromJson(dynamic json) {
    final map = <String, Subscription>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Subscription.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Subscription-objects as value to a dart map
  static Map<String, List<Subscription>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Subscription>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Subscription.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

