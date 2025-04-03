//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Tournaments {
  /// Returns a new [Tournaments] instance.
  Tournaments({
    this.count,
    this.tournaments = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? count;

  List<DetailedTournament> tournaments;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Tournaments &&
    other.count == count &&
    _deepEquality.equals(other.tournaments, tournaments);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (count == null ? 0 : count!.hashCode) +
    (tournaments.hashCode);

  @override
  String toString() => 'Tournaments[count=$count, tournaments=$tournaments]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.count != null) {
      json[r'count'] = this.count;
    } else {
      json[r'count'] = null;
    }
      json[r'tournaments'] = this.tournaments;
    return json;
  }

  /// Returns a new [Tournaments] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Tournaments? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Tournaments[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Tournaments[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Tournaments(
        count: mapValueOfType<int>(json, r'count'),
        tournaments: DetailedTournament.listFromJson(json[r'tournaments']),
      );
    }
    return null;
  }

  static List<Tournaments> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Tournaments>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Tournaments.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Tournaments> mapFromJson(dynamic json) {
    final map = <String, Tournaments>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Tournaments.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Tournaments-objects as value to a dart map
  static Map<String, List<Tournaments>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Tournaments>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Tournaments.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

