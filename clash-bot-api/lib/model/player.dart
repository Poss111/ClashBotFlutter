//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Player {
  /// Returns a new [Player] instance.
  Player({
    this.discordId,
    this.name,
    this.role,
    this.champions = const [],
    this.subscriptions = const [],
    this.serverId,
    this.selectedServers = const [],
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

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  Role? role;

  /// A list of the Users preferred champions.
  List<Champion> champions;

  List<Subscription> subscriptions;

  /// The Discord Server id that the User is defaulted to.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? serverId;

  /// The list of available Discord Servers for the player to filter by.
  List<String> selectedServers;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Player &&
    other.discordId == discordId &&
    other.name == name &&
    other.role == role &&
    _deepEquality.equals(other.champions, champions) &&
    _deepEquality.equals(other.subscriptions, subscriptions) &&
    other.serverId == serverId &&
    _deepEquality.equals(other.selectedServers, selectedServers);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (discordId == null ? 0 : discordId!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (role == null ? 0 : role!.hashCode) +
    (champions.hashCode) +
    (subscriptions.hashCode) +
    (serverId == null ? 0 : serverId!.hashCode) +
    (selectedServers.hashCode);

  @override
  String toString() => 'Player[discordId=$discordId, name=$name, role=$role, champions=$champions, subscriptions=$subscriptions, serverId=$serverId, selectedServers=$selectedServers]';

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
    if (this.role != null) {
      json[r'role'] = this.role;
    } else {
      json[r'role'] = null;
    }
      json[r'champions'] = this.champions;
      json[r'subscriptions'] = this.subscriptions;
    if (this.serverId != null) {
      json[r'serverId'] = this.serverId;
    } else {
      json[r'serverId'] = null;
    }
      json[r'selectedServers'] = this.selectedServers;
    return json;
  }

  /// Returns a new [Player] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Player? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Player[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Player[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Player(
        discordId: mapValueOfType<String>(json, r'discordId'),
        name: mapValueOfType<String>(json, r'name'),
        role: Role.fromJson(json[r'role']),
        champions: Champion.listFromJson(json[r'champions']),
        subscriptions: Subscription.listFromJson(json[r'subscriptions']),
        serverId: mapValueOfType<String>(json, r'serverId'),
        selectedServers: json[r'selectedServers'] is Iterable
            ? (json[r'selectedServers'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<Player> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Player>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Player.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Player> mapFromJson(dynamic json) {
    final map = <String, Player>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Player.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Player-objects as value to a dart map
  static Map<String, List<Player>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Player>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Player.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

