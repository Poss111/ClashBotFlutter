import 'dart:convert';

import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_notification.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_handler.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer' as developer;

import 'package:validators/validators.dart';

class ClashBotEventsService {
  StompClient? stompClient;
  Map<String, StompUnsubscribe?> openConnections = Map.of({});

  ClashBotEventsService();

  void connectClient(Function onConnect, Function onError) {
    if (null == stompClient) {
      stompClient = StompClient(
        config: StompConfig(
          url: 'ws://localhost:8081/ws',
          onConnect: (p0) => onConnect(),
          connectionTimeout: const Duration(seconds: 20),
          beforeConnect: () async {
            await Future.delayed(Duration(milliseconds: 200));
          },
          onWebSocketError: (error) => onError(error),
        ),
      );
      stompClient?.activate();
    }
  }

  void setupSubscription(String loggedInUserId, String serverId,
      Function notifyUser, DiscordDetailsStore detailsStore) {
    if (null != stompClient && stompClient!.connected) {
      openConnections.putIfAbsent(
          serverId,
          () => stompClient?.subscribe(
              destination: '/topic/server/$serverId',
              callback: (frame) {
                Event? result = Event.fromJson(json.decode(frame.body!));
                var discordId = result?.causedBy ?? '';
                var username = detailsStore.discordIdToName[discordId];
                if (isNull(username)) {
                  detailsStore.fetchUserDetails(result?.causedBy ?? '');
                  username = detailsStore.discordIdToName[discordId];
                }
                switch (result!.teamEvent.eventType) {
                  case EventType.CREATED:
                    String message = '';
                    if (null != result.teamEvent.team) {
                      // clashPlayerStore.updateClashTeam(
                      //     ClashTeam.teamToClashTeam(result.teamEvent.team)!);
                      message =
                          'Team ${result.teamEvent.team?.name} has been created.';
                    } else if (null != result.teamEvent.tentative) {
                      // clashPlayerStore.updateTentativeQueue(
                      //     TentativeQueue.tentativeToTentativeQueue(
                      //         result.teamEvent.tentative)!);
                      message = 'Tentative Queue has been created!';
                    } else {
                      throw Error(message: "Failed to handle create event.");
                    }
                    notifyUser(ClashNotification(
                        const Uuid().v1(),
                        false,
                        message,
                        username ?? '',
                        result.serverId,
                        DateTime.now()));
                    break;
                  case EventType.UPDATED:
                    developer
                        .log("Update ${result.teamEvent.eventType} triggered.");
                    String message = '';
                    if (null != result.teamEvent.team) {
                      // clashPlayerStore.updateClashTeam(
                      //     ClashTeam.teamToClashTeam(result.teamEvent.team)!);
                      message =
                          'Team has been updated to ${result.teamEvent.team?.name}.';
                    } else if (null != result.teamEvent.tentative) {
                      // clashPlayerStore.updateTentativeQueue(
                      //     TentativeQueue.tentativeToTentativeQueue(
                      //         result.teamEvent.tentative)!);
                      message = 'Tentative Queue has been updated or created!';
                    } else {
                      throw Error(message: "Failed to handle update event.");
                    }
                    notifyUser(ClashNotification(
                        const Uuid().v1(),
                        false,
                        message,
                        username ?? '',
                        result.serverId,
                        DateTime.now()));
                    break;
                  case EventType.JOINED:
                    String message = '';
                    if (null != result.teamEvent.team) {
                      // clashPlayerStore.updateClashTeam(
                      //     ClashTeam.teamToClashTeam(result.teamEvent.team)!);
                      message =
                          '$username joined Team ${result.teamEvent.team?.name}.';
                    } else if (null != result.teamEvent.tentative) {
                      // clashPlayerStore.updateTentativeQueue(
                      //     TentativeQueue.tentativeToTentativeQueue(
                      //         result.teamEvent.tentative)!);
                      message =
                          '$username joined Tentative Queue ${result.teamEvent.tentative?.tournamentDetails?.tournamentName} ${result.teamEvent.tentative?.tournamentDetails?.tournamentDay}.';
                    } else {
                      throw Error(message: "Failed to handle joined event.");
                    }
                    notifyUser(ClashNotification(
                        const Uuid().v1(),
                        false,
                        message,
                        username ?? '',
                        result.serverId,
                        DateTime.now()));
                    break;
                  case EventType.REMOVED:
                    String message = '';
                    if (null != result.teamEvent.team) {
                      // clashPlayerStore.updateClashTeam(
                      //     ClashTeam.teamToClashTeam(result.teamEvent.team)!);
                      message =
                          '$username left Team ${result.teamEvent.team?.name}.';
                    } else if (null != result.teamEvent.tentative) {
                      // clashPlayerStore.updateTentativeQueue(
                      //     TentativeQueue.tentativeToTentativeQueue(
                      //         result.teamEvent.tentative)!);
                      message =
                          '$username left Tentative Queue ${result.teamEvent.tentative?.tournamentDetails?.tournamentName} ${result.teamEvent.tentative?.tournamentDetails?.tournamentDay}.';
                    } else {
                      throw Error(message: "Failed to handle removed event.");
                    }
                    notifyUser(ClashNotification(
                        const Uuid().v1(),
                        false,
                        message,
                        username ?? '',
                        result.serverId,
                        DateTime.now()));
                    break;
                  case EventType.DELETED:
                    String message = '';
                    if (null != result.teamEvent.team) {
                      // clashPlayerStore.removeClashTeams(
                      //     ClashTeam.teamToClashTeam(result.teamEvent.team)!);
                      message =
                          'Team ${result.teamEvent.team?.name} has been deleted!';
                    } else if (null != result.teamEvent.tentative) {
                      // clashPlayerStore.removeTentativeQueue(
                      //     TentativeQueue.tentativeToTentativeQueue(
                      //         result.teamEvent.tentative)!);
                      message = 'Tentative Queue has been deleted.';
                    } else {
                      throw Error(message: "Failed to handle delete event.");
                    }
                    notifyUser(ClashNotification(
                        const Uuid().v1(),
                        false,
                        message,
                        username ?? '',
                        result.serverId,
                        DateTime.now()));
                    break;
                  default:
                    throw Error(message: "Unknown event type occurred.");
                }
              }));
    }
  }

  void removeSubscription(String serverId) {
    var unsubscribe = openConnections[serverId];
    if (null != unsubscribe) {
      unsubscribe(unsubscribeHeaders: {});
      openConnections.remove(serverId);
    }
  }
}
