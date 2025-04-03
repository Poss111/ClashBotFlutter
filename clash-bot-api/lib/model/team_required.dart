//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TeamRequired {
  /// Returns a new [TeamRequired] instance.
  TeamRequired({
    this.id,
    this.name,
    required this.playerDetails,
    required this.serverId,
    required this.tournament,
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

  TeamPlayerDetails playerDetails;

  /// The Discord server id that the Team belongs to.
  String serverId;

  BaseTournament tournament;

  /// The timestamp that the object was updated at
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? lastUpdatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TeamRequired &&
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
    (playerDetails.hashCode) +
    (serverId.hashCode) +
    (tournament.hashCode) +
    (lastUpdatedAt == null ? 0 : lastUpdatedAt!.hashCode);

  @override
  String toString() => 'TeamRequired[id=$id, name=$name, playerDetails=$playerDetails, serverId=$serverId, tournament=$tournament, lastUpdatedAt=$lastUpdatedAt]';

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
      json[r'playerDetails'] = this.playerDetails;
      json[r'serverId'] = this.serverId;
      json[r'tournament'] = this.tournament;
    if (this.lastUpdatedAt != null) {
      json[r'lastUpdatedAt'] = this.lastUpdatedAt!.toUtc().toIso8601String();
    } else {
      json[r'lastUpdatedAt'] = null;
    }
    return json;
  }

  /// Returns a new [TeamRequired] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TeamRequired? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TeamRequired[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TeamRequired[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TeamRequired(
        id: mapValueOfType<String>(json, r'id'),
        name: mapValueOfType<String>(json, r'name'),
        playerDetails: TeamPlayerDetails.fromJson(json[r'playerDetails'])!,
        serverId: mapValueOfType<String>(json, r'serverId')!,
        tournament: BaseTournament.fromJson(json[r'tournament'])!,
        lastUpdatedAt: mapDateTime(json, r'lastUpdatedAt', r''),
      );
    }
    return null;
  }

  static List<TeamRequired> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TeamRequired>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TeamRequired.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TeamRequired> mapFromJson(dynamic json) {
    final map = <String, TeamRequired>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeamRequired.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TeamRequired-objects as value to a dart map
  static Map<String, List<TeamRequired>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TeamRequired>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TeamRequired.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'playerDetails',
    'serverId',
    'tournament',
  };
}

