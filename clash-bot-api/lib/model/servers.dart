//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Servers {
  /// Returns a new [Servers] instance.
  Servers({
    this.servers = const [],
  });

  List<Server> servers;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Servers &&
    _deepEquality.equals(other.servers, servers);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (servers.hashCode);

  @override
  String toString() => 'Servers[servers=$servers]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'servers'] = this.servers;
    return json;
  }

  /// Returns a new [Servers] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Servers? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "Servers[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "Servers[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return Servers(
        servers: Server.listFromJson(json[r'servers']),
      );
    }
    return null;
  }

  static List<Servers> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Servers>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Servers.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Servers> mapFromJson(dynamic json) {
    final map = <String, Servers>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Servers.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Servers-objects as value to a dart map
  static Map<String, List<Servers>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Servers>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Servers.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

