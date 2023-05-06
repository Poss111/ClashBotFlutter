//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.12

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CreateUserRequest {
  /// Returns a new [CreateUserRequest] instance.
  CreateUserRequest({
    required this.discordId,
    required this.name,
    required this.serverId,
    this.selectedGuilds = const [],
  });

  /// The Discord id of the player
  String discordId;

  /// The Clash Bot User's name
  String name;

  /// The Discord Server that the player is using by default.
  String serverId;

  /// The list of available Discord Servers for the player to filter by.
  List<String> selectedGuilds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CreateUserRequest &&
     other.discordId == discordId &&
     other.name == name &&
     other.serverId == serverId &&
     other.selectedGuilds == selectedGuilds;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (discordId.hashCode) +
    (name.hashCode) +
    (serverId.hashCode) +
    (selectedGuilds.hashCode);

  @override
  String toString() => 'CreateUserRequest[discordId=$discordId, name=$name, serverId=$serverId, selectedGuilds=$selectedGuilds]';

  Map<String, dynamic> toJson() {
    final _json = <String, dynamic>{};
      _json[r'discordId'] = discordId;
      _json[r'name'] = name;
      _json[r'serverId'] = serverId;
      _json[r'selectedGuilds'] = selectedGuilds;
    return _json;
  }

  /// Returns a new [CreateUserRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CreateUserRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "CreateUserRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "CreateUserRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return CreateUserRequest(
        discordId: mapValueOfType<String>(json, r'discordId')!,
        name: mapValueOfType<String>(json, r'name')!,
        serverId: mapValueOfType<String>(json, r'serverId')!,
        selectedGuilds: json[r'selectedGuilds'] is List
            ? (json[r'selectedGuilds'] as List).cast<String>()
            : const [],
      );
    }
    return null;
  }

  static List<CreateUserRequest>? listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CreateUserRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CreateUserRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CreateUserRequest> mapFromJson(dynamic json) {
    final map = <String, CreateUserRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateUserRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CreateUserRequest-objects as value to a dart map
  static Map<String, List<CreateUserRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CreateUserRequest>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CreateUserRequest.listFromJson(entry.value, growable: growable,);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'discordId',
    'name',
    'serverId',
  };
}

