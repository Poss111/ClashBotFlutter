//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Champions {
  /// Returns a new [Champions] instance.
  Champions({
    this.champions = const [],
  });

  List<Champion> champions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Champions &&
     other.champions == champions;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (champions.hashCode);

  @override
  String toString() => 'Champions[champions=$champions]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'champions'] = champions;
    return _json;
  }

  /// Returns a new [Champions] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Champions? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Champions[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Champions[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Champions(
        champions: Champion.listFromJson(json[r'champions']) ?? const [],
      );
    }
    return null;
  }

  static List<Champions>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Champions>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Champions.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Champions> mapFromJson(dynamic json) {
    final map = <String, Champions>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Champions.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Champions-objects as value to a dart map
  static Map<String, List<Champions>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Champions>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Champions.listFromJson(entry.value, growable: growable,);
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

