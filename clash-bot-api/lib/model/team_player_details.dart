//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TeamPlayerDetails {
  /// Returns a new [TeamPlayerDetails] instance.
  TeamPlayerDetails({
    this.top,
    this.mid,
    this.jg,
    this.bot,
    this.supp,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TeamPlayer? top;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TeamPlayer? mid;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TeamPlayer? jg;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TeamPlayer? bot;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  TeamPlayer? supp;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TeamPlayerDetails &&
     other.top == top &&
     other.mid == mid &&
     other.jg == jg &&
     other.bot == bot &&
     other.supp == supp;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (top == null ? 0 : top!.hashCode) +
    (mid == null ? 0 : mid!.hashCode) +
    (jg == null ? 0 : jg!.hashCode) +
    (bot == null ? 0 : bot!.hashCode) +
    (supp == null ? 0 : supp!.hashCode);

  @override
  String toString() => 'TeamPlayerDetails[top=$top, mid=$mid, jg=$jg, bot=$bot, supp=$supp]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
    if (top != null) {
      _json[r'Top'] = top;
    } else {
      _json[r'Top'] = null;
    }
    if (mid != null) {
      _json[r'Mid'] = mid;
    } else {
      _json[r'Mid'] = null;
    }
    if (jg != null) {
      _json[r'Jg'] = jg;
    } else {
      _json[r'Jg'] = null;
    }
    if (bot != null) {
      _json[r'Bot'] = bot;
    } else {
      _json[r'Bot'] = null;
    }
    if (supp != null) {
      _json[r'Supp'] = supp;
    } else {
      _json[r'Supp'] = null;
    }
    return _json;
  }

  /// Returns a new [TeamPlayerDetails] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TeamPlayerDetails? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TeamPlayerDetails[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TeamPlayerDetails[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TeamPlayerDetails(
        top: TeamPlayer.fromJson(json[r'Top']),
        mid: TeamPlayer.fromJson(json[r'Mid']),
        jg: TeamPlayer.fromJson(json[r'Jg']),
        bot: TeamPlayer.fromJson(json[r'Bot']),
        supp: TeamPlayer.fromJson(json[r'Supp']),
      );
    }
    return null;
  }

  static List<TeamPlayerDetails>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TeamPlayerDetails>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TeamPlayerDetails.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TeamPlayerDetails> mapFromJson(dynamic json) {
    final map = <String, TeamPlayerDetails>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeamPlayerDetails.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TeamPlayerDetails-objects as value to a dart map
  static Map<String, List<TeamPlayerDetails>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TeamPlayerDetails>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeamPlayerDetails.listFromJson(entry.value, growable: growable,);
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

