//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TentativeRequired {
  /// Returns a new [TentativeRequired] instance.
  TentativeRequired({
    this.id,
    required this.serverId,
    required this.tournamentDetails,
    this.tentativePlayers = const [],
    this.lastUpdatedAt,
  });

  /// Unique identifier for the Tentative Queue.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? id;

  /// The default Discord Server id for the player to use.
  String serverId;

  BaseTournament tournamentDetails;

  List<TentativePlayer> tentativePlayers;

  /// The timestamp that the object was updated at
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  DateTime? lastUpdatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TentativeRequired &&
    other.id == id &&
    other.serverId == serverId &&
    other.tournamentDetails == tournamentDetails &&
    _deepEquality.equals(other.tentativePlayers, tentativePlayers) &&
    other.lastUpdatedAt == lastUpdatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id == null ? 0 : id!.hashCode) +
    (serverId.hashCode) +
    (tournamentDetails.hashCode) +
    (tentativePlayers.hashCode) +
    (lastUpdatedAt == null ? 0 : lastUpdatedAt!.hashCode);

  @override
  String toString() => 'TentativeRequired[id=$id, serverId=$serverId, tournamentDetails=$tournamentDetails, tentativePlayers=$tentativePlayers, lastUpdatedAt=$lastUpdatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.id != null) {
      json[r'id'] = this.id;
    } else {
      json[r'id'] = null;
    }
      json[r'serverId'] = this.serverId;
      json[r'tournamentDetails'] = this.tournamentDetails;
      json[r'tentativePlayers'] = this.tentativePlayers;
    if (this.lastUpdatedAt != null) {
      json[r'lastUpdatedAt'] = this.lastUpdatedAt!.toUtc().toIso8601String();
    } else {
      json[r'lastUpdatedAt'] = null;
    }
    return json;
  }

  /// Returns a new [TentativeRequired] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TentativeRequired? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "TentativeRequired[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "TentativeRequired[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return TentativeRequired(
        id: mapValueOfType<String>(json, r'id'),
        serverId: mapValueOfType<String>(json, r'serverId')!,
        tournamentDetails: BaseTournament.fromJson(json[r'tournamentDetails'])!,
        tentativePlayers: TentativePlayer.listFromJson(json[r'tentativePlayers']),
        lastUpdatedAt: mapDateTime(json, r'lastUpdatedAt', r''),
      );
    }
    return null;
  }

  static List<TentativeRequired> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TentativeRequired>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TentativeRequired.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TentativeRequired> mapFromJson(dynamic json) {
    final map = <String, TentativeRequired>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TentativeRequired.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TentativeRequired-objects as value to a dart map
  static Map<String, List<TentativeRequired>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TentativeRequired>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TentativeRequired.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'serverId',
    'tournamentDetails',
    'tentativePlayers',
  };
}

