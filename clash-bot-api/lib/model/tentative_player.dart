//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TentativePlayer {
  /// Returns a new [TentativePlayer] instance.
  TentativePlayer({
    this.discordId,
    this.name,
    this.champions = const [],
    this.role,
  });

  /// Discord Id for the Player
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? discordId;

  /// The Players discord name
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  /// A list of the Users preferred champions.
  List<Champion> champions;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Role? role;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TentativePlayer &&
    other.discordId == discordId &&
    other.name == name &&
    _deepEquality.equals(other.champions, champions) &&
    other.role == role;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (discordId == null ? 0 : discordId!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (champions.hashCode) +
    (role == null ? 0 : role!.hashCode);

  @override
  String toString() => 'TentativePlayer[discordId=$discordId, name=$name, champions=$champions, role=$role]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.discordId != null) {
      json[r'discordId'] = this.discordId;
    } else {
      json[r'discordId'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
      json[r'champions'] = this.champions;
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
    return json;
  }

  /// Returns a new [TentativePlayer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TentativePlayer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TentativePlayer[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TentativePlayer[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TentativePlayer(
        discordId: mapValueOfType<String>(json, r'discordId'),
        name: mapValueOfType<String>(json, r'name'),
        champions: Champion.listFromJson(json[r'champions']),
        role: Role.fromJson(json[r'role']),
      );
    }
    return null;
  }

  static List<TentativePlayer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TentativePlayer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TentativePlayer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TentativePlayer> mapFromJson(dynamic json) {
    final map = <String, TentativePlayer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TentativePlayer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TentativePlayer-objects as value to a dart map
  static Map<String, List<TentativePlayer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TentativePlayer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TentativePlayer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

