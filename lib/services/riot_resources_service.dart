import 'package:clashbot_flutter/models/lol_champion.dart';

abstract class RiotResourcesService {

  Future<String> getLatestApiVersion();

  Future<LoLChampionsData> getChampionDetails();

} 