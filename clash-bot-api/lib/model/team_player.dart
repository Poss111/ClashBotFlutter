//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TeamPlayer {
  /// Returns a new [TeamPlayer] instance.
  TeamPlayer({
    this.discordId,
    this.champions = const [],
  });

  /// Discord Id for the Player
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? discordId;

  /// A list of the Users preferred champions.
  List<Champion> champions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TeamPlayer &&
    other.discordId == discordId &&
    _deepEquality.equals(other.champions, champions);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (discordId == null ? 0 : discordId!.hashCode) +
    (champions.hashCode);

  @override
  String toString() => 'TeamPlayer[discordId=$discordId, champions=$champions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.discordId != null) {
      json[r'discordId'] = this.discordId;
    } else {
      json[r'discordId'] = null;
    }
      json[r'champions'] = this.champions;
    return json;
  }

  /// Returns a new [TeamPlayer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TeamPlayer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TeamPlayer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TeamPlayer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TeamPlayer(
        discordId: mapValueOfType<String>(json, r'discordId'),
        champions: Champion.listFromJson(json[r'champions']),
      );
    }
    return null;
  }

  static List<TeamPlayer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TeamPlayer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TeamPlayer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TeamPlayer> mapFromJson(dynamic json) {
    final map = <String, TeamPlayer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeamPlayer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TeamPlayer-objects as value to a dart map
  static Map<String, List<TeamPlayer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TeamPlayer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TeamPlayer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

