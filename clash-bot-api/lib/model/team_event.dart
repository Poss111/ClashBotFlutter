//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TeamEvent {
  /// Returns a new [TeamEvent] instance.
  TeamEvent({
    this.team,
    this.tentative,
    required this.eventType,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Team? team;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Tentative? tentative;

  EventType eventType;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TeamEvent &&
    other.team == team &&
    other.tentative == tentative &&
    other.eventType == eventType;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (team == null ? 0 : team!.hashCode) +
    (tentative == null ? 0 : tentative!.hashCode) +
    (eventType.hashCode);

  @override
  String toString() => 'TeamEvent[team=$team, tentative=$tentative, eventType=$eventType]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.team != null) {
      json[r'team'] = this.team;
    } else {
      json[r'team'] = null;
    }
    if (this.tentative != null) {
      json[r'tentative'] = this.tentative;
    } else {
      json[r'tentative'] = null;
    }
      json[r'eventType'] = this.eventType;
    return json;
  }

  /// Returns a new [TeamEvent] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TeamEvent? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TeamEvent[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TeamEvent[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TeamEvent(
        team: Team.fromJson(json[r'team']),
        tentative: Tentative.fromJson(json[r'tentative']),
        eventType: EventType.fromJson(json[r'eventType'])!,
      );
    }
    return null;
  }

  static List<TeamEvent> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TeamEvent>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TeamEvent.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TeamEvent> mapFromJson(dynamic json) {
    final map = <String, TeamEvent>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeamEvent.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TeamEvent-objects as value to a dart map
  static Map<String, List<TeamEvent>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TeamEvent>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TeamEvent.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'eventType',
  };
}

