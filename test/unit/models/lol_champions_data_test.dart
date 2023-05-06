import 'dart:convert';
import 'dart:io';

import 'package:clashbot_flutter/models/lol_champion.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test parsing of LoLChampionsData payload', () async {
    var input = await File("${Directory.current.path}/test/unit/example-payloads/riot/lol-champions-payload.json").readAsString();
    var loLChampionsData = LoLChampionsData.fromJson(jsonDecode(input));
    expect(loLChampionsData.data?.length, 5);
    expect(loLChampionsData.data?['Aatrox']?.imageUrl, "http://ddragon.leagueoflegends.com/cdn/13.7.1/img/champion/Aatrox.png");
  });

}