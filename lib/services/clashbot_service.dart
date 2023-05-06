import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/models/tentative_queue.dart';

abstract class ClashBotService {
  // User Configurations

  Future<ClashBotUser> getPlayer(String id);

  Future<ClashBotUser> createPlayer(String id, String name, String defaultServerId);

  Future<List<String>> createSelectedServers(
      String id, List<String> selectedServers);

  Future<List<String>> updateSelectedServers(
      String id, List<String> selectedServers);

  Future<List<String>> removeSelectedServers(
      String id, List<String> selectedServers);

  Future<List<String>> getChampions(String id);

  Future<List<String>> updateChampions(String id, String champion);

  Future<List<String>> overwriteChampions(String id, List<String> champions);

  Future<List<String>> removeChampion(String id, String champion);

  Future<Map<String, bool>> getSubscriptions(String id);

  Future<Subscription?> unsubscribe(String id, SubscriptionType type);

  Future<Subscription?> subscribe(String id, SubscriptionType type);

  // Teams

  Future<List<ClashTeam>> getClashTeams(String id, List<String> selectedServerIds);

  Future<ClashTeam> createClashTeam(String discordId, String name, Role role,
      String serverId, String tournamentName, String tournamentDay);

  Future<ClashTeam> addToTeam(String id, Role role, String teamId);

  Future<ClashTeam> removeFromTeam(String id, String teamId);

  // Tentative Queues

  Future<List<TentativeQueue>> getTentativeQueues(
      String id,
      List<String> selectedServerIds);

  Future<TentativeQueue> createTentativeQueue(String discordId, String serverId,
      String tournamentName, String tournamentDay);

  Future<TentativeQueue> addToTentativeQueue(String id, String tentativeId);

  Future<TentativeQueue> removeFromTentativeQueue(
      String id, String tentativeId);

  // Tournaments

  Future<List<ClashTournament>> retrieveTournaments(String id);
}
