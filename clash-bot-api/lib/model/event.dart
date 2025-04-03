//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Event {
  /// Returns a new [Event] instance.
  Event({
    required this.id,
    required this.teamEvent,
    this.summary,
    required this.serverId,
    required this.causedBy,
  });

  /// The unique identifier for the event.
  String id;

  TeamEvent teamEvent;

  /// A message to describe the event.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? summary;

  /// The Discord server id attached to the event.
  String serverId;

  /// Who the event was caused by.
  String causedBy;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Event &&
    other.id == id &&
    other.teamEvent == teamEvent &&
    other.summary == summary &&
    other.serverId == serverId &&
    other.causedBy == causedBy;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (teamEvent.hashCode) +
    (summary == null ? 0 : summary!.hashCode) +
    (serverId.hashCode) +
    (causedBy.hashCode);

  @override
  String toString() => 'Event[id=$id, teamEvent=$teamEvent, summary=$summary, serverId=$serverId, causedBy=$causedBy]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'teamEvent'] = this.teamEvent;
    if (this.summary != null) {
      json[r'summary'] = this.summary;
    } else {
      json[r'summary'] = null;
    }
      json[r'serverId'] = this.serverId;
      json[r'causedBy'] = this.causedBy;
    return json;
  }

  /// Returns a new [Event] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Event? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Event[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Event[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Event(
        id: mapValueOfType<String>(json, r'id')!,
        teamEvent: TeamEvent.fromJson(json[r'teamEvent'])!,
        summary: mapValueOfType<String>(json, r'summary'),
        serverId: mapValueOfType<String>(json, r'serverId')!,
        causedBy: mapValueOfType<String>(json, r'causedBy')!,
      );
    }
    return null;
  }

  static List<Event> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Event>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Event.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Event> mapFromJson(dynamic json) {
    final map = <String, Event>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Event.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Event-objects as value to a dart map
  static Map<String, List<Event>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Event>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Event.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'teamEvent',
    'serverId',
    'causedBy',
  };
}

