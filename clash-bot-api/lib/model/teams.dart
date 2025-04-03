//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Teams {
  /// Returns a new [Teams] instance.
  Teams({
    this.count,
    this.teams = const [],
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? count;

  List<Team> teams;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Teams &&
    other.count == count &&
    _deepEquality.equals(other.teams, teams);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (count == null ? 0 : count!.hashCode) +
    (teams.hashCode);

  @override
  String toString() => 'Teams[count=$count, teams=$teams]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.count != null) {
      json[r'count'] = this.count;
    } else {
      json[r'count'] = null;
    }
      json[r'teams'] = this.teams;
    return json;
  }

  /// Returns a new [Teams] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Teams? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Teams[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Teams[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Teams(
        count: mapValueOfType<int>(json, r'count'),
        teams: Team.listFromJson(json[r'teams']),
      );
    }
    return null;
  }

  static List<Teams> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Teams>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Teams.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Teams> mapFromJson(dynamic json) {
    final map = <String, Teams>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Teams.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Teams-objects as value to a dart map
  static Map<String, List<Teams>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Teams>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Teams.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

