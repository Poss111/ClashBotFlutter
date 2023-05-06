import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:validators/validators.dart';

class LoLChampionsData {
  final String? type;
  final String? format;
  final String? version;
  final Map<String, LoLChampion>? data;

  const LoLChampionsData({this.type, this.format, this.version, this.data});

  factory LoLChampionsData.fromJson(Map<String, dynamic> json) {
    return LoLChampionsData(
      type: json['type'] as String?,
      format: json['format'] as String?,
      version: json['version'] as String?,
      data: json['data'] == null ? {} : { for (dynamic champion in json['data'].entries)
        champion.key as String : LoLChampion.fromJson(champion.value) as LoLChampion
      }
    );
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'format': format,
        'version': version,
        'data': data,
      };
}

class LoLChampion {
  final String? version;
  final String? id;
  final String? key;
  final String? name;
  final String? title;
  final String? blurb;
  final Info? info;
  final Image? image;
  final List<dynamic>? tags;
  final String? partype;
  final Stats? stats;

  String get imageUrl => isNull(key) ? "" : 
    "http://ddragon.leagueoflegends.com/cdn/$version/img/champion/$name.png";

  const LoLChampion({
    this.version,
    this.id,
    this.key,
    this.name,
    this.title,
    this.blurb,
    this.info,
    this.image,
    this.tags,
    this.partype,
    this.stats,
  });

  factory LoLChampion.fromJson(Map<String, dynamic> json) => LoLChampion(
        version: json['version'] as String?,
        id: json['id'] as String?,
        key: json['key'] as String?,
        name: json['name'] as String?,
        title: json['title'] as String?,
        blurb: json['blurb'] as String?,
        info: json['info'] == null
            ? null
            : Info.fromJson(json['info'] as Map<String, dynamic>),
        image: json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
        tags: json['tags'] as List<dynamic>?,
        partype: json['partype'] as String?,
        stats: json['stats'] == null
            ? null
            : Stats.fromJson(json['stats'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'version': version,
        'id': id,
        'key': key,
        'name': name,
        'title': title,
        'blurb': blurb,
        'info': info?.toJson(),
        'image': image?.toJson(),
        'tags': tags,
        'partype': partype,
        'stats': stats?.toJson(),
      };
}

class Info {
  final int? attack;
  final int? defense;
  final int? magic;
  final int? difficulty;

  const Info({this.attack, this.defense, this.magic, this.difficulty});

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        attack: json['attack'] as int?,
        defense: json['defense'] as int?,
        magic: json['magic'] as int?,
        difficulty: json['difficulty'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'attack': attack,
        'defense': defense,
        'magic': magic,
        'difficulty': difficulty,
      };
}

class Stats {
  final int? hp;
  final int? hpperlevel;
  final int? mp;
  final double? mpperlevel;
  final int? movespeed;
  final int? armor;
  final double? armorperlevel;
  final int? spellblock;
  final double? spellblockperlevel;
  final int? attackrange;
  final double? hpregen;
  final double? hpregenperlevel;
  final double? mpregen;
  final double? mpregenperlevel;
  final int? crit;
  final int? critperlevel;
  final double? attackdamage;
  final double? attackdamageperlevel;
  final double? attackspeedperlevel;
  final double? attackspeed;

  const Stats({
    this.hp,
    this.hpperlevel,
    this.mp,
    this.mpperlevel,
    this.movespeed,
    this.armor,
    this.armorperlevel,
    this.spellblock,
    this.spellblockperlevel,
    this.attackrange,
    this.hpregen,
    this.hpregenperlevel,
    this.mpregen,
    this.mpregenperlevel,
    this.crit,
    this.critperlevel,
    this.attackdamage,
    this.attackdamageperlevel,
    this.attackspeedperlevel,
    this.attackspeed,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        hp: json['hp'] as int?,
        hpperlevel: json['hpperlevel'] as int?,
        mp: json['mp'] as int?,
        mpperlevel: json['mpperlevel'].toDouble(),
        movespeed: json['movespeed'] as int?,
        armor: json['armor'] as int?,
        armorperlevel: (json['armorperlevel'] as num?)?.toDouble(),
        spellblock: json['spellblock'] as int?,
        spellblockperlevel: (json['spellblockperlevel'] as num?)?.toDouble(),
        attackrange: json['attackrange'] as int?,
        hpregen: json['hpregen'].toDouble(),
        hpregenperlevel: json['hpregenperlevel'].toDouble(),
        mpregen: json['mpregen'].toDouble(),
        mpregenperlevel: json['mpregenperlevel'].toDouble(),
        crit: json['crit'] as int?,
        critperlevel: json['critperlevel'] as int?,
        attackdamage: json['attackdamage'].toDouble(),
        attackdamageperlevel: json['attackdamageperlevel'].toDouble(),
        attackspeedperlevel: (json['attackspeedperlevel'] as num?)?.toDouble(),
        attackspeed: (json['attackspeed'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'hp': hp,
        'hpperlevel': hpperlevel,
        'mp': mp,
        'mpperlevel': mpperlevel,
        'movespeed': movespeed,
        'armor': armor,
        'armorperlevel': armorperlevel,
        'spellblock': spellblock,
        'spellblockperlevel': spellblockperlevel,
        'attackrange': attackrange,
        'hpregen': hpregen,
        'hpregenperlevel': hpregenperlevel,
        'mpregen': mpregen,
        'mpregenperlevel': mpregenperlevel,
        'crit': crit,
        'critperlevel': critperlevel,
        'attackdamage': attackdamage,
        'attackdamageperlevel': attackdamageperlevel,
        'attackspeedperlevel': attackspeedperlevel,
        'attackspeed': attackspeed,
      };
}

class Image {
  final String? full;
  final String? sprite;
  final String? group;
  final int? x;
  final int? y;
  final int? w;
  final int? h;

  const Image({
    this.full,
    this.sprite,
    this.group,
    this.x,
    this.y,
    this.w,
    this.h,
  });

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        full: json['full'] as String?,
        sprite: json['sprite'] as String?,
        group: json['group'] as String?,
        x: json['x'] as int?,
        y: json['y'] as int?,
        w: json['w'] as int?,
        h: json['h'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'full': full,
        'sprite': sprite,
        'group': group,
        'x': x,
        'y': y,
        'w': w,
        'h': h,
      };
}
