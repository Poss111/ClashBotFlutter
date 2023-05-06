//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Tentatives {
  /// Returns a new [Tentatives] instance.
  Tentatives({
    this.count,
    this.queues = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? count;

  List<Tentative> queues;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Tentatives &&
     other.count == count &&
     other.queues == queues;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (count == null ? 0 : count!.hashCode) +
    (queues.hashCode);

  @override
  String toString() => 'Tentatives[count=$count, queues=$queues]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (count != null) {
      _json[r'count'] = count;
    } else {
      _json[r'count'] = null;
    }
      _json[r'queues'] = queues;
    return _json;
  }

  /// Returns a new [Tentatives] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Tentatives? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Tentatives[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Tentatives[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Tentatives(
        count: mapValueOfType<int>(json, r'count'),
        queues: Tentative.listFromJson(json[r'queues']) ?? const [],
      );
    }
    return null;
  }

  static List<Tentatives>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Tentatives>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Tentatives.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Tentatives> mapFromJson(dynamic json) {
    final map = <String, Tentatives>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Tentatives.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Tentatives-objects as value to a dart map
  static Map<String, List<Tentatives>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Tentatives>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Tentatives.listFromJson(entry.value, growable: growable,);
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

