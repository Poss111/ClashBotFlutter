import 'dart:convert';

import 'package:clashbot_flutter/globals/global_settings.dart';

/*
Example User
{
  "id": "80351110224678912",
  "username": "Nelly",
  "discriminator": "1337",
  "avatar": "8342729096ea3675442027381ff50dfe",
  "verified": true,
  "email": "nelly@discord.com",
  "flags": 64,
  "premium_type": 1,
  "public_flags": 64
}
*/

class DiscordUser {
  late String id;
  late String username;
  late String avatar;
  late String discriminator;

  String get userDiscr => "$username#$discriminator";
  String get avatarURL =>
      "${AppGlobalSettings.CND_DISCORD_AVATAR_URL}$id/$avatar.png";

  DiscordUser(
    this.id,
    this.username,
    this.avatar,
    this.discriminator,
  );

  DiscordUser copyWith(
    String id,
    String username,
    String avatar,
    String discriminator,
    String email,
    bool verified,
  ) {
    return DiscordUser(
      id ?? this.id,
      username ?? this.username,
      avatar ?? this.avatar,
      discriminator ?? this.discriminator,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'avatar': avatar,
      'discriminator': discriminator,
    };
  }

  static DiscordUser fromMap(Map<String, dynamic> map) {
    return DiscordUser(
        map['id'], map['username'], map['avatar'], map['discriminator']);
  }

  String toJson() => json.encode(toMap());

  static DiscordUser fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'DiscordUser(id: $id, username: $username, avatar: $avatar, discriminator: $discriminator)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DiscordUser &&
        o.id == id &&
        o.username == username &&
        o.avatar == avatar &&
        o.discriminator == discriminator;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        avatar.hashCode ^
        discriminator.hashCode;
  }

  DiscordUser copy() {
    return DiscordUser(id, username, avatar, discriminator);
  }
}
