//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ArchiveMetadata {
  /// Returns a new [ArchiveMetadata] instance.
  ArchiveMetadata({
    this.teamsMoved,
    this.tentativeQueuesMoved,
    this.totalTime,
  });

  /// The number of Teams moved into the archive table.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? teamsMoved;

  /// The number of Tentative Queues moved into the archive table.
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? tentativeQueuesMoved;

  /// The total time the process took in milliseconds
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? totalTime;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ArchiveMetadata &&
    other.teamsMoved == teamsMoved &&
    other.tentativeQueuesMoved == tentativeQueuesMoved &&
    other.totalTime == totalTime;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (teamsMoved == null ? 0 : teamsMoved!.hashCode) +
    (tentativeQueuesMoved == null ? 0 : tentativeQueuesMoved!.hashCode) +
    (totalTime == null ? 0 : totalTime!.hashCode);

  @override
  String toString() => 'ArchiveMetadata[teamsMoved=$teamsMoved, tentativeQueuesMoved=$tentativeQueuesMoved, totalTime=$totalTime]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.teamsMoved != null) {
      json[r'teamsMoved'] = this.teamsMoved;
    } else {
      json[r'teamsMoved'] = null;
    }
    if (this.tentativeQueuesMoved != null) {
      json[r'tentativeQueuesMoved'] = this.tentativeQueuesMoved;
    } else {
      json[r'tentativeQueuesMoved'] = null;
    }
    if (this.totalTime != null) {
      json[r'totalTime'] = this.totalTime;
    } else {
      json[r'totalTime'] = null;
    }
    return json;
  }

  /// Returns a new [ArchiveMetadata] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ArchiveMetadata? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "ArchiveMetadata[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "ArchiveMetadata[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return ArchiveMetadata(
        teamsMoved: mapValueOfType<int>(json, r'teamsMoved'),
        tentativeQueuesMoved: mapValueOfType<int>(json, r'tentativeQueuesMoved'),
        totalTime: mapValueOfType<String>(json, r'totalTime'),
      );
    }
    return null;
  }

  static List<ArchiveMetadata> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ArchiveMetadata>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ArchiveMetadata.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ArchiveMetadata> mapFromJson(dynamic json) {
    final map = <String, ArchiveMetadata>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ArchiveMetadata.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ArchiveMetadata-objects as value to a dart map
  static Map<String, List<ArchiveMetadata>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ArchiveMetadata>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ArchiveMetadata.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

