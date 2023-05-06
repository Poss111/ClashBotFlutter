import 'dart:convert';

import 'package:clashbot_flutter/models/lol_champion.dart';
import 'package:clashbot_flutter/services/riot_resources_service.dart';
import 'package:http/http.dart' as http;

class RiotResourceServiceImpl implements RiotResourcesService {

  final String baseUrl = "https://ddragon.leagueoflegends.com";

  @override
  Future<LoLChampionsData> getChampionDetails() {
    // Defaulting to english
    String language = 'en_US';
    return getLatestApiVersion()
        .then((latestVersion) => http.get(Uri.parse('$baseUrl/cdn/$latestVersion/data/$language/champion.json')))
        .then((response) {
          return LoLChampionsData.fromJson(jsonDecode(response.body));
        });
  }

  @override
  Future<String> getLatestApiVersion() {
    return http.get(Uri.parse('$baseUrl/api/versions.json'))
            .then((response) => (jsonDecode(response.body) as List<dynamic>).cast<String>().first);
  }
}