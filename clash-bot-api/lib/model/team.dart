//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Team {
  /// Returns a new [Team] instance.
  Team({
    this.id,
    this.name,
    this.playerDetails,
    this.serverId,
    this.tournament,
    this.lastUpdatedAt,
  });

  /// Unique identifier for a Team.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  /// The name of the Team.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TeamPlayerDetails? playerDetails;

  /// The Discord server id that the Team belongs to.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? serverId;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  BaseTournament? tournament;

  /// The timestamp that the object was updated at
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? lastUpdatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Team &&
    other.id == id &&
    other.name == name &&
    other.playerDetails == playerDetails &&
    other.serverId == serverId &&
    other.tournament == tournament &&
    other.lastUpdatedAt == lastUpdatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (playerDetails == null ? 0 : playerDetails!.hashCode) +
    (serverId == null ? 0 : serverId!.hashCode) +
    (tournament == null ? 0 : tournament!.hashCode) +
    (lastUpdatedAt == null ? 0 : lastUpdatedAt!.hashCode);

  @override
  String toString() => 'Team[id=$id, name=$name, playerDetails=$playerDetails, serverId=$serverId, tournament=$tournament, lastUpdatedAt=$lastUpdatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.playerDetails != null) {
      json[r'playerDetails'] = this.playerDetails;
    } else {
      json[r'playerDetails'] = null;
    }
    if (this.serverId != null) {
      json[r'serverId'] = this.serverId;
    } else {
      json[r'serverId'] = null;
    }
    if (this.tournament != null) {
      json[r'tournament'] = this.tournament;
    } else {
      json[r'tournament'] = null;
    }
    if (this.lastUpdatedAt != null) {
      json[r'lastUpdatedAt'] = this.lastUpdatedAt!.toUtc().toIso8601String();
    } else {
      json[r'lastUpdatedAt'] = null;
    }
    return json;
  }

  /// Returns a new [Team] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Team? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Team[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Team[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Team(
        id: mapValueOfType<String>(json, r'id'),
        name: mapValueOfType<String>(json, r'name'),
        playerDetails: TeamPlayerDetails.fromJson(json[r'playerDetails']),
        serverId: mapValueOfType<String>(json, r'serverId'),
        tournament: BaseTournament.fromJson(json[r'tournament']),
        lastUpdatedAt: mapDateTime(json, r'lastUpdatedAt', r''),
      );
    }
    return null;
  }

  static List<Team> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Team>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Team.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Team> mapFromJson(dynamic json) {
    final map = <String, Team>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Team.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Team-objects as value to a dart map
  static Map<String, List<Team>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Team>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Team.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

