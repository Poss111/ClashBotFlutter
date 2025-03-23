import 'dart:async';
import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/models/tentative_queue.dart';
import 'package:clashbot_flutter/services/clashbot_service.dart';
import 'package:clashbot_flutter/stores/v2-stores/error_handler.store.dart';

class ClashBotServiceImpl implements ClashBotService {
  UserApi userApi;
  TeamApi teamApi;
  ChampionsApi championsApi;
  SubscriptionApi subscriptionApi;
  TentativeApi tentativeApi;
  TournamentApi tournamentApi;
  ErrorHandlerStore errorHandlerStore;

  ClashBotServiceImpl(
      this.userApi,
      this.teamApi,
      this.championsApi,
      this.subscriptionApi,
      this.tentativeApi,
      this.tournamentApi,
      this.errorHandlerStore);

  @override
  Future<ClashBotUser> createPlayer(
      String id, String name, String defaultServerId) {
    CreateUserRequest createUserRequest =
        CreateUserRequest(discordId: id, name: name, serverId: defaultServerId);
    return userApi
        .createUser(id, createUserRequest: createUserRequest)
        .then(playerToClashBotUser)
        .catchError((error) {
      errorHandlerStore.setErrorMessage("Whoops! Failed to create player.");
      return error;
    });
  }

  @override
  Future<List<String>> getChampions(String id) {
    return championsApi
        .retrieveUsersPreferredChampions(id, id)
        .then(fromChampionsToStringList)
        .catchError((error) {
      errorHandlerStore
          .setErrorMessage("Whoops! Failed to retrieve user's champions.");
      return error;
    });
  }

  @override
  Future<ClashBotUser> getPlayer(String id) {
    return userApi
        .getUser(id, discordId: id)
        .then(playerToClashBotUser)
        .catchError((error) {
      errorHandlerStore.setErrorMessage("Whoops! Failed to retrieve user.");
      throw error;
    });
  }

  @override
  Future<Map<String, bool>> getSubscriptions(String id) {
    return userApi.getUser(id, discordId: id).then((response) {
      Map<String, bool> subscriptions = {};
      if (null != response) {
        for (Subscription subs in response.subscriptions) {
          subscriptions[subs.key?.value ?? ''] = subs.isOn ?? false;
        }
      }
      return subscriptions;
    }).catchError((error) {
      errorHandlerStore
          .setErrorMessage("Whoops! Failed to retrieve user's subscriptions.");
      throw error;
    });
    ;
  }

  @override
  Future<List<String>> overwriteChampions(String id, List<String> champions) {
    List<Champion> championsList = [];
    for (String championName in champions) {
      championsList.add(Champion(name: championName));
    }
    return championsApi
        .createListOfPreferredChampionsForUser(id, id,
            champions: Champions(champions: championsList))
        .then(fromChampionsToStringList)
        .catchError((error) {
      errorHandlerStore
          .setErrorMessage("Whoops! Failed to overwrite user's champions.");
      return error;
    });
  }

  @override
  Future<List<String>> removeChampion(String id, String champion) {
    return championsApi
        .removePreferredChampionForUser(id, id, List.of([champion]))
        .then(fromChampionsToStringList)
        .catchError((error) {
      errorHandlerStore
          .setErrorMessage("Whoops! Failed to remove user's champion.");
      return error;
    });
  }

  @override
  Future<List<String>> updateChampions(String id, String champion) {
    List<Champion> championsList = [];
    championsList.add(Champion(name: champion));
    return championsApi
        .addToPreferredChampionsForUser(id, id,
            champions: Champions(champions: championsList))
        .then(fromChampionsToStringList)
        .catchError((error) {
      errorHandlerStore
          .setErrorMessage("Whoops! Failed to update user's champions.");
      return error;
    });
  }

  @override
  Future<List<String>> createSelectedServers(
      String id, List<String> selectedServers) {
    var servers = List<Server>.empty(growable: true);
    for (var server in selectedServers) {
      servers.add(Server(id: server));
    }
    return userApi
        .createUsersSelectedServers(id, id, servers: Servers(servers: servers))
        .then(serversToServerIdList);
  }

  @override
  Future<List<String>> removeSelectedServers(
      String id, List<String> selectedServers) {
    return userApi
        .removeUsersSelectedServers(id, id, selectedServers)
        .then(serversToServerIdList);
  }

  @override
  Future<List<String>> updateSelectedServers(
      String id, List<String> selectedServers) {
    var servers = List<Server>.empty(growable: true);
    for (var server in selectedServers) {
      servers.add(Server(id: server));
    }
    return userApi
        .addUsersSelectedServers(id, id, servers: Servers(servers: servers))
        .then(serversToServerIdList);
  }

  @override
  Future<ClashTeam> addToTeam(String id, Role role, String teamId) {
    return teamApi
        .assignUserToTeam(id, teamId, id, PositionDetails(role: role))
        .then((team) => teamToClashTeam(team ?? Team()));
  }

  @override
  Future<TentativeQueue> addToTentativeQueue(String id, String tentativeId) {
    return tentativeApi
        .assignUserToATentativeQueue(id, tentativeId, id)
        .then(tentativeToTentativeQueue);
  }

  @override
  Future<List<ClashTeam>> getClashTeams(
      String id, List<String> selectedServerIds) {
    List<Future<Teams?>> futures = [];
    for (String serverId in selectedServerIds) {
      futures
          .add(teamApi.retrieveTeams(id, archived: false, serverId: serverId));
    }
    return Future.wait(futures).then((responses) {
      List<ClashTeam> teams = [];
      for (var teamsObject in responses) {
        if (null != teamsObject) {
          var items = teamsObject.teams.map(teamToClashTeamMapper).toList();
          teams.addAll([...items]);
        }
      }
      return teams;
    });
  }

  @override
  Future<List<TentativeQueue>> getTentativeQueues(
      String id, List<String> selectedServerIds) {
    List<Future<Tentatives?>> futures = [];
    for (String serverId in selectedServerIds) {
      futures.add(tentativeApi.retrieveTentativeQueues(id,
          archived: false, serverId: serverId));
    }
    return Future.wait(futures).then((responses) {
      List<TentativeQueue> tentativeQueues = [];
      for (var tentativeQueue in responses) {
        if (null != tentativeQueue) {
          for (var tentative in tentativeQueue.queues) {
            tentativeQueues
                .add(TentativeQueue.tentativeToTentativeQueue(tentative)!);
          }
        }
      }
      return tentativeQueues;
    });
  }

  @override
  Future<ClashTeam> removeFromTeam(String id, String teamId) {
    return teamApi
        .removeUserFromTeam(id, teamId, id)
        .then((team) => teamToClashTeam(team ?? Team()));
  }

  @override
  Future<TentativeQueue> removeFromTentativeQueue(
      String id, String tentativeId) {
    return tentativeApi
        .removeUserFromTentativeQueue(id, tentativeId, id)
        .then(tentativeToTentativeQueue);
  }

  @override
  Future<ClashTeam> createClashTeam(String discordId, String name, Role role,
      String serverId, String tournamentName, String tournamentDay) {
    var playerDetails;
    switch (role) {
      case Role.TOP:
        playerDetails =
            TeamPlayerDetails(top: TeamPlayer(discordId: discordId));
        break;
      case Role.JG:
        playerDetails = TeamPlayerDetails(jg: TeamPlayer(discordId: discordId));
        break;
      case Role.MID:
        playerDetails =
            TeamPlayerDetails(mid: TeamPlayer(discordId: discordId));
        break;
      case Role.BOT:
        playerDetails =
            TeamPlayerDetails(bot: TeamPlayer(discordId: discordId));
        break;
      default:
        playerDetails =
            TeamPlayerDetails(supp: TeamPlayer(discordId: discordId));
    }
    TeamRequired teamRequired = TeamRequired(
        name: name,
        playerDetails: playerDetails,
        serverId: serverId,
        tournament: BaseTournament(
            tournamentName: tournamentName, tournamentDay: tournamentDay));
    return teamApi
        .createTeam(discordId, teamRequired)
        .then((team) => teamToClashTeam(team ?? Team()));
  }

  @override
  Future<TentativeQueue> createTentativeQueue(String discordId, String serverId,
      String tournamentName, String tournamentDay) {
    return tentativeApi
        .createTentativeQueue(discordId,
            tentativeRequired: TentativeRequired(
                serverId: serverId,
                id: discordId,
                tournamentDetails: BaseTournament(
                    tournamentName: tournamentName,
                    tournamentDay: tournamentDay),
                tentativePlayers: [TentativePlayer(discordId: discordId)]))
        .then(tentativeToTentativeQueue);
  }

  @override
  Future<List<ClashTournament>> retrieveTournaments(String id) {
    return tournamentApi
        .getTournaments(id, upcomingOnly: true)
        .then((Tournaments? response) {
      if (null != response) {
        return response.tournaments
            .map((tourney) => ClashTournament(
                tourney.tournamentName ?? '',
                tourney.tournamentDay ?? '',
                tourney.startTime ?? DateTime.now(),
                tourney.registrationTime ?? DateTime.now()))
            .toList();
      }
      return [];
    });
  }

  @override
  Future<Subscription?> subscribe(String id, SubscriptionType type) {
    return subscriptionApi.subscribeUser(id, id, type);
  }

  @override
  Future<Subscription?> unsubscribe(String id, SubscriptionType type) {
    return subscriptionApi.unsubscribeUser(id, id, type);
  }

  ClashBotUser playerToClashBotUser(Player? value) {
    if (null != value) {
      return ClashBotUser(
          discordId: value.discordId,
          role: value.role,
          champions: value.champions,
          subscriptions: value.subscriptions,
          serverId: value.serverId,
          selectedServers: value.selectedServers);
    } else {
      return ClashBotUser();
    }
  }

  FutureOr<List<String>> serversToServerIdList(response) {
    List<String> selectedServerIds = [];
    if (null != response) {
      for (Server server in response.servers) {
        selectedServerIds.add(server.id ?? "0");
      }
    }
    return selectedServerIds;
  }

  FutureOr<List<String>> fromChampionsToStringList(value) {
    List<String> champions = [];
    if (null != value) {
      for (Champion champion in value.champions) {
        champions.add(champion.name ?? '');
      }
    }
    return champions;
  }

  ClashTeam teamToClashTeamMapper(Team team) {
    if (null != team) {
      Map<Role, PlayerDetails> map = {};
      if (null != team.playerDetails) {
        if (null != team.playerDetails!.top) {
          map[Role.TOP] = PlayerDetails(
              team.playerDetails!.top?.discordId ?? '',
              team.playerDetails!.top?.name ?? '',
              team.playerDetails!.top?.champions
                      .map((champ) => champ.name ?? '')
                      .toList() ??
                  List<String>.empty(growable: true));
        }
        if (null != team.playerDetails?.jg) {
          map[Role.JG] = PlayerDetails(
              team.playerDetails!.jg?.discordId ?? '',
              team.playerDetails!.jg?.name ?? '',
              team.playerDetails!.jg?.champions
                      .map((champ) => champ.name ?? '')
                      .toList() ??
                  List<String>.empty(growable: true));
        }
        if (null != team.playerDetails?.mid) {
          map[Role.MID] = PlayerDetails(
              team.playerDetails!.mid?.discordId ?? '',
              team.playerDetails!.mid?.name ?? '',
              team.playerDetails!.mid?.champions
                      .map((champ) => champ.name ?? '')
                      .toList() ??
                  List<String>.empty(growable: true));
        }
        if (null != team.playerDetails?.bot) {
          map[Role.BOT] = PlayerDetails(
              team.playerDetails!.bot?.discordId ?? '',
              team.playerDetails!.bot?.name ?? '',
              team.playerDetails!.bot?.champions
                      .map((champ) => champ.name ?? '')
                      .toList() ??
                  List<String>.empty(growable: true));
        }
        if (null != team.playerDetails?.supp) {
          map[Role.SUPP] = PlayerDetails(
              team.playerDetails!.supp?.discordId ?? '',
              team.playerDetails!.supp?.name ?? '',
              team.playerDetails!.supp?.champions
                      .map((champ) => champ.name ?? '')
                      .toList() ??
                  List<String>.empty(growable: true));
        }
      }
      return ClashTeam(
          team.id ?? '',
          team.name ?? '',
          team.tournament?.tournamentName ?? '',
          team.tournament?.tournamentDay ?? '',
          map,
          team.serverId ?? '',
          team.lastUpdatedAt ?? DateTime.now());
    }
    return ClashTeam("", "", "", "", {}, "", DateTime.now());
  }

  FutureOr<ClashTeam> teamToClashTeam(Team team) {
    if (null != team) {
      Map<Role, PlayerDetails> map = {};
      if (null != team.playerDetails) {
        if (null != team.playerDetails!.top) {
          map[Role.TOP] = PlayerDetails(
              team.playerDetails!.top?.discordId ?? '',
              team.playerDetails!.top?.name ?? '',
              team.playerDetails!.top?.champions
                      .map((champ) => champ.name ?? '')
                      .toList() ??
                  []);
        }
        if (null != team.playerDetails?.jg) {
          map[Role.JG] = PlayerDetails(
              team.playerDetails!.jg?.discordId ?? '',
              team.playerDetails!.jg?.name ?? '',
              team.playerDetails!.jg?.champions
                      .map((champ) => champ.name ?? '')
                      .toList() ??
                  []);
        }
        if (null != team.playerDetails?.mid) {
          map[Role.MID] = PlayerDetails(
              team.playerDetails!.mid?.discordId ?? '',
              team.playerDetails!.mid?.name ?? '',
              team.playerDetails!.mid?.champions
                      .map((champ) => champ.name ?? '')
                      .toList() ??
                  []);
        }
        if (null != team.playerDetails?.bot) {
          map[Role.BOT] = PlayerDetails(
              team.playerDetails!.bot?.discordId ?? '',
              team.playerDetails!.bot?.name ?? '',
              team.playerDetails!.bot?.champions
                      .map((champ) => champ.name ?? '')
                      .toList() ??
                  []);
        }
        if (null != team.playerDetails?.supp) {
          map[Role.SUPP] = PlayerDetails(
              team.playerDetails!.supp?.discordId ?? '',
              team.playerDetails!.supp?.name ?? '',
              team.playerDetails!.supp?.champions
                      .map((champ) => champ.name ?? '')
                      .toList() ??
                  []);
        }
      }
      return ClashTeam(
          team.id ?? '',
          team.name ?? '',
          team.tournament?.tournamentName ?? '',
          team.tournament?.tournamentDay ?? '',
          map,
          team.serverId ?? '',
          team.lastUpdatedAt ?? DateTime.now());
    }
    return ClashTeam("", "", "", "", {}, "", DateTime.now());
  }

  FutureOr<TentativeQueue> tentativeToTentativeQueue(response) {
    return TentativeQueue.tentativeToTentativeQueue(response)!;
  }
}
