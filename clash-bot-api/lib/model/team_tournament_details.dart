//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TeamTournamentDetails {
  /// Returns a new [TeamTournamentDetails] instance.
  TeamTournamentDetails({
    this.discordId,
    this.tournamentName,
    this.tournamentDay,
    this.role,
  });

  /// The user's Discord Id.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? discordId;

  /// The Clash Tournament's name.
  Object? tournamentName;

  /// The Clash Tournament's day.
  Object? tournamentDay;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Role? role;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TeamTournamentDetails &&
    other.discordId == discordId &&
    other.tournamentName == tournamentName &&
    other.tournamentDay == tournamentDay &&
    other.role == role;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (discordId == null ? 0 : discordId!.hashCode) +
    (tournamentName == null ? 0 : tournamentName!.hashCode) +
    (tournamentDay == null ? 0 : tournamentDay!.hashCode) +
    (role == null ? 0 : role!.hashCode);

  @override
  String toString() => 'TeamTournamentDetails[discordId=$discordId, tournamentName=$tournamentName, tournamentDay=$tournamentDay, role=$role]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.discordId != null) {
      json[r'discordId'] = this.discordId;
    } else {
      json[r'discordId'] = null;
    }
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
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
    return json;
  }

  /// Returns a new [TeamTournamentDetails] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TeamTournamentDetails? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TeamTournamentDetails[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TeamTournamentDetails[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TeamTournamentDetails(
        discordId: mapValueOfType<String>(json, r'discordId'),
        tournamentName: mapValueOfType<Object>(json, r'tournamentName'),
        tournamentDay: mapValueOfType<Object>(json, r'tournamentDay'),
        role: Role.fromJson(json[r'role']),
      );
    }
    return null;
  }

  static List<TeamTournamentDetails> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TeamTournamentDetails>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TeamTournamentDetails.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TeamTournamentDetails> mapFromJson(dynamic json) {
    final map = <String, TeamTournamentDetails>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeamTournamentDetails.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TeamTournamentDetails-objects as value to a dart map
  static Map<String, List<TeamTournamentDetails>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TeamTournamentDetails>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TeamTournamentDetails.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

