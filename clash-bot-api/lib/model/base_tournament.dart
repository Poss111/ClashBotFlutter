//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BaseTournament {
  /// Returns a new [BaseTournament] instance.
  BaseTournament({
    this.tournamentName,
    this.tournamentDay,
  });

  /// The name of the Tournament.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tournamentName;

  /// The day number of the Tournament. [1-4]
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? tournamentDay;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BaseTournament &&
    other.tournamentName == tournamentName &&
    other.tournamentDay == tournamentDay;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (tournamentName == null ? 0 : tournamentName!.hashCode) +
    (tournamentDay == null ? 0 : tournamentDay!.hashCode);

  @override
  String toString() => 'BaseTournament[tournamentName=$tournamentName, tournamentDay=$tournamentDay]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.tournamentName != null) {
      json[r'tournamentName'] = this.tournamentName;
    } else {
      json[r'tournamentName'] = null;
    }
    if (this.tournamentDay != null) {
      json[r'tournamentDay'] = this.tournamentDay;
    } else {
      json[r'tournamentDay'] = null;
    }
    return json;
  }

  /// Returns a new [BaseTournament] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BaseTournament? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "BaseTournament[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "BaseTournament[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return BaseTournament(
        tournamentName: mapValueOfType<String>(json, r'tournamentName'),
        tournamentDay: mapValueOfType<String>(json, r'tournamentDay'),
      );
    }
    return null;
  }

  static List<BaseTournament> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BaseTournament>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BaseTournament.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BaseTournament> mapFromJson(dynamic json) {
    final map = <String, BaseTournament>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BaseTournament.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BaseTournament-objects as value to a dart map
  static Map<String, List<BaseTournament>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BaseTournament>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BaseTournament.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

