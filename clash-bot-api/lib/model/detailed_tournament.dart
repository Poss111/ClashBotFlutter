//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DetailedTournament {
  /// Returns a new [DetailedTournament] instance.
  DetailedTournament({
    this.tournamentName,
    this.tournamentDay,
    this.startTime,
    this.registrationTime,
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

  /// When the Tournament starts.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? startTime;

  /// When you can register for the Tournament.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? registrationTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DetailedTournament &&
     other.tournamentName == tournamentName &&
     other.tournamentDay == tournamentDay &&
     other.startTime == startTime &&
     other.registrationTime == registrationTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (tournamentName == null ? 0 : tournamentName!.hashCode) +
    (tournamentDay == null ? 0 : tournamentDay!.hashCode) +
    (startTime == null ? 0 : startTime!.hashCode) +
    (registrationTime == null ? 0 : registrationTime!.hashCode);

  @override
  String toString() => 'DetailedTournament[tournamentName=$tournamentName, tournamentDay=$tournamentDay, startTime=$startTime, registrationTime=$registrationTime]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (tournamentName != null) {
      _json[r'tournamentName'] = tournamentName;
    } else {
      _json[r'tournamentName'] = null;
    }
    if (tournamentDay != null) {
      _json[r'tournamentDay'] = tournamentDay;
    } else {
      _json[r'tournamentDay'] = null;
    }
    if (startTime != null) {
      _json[r'startTime'] = startTime!.toUtc().toIso8601String();
    } else {
      _json[r'startTime'] = null;
    }
    if (registrationTime != null) {
      _json[r'registrationTime'] = registrationTime!.toUtc().toIso8601String();
    } else {
      _json[r'registrationTime'] = null;
    }
    return _json;
  }

  /// Returns a new [DetailedTournament] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DetailedTournament? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DetailedTournament[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DetailedTournament[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DetailedTournament(
        tournamentName: mapValueOfType<String>(json, r'tournamentName'),
        tournamentDay: mapValueOfType<String>(json, r'tournamentDay'),
        startTime: mapDateTime(json, r'startTime', ''),
        registrationTime: mapDateTime(json, r'registrationTime', ''),
      );
    }
    return null;
  }

  static List<DetailedTournament>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DetailedTournament>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DetailedTournament.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DetailedTournament> mapFromJson(dynamic json) {
    final map = <String, DetailedTournament>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DetailedTournament.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DetailedTournament-objects as value to a dart map
  static Map<String, List<DetailedTournament>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DetailedTournament>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DetailedTournament.listFromJson(entry.value, growable: growable,);
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

