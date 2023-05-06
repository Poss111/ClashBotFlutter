import 'dart:convert';

import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:validators/validators.dart';

/*
Example Partial Guild
{
  "id": "80351110224678912",
  "name": "1337 Krew",
  "icon": "8342729096ea3675442027381ff50dfe",
  "owner": true,
  "permissions": 36953089
}
*/
class DiscordGuild {
  String id;
  String? name;
  String icon;
  bool owner;

  String get iconURL => isNull(icon) ? "" : 
    "${AppGlobalSettings.CND_DISCORD_ICONS_URL}$id/$icon.png";

  DiscordGuild(
    this.id,
    this.name,
    this.icon,
    this.owner,
  );

  DiscordGuild copyWith(
    String id,
    String name,
    String icon,
    bool owner,
  ) {
    return DiscordGuild(
      id ?? this.id,
      name ?? this.name,
      icon ?? this.icon,
      owner ?? this.owner,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'owner': owner,
    };
  }

  static DiscordGuild fromMap(Map<String, dynamic> map) {
    return DiscordGuild(
      map['id'],
      map['name'] ?? '',
      map['icon'] ?? '',
      map['owner'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  static DiscordGuild fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'DiscordGuild(id: $id, name: $name, icon: $icon, owner: $owner)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DiscordGuild &&
        other.id == id &&
        other.name == name &&
        other.icon == icon &&
        other.owner == owner;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ icon.hashCode ^ owner.hashCode;
  }
}
