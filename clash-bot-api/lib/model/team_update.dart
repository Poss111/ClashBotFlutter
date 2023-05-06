//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TeamUpdate {
  /// Returns a new [TeamUpdate] instance.
  TeamUpdate({
    required this.teamName,
  });

  /// The name of the team
  String teamName;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TeamUpdate &&
     other.teamName == teamName;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (teamName.hashCode);

  @override
  String toString() => 'TeamUpdate[teamName=$teamName]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'teamName'] = teamName;
    return _json;
  }

  /// Returns a new [TeamUpdate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TeamUpdate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TeamUpdate[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TeamUpdate[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TeamUpdate(
        teamName: mapValueOfType<String>(json, r'teamName')!,
      );
    }
    return null;
  }

  static List<TeamUpdate>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TeamUpdate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TeamUpdate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TeamUpdate> mapFromJson(dynamic json) {
    final map = <String, TeamUpdate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeamUpdate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TeamUpdate-objects as value to a dart map
  static Map<String, List<TeamUpdate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TeamUpdate>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeamUpdate.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'teamName',
  };
}

