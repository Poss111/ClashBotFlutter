import 'package:clashbot_flutter/pages/home/page/widgets/server_chip_list.dart';
import 'package:clashbot_flutter/stores/clash_events.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/notification_handler.store.dart';
import 'package:flutter/widgets.dart';
import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/enums/api_call_state.dart';
import 'package:clashbot_flutter/globals/global_settings.dart';
import 'package:clashbot_flutter/services/discord_service_impl.dart';
import 'package:clashbot_flutter/services/riot_resources_service_impl.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/clashbot_user.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/pages/home/page/home_v2.dart';
import 'package:clashbot_flutter/services/clashbot_service_impl.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:widgetbook_workspace/utils/mock_utils.dart';

@widgetbook.UseCase(name: "Default", type: ServerChipList)
Widget buildServerListWidget(BuildContext context) {
  int numberOfServers = context.knobs.int.slider(
    label: "Number of Servers",
    initialValue: 1,
    max: 5,
    min: 1,
  );
  List<String> servers = buildMockServers(numberOfServers);
  ServerChipListDependencies serverChipListDependencies =
      buildServerChipListDependencies(
        clashState: ApiCallState.success,
        tentativeState: ApiCallState.success,
        subscriptionState: ApiCallState.success,
        servers: servers,
      );
  return Center(
    child: ServerChipList(
      appStore: serverChipListDependencies.appStore,
      discordDetailsStore: serverChipListDependencies.discordDetailsStore,
      clashStore: serverChipListDependencies.clashStore,
    ),
  );
}

class ServerChipListDependencies {
  final ApplicationDetailsStore appStore;
  final DiscordDetailsStore discordDetailsStore;
  final ClashStore clashStore;

  ServerChipListDependencies({
    required this.appStore,
    required this.discordDetailsStore,
    required this.clashStore,
  });
}

ServerChipListDependencies buildServerChipListDependencies({
  required ApiCallState clashState,
  required ApiCallState tentativeState,
  required ApiCallState subscriptionState,
  required List<String> servers,
}) {
  final mockUser = ClashBotUser(
    discordId: '123456789',
    champions: [],
    role: Role.top,
    serverId: servers[0],
    selectedServers: servers,
    preferredServers: servers,
  );

  final errorHandlerStore = NotificationHandlerStore();
  final mockDiscordUser = DiscordUser(
    '123456789',
    'mock_username',
    '123456789',
    "mock_discriminator",
  );

  final mockClashStore = MockClashStore(
    mockUser,
    ObservableList.of([]),
    ObservableList.of([]),
    clashState,
    tentativeState,
    subscriptionState,
    ClashBotServiceImpl(
      UserApi(),
      TeamApi(),
      ChampionsApi(),
      SubscriptionApi(),
      TentativeApi(),
      TournamentApi(),
      errorHandlerStore,
    ),
    errorHandlerStore,
  );

  final mockDiscordDetailsStore = MockDiscordDetailsStore(
    buildMockDiscordGuilds(servers),
    mockDiscordUser,
    DiscordServiceImpl(setupOauth2Helper()),
    errorHandlerStore,
  );

  return ServerChipListDependencies(
    appStore: MockApplicationDetailsStore(
      mockUser,
      servers,
      mockClashStore,
      ClashEventsStore(mockClashStore, errorHandlerStore),
      mockDiscordDetailsStore,
      RiotChampionStore(RiotResourceServiceImpl(), errorHandlerStore),
      errorHandlerStore,
    ),
    clashStore: mockClashStore,
    discordDetailsStore: mockDiscordDetailsStore,
  );
}
