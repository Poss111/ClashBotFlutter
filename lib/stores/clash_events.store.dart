import 'dart:convert';

import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_bot_event.dart';
import 'package:clashbot_flutter/models/clash_event.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/notification.dart';
import 'package:clashbot_flutter/models/websocket_state.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/notification_handler.store.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:mobx/mobx.dart';

part 'clash_events.store.g.dart';

class ClashEventsStore = _ClashEventsStore with _$ClashEventsStore;

abstract class _ClashEventsStore with Store {
  late WebSocketChannel channel;
  final ClashStore _clashStore;
  final NotificationHandlerStore _errorHandlerStore;

  _ClashEventsStore(this._clashStore, this._errorHandlerStore) {
    reaction((_) => status, (_) {
      switch (status) {
        case WebSocketState.connecting:
          _errorHandlerStore.setNotification(
              Notification.info("Connecting to Clash events..."));
          break;
        case WebSocketState.open:
          _errorHandlerStore
              .setNotification(Notification.info("Connected to Clash events"));
          break;
        case WebSocketState.closed:
          _errorHandlerStore.setNotification(
              Notification.error("Disconnected from Clash events"));
          break;
        case WebSocketState.error:
          _errorHandlerStore.setNotification(
              Notification.error("Error connecting to Clash events"));
          break;
        default:
          _errorHandlerStore.setNotification(Notification.error(
              "Unkown state connecting to Clash events: $status"));
          break;
      }
    });
  }

  @observable
  WebSocketState status = WebSocketState.closed;

  @observable
  DateTime lastMessageReceived = DateTime.now();

  @observable
  List<String> events = [];

  @observable
  ObservableList<ClashTeam> teams = ObservableList<ClashTeam>();

  @action
  void subscribeToServers(List<String> servers) {
    if (servers.isEmpty) {
      return;
    }
    channel.sink.add('{"serverIds": ${servers.map((id) => '"$id"').toList()}}');
  }

  @action
  void connect(String url) {
    channel = WebSocketChannel.connect(Uri.parse(url));
    status = WebSocketState.connecting;

    channel.stream.listen(
        (data) {
          lastMessageReceived = DateTime.now();
          var event = jsonDecode(data);
          if (event['eventType'] == null) {
            return;
          } else {
            var clashEvent = ClashBotEvent.values
                .firstWhere((e) => e.toString() == event['eventType']);
            events.add(event['eventType'].toString());
            handleMessage(clashEvent, data);
          }
        },
        onDone: () => status = WebSocketState.closed,
        onError: (error) {
          status = WebSocketState.error;
          _errorHandlerStore.setNotification(
              Notification.error("Real-time events error: $error"));
        });

    status = WebSocketState.open;
  }

  @action
  void handleMessage(ClashBotEvent event, String data) {
    var clashEvent;
    try {
      clashEvent = ClashEvent.fromJsonString(data);
    } catch (e) {
      _errorHandlerStore.setNotification(
          Notification.error("Error receiving event error: $e"));
      return;
    }
    var payload;
    if (event == ClashBotEvent.TEAM_CREATE ||
        event == ClashBotEvent.TEAM_UPDATE) {
      try {
        handleTeamEvent(ClashTeamEvent.fromJsonString(data));
      } catch (e) {
        _errorHandlerStore.setNotification(
            Notification.error("Error handling team update: $e"));
        return;
      }
    } else if (event == ClashBotEvent.TEAM_JOINED) {
      ClashTeamJoinedEvent clashTeamJoinedEvent =
          ClashTeamJoinedEvent.fromJsonString(data);
      // Find filled role
      Role? role;
      PlayerEvent? filledRole;
      if (clashTeamJoinedEvent.payload.playerDetails.bot != null) {
        filledRole = clashTeamJoinedEvent.payload.playerDetails.bot;
        role = Role.bot;
      } else if (clashTeamJoinedEvent.payload.playerDetails.mid != null) {
        filledRole = clashTeamJoinedEvent.payload.playerDetails.mid;
        role = Role.mid;
      } else if (clashTeamJoinedEvent.payload.playerDetails.top != null) {
        filledRole = clashTeamJoinedEvent.payload.playerDetails.top;
        role = Role.top;
      } else if (clashTeamJoinedEvent.payload.playerDetails.jg != null) {
        filledRole = clashTeamJoinedEvent.payload.playerDetails.jg;
        role = Role.jg;
      } else if (clashTeamJoinedEvent.payload.playerDetails.supp != null) {
        filledRole = clashTeamJoinedEvent.payload.playerDetails.supp;
        role = Role.supp;
      }
      _clashStore.addTeamMember(
          clashTeamJoinedEvent.payload.teamId, role!, filledRole!.discordId);
    } else if (event == ClashBotEvent.TEAM_REMOVED) {
      ClashTeamRemovalEvent clashTeamRemovalEvent =
          ClashTeamRemovalEvent.fromJsonString(data);
      _clashStore.removeTeamMember(clashTeamRemovalEvent.payload.teamId,
          clashTeamRemovalEvent.payload.discordId);
    } else {
      try {
        handleTentativeEvent(ClashTentativeEvent.fromJsonString(data));
      } catch (e) {
        _errorHandlerStore.setNotification(
            Notification.error("Error handling tenantive update: $e"));
        print("Error handling tenantive update: $e");
        return;
      }
    }
  }

  @action
  void handleTeamEvent(ClashTeamEvent event) {
    switch (event.eventType) {
      case ClashBotEvent.TEAM_CREATE:
        _clashStore.addTeam(ClashTeam.fromTeamEvent(event.payload));
        break;
      case ClashBotEvent.TEAM_UPDATE:
        _clashStore.updateTeam(ClashTeam.fromTeamEvent(event.payload));
        break;
      default:
        _errorHandlerStore.setNotification(
            Notification.error("Unknown event occurred ${event.eventType}"));
        break;
    }
  }

  @action
  void handleTentativeEvent(ClashTentativeEvent event) {
    // Handle tentative events here
    // For example, you can update the teams list or perform other actions
    if (event.eventType == ClashBotEvent.TENTATIVE_QUEUE_CREATE) {
      // Handle tentative queue creation
    } else if (event.eventType == ClashBotEvent.TENTATIVE_QUEUE_UPDATE) {
      // Handle tentative queue update
    } else if (event.eventType == ClashBotEvent.TENTATIVE_QUEUE_REMOVED) {
      // Handle tentative queue removal
    }
  }

  @action
  void disconnect() {
    channel.sink.close();
    status = WebSocketState.closed;
  }
}
