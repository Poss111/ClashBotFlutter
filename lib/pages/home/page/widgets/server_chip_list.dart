import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

class ServerChipList extends StatelessWidget {
  final ApplicationDetailsStore appStore;
  final DiscordDetailsStore discordDetailsStore;
  final ClashStore clashStore;

  const ServerChipList({
    super.key,
    required this.appStore,
    required this.discordDetailsStore,
    required this.clashStore,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Observer(
          builder: (_) {
            return Row(
              children: appStore.preferredServers.map((serverId) {
                bool isSelected = clashStore.selectedServers.contains(serverId);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip.elevated(
                    avatar: CircleAvatar(
                      backgroundImage: discordDetailsStore
                                  .discordGuildMap[serverId]?.iconURL !=
                              null
                          ? NetworkImage(discordDetailsStore
                              .discordGuildMap[serverId]!.iconURL)
                          : null,
                      foregroundColor: isSelected ? Colors.white : Colors.black,
                    ),
                    label: Text(
                        discordDetailsStore.discordGuildMap[serverId]?.name ??
                            'Unknown'),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        clashStore.addSelectedServer(discordDetailsStore
                                    .discordGuildMap[serverId] !=
                                null
                            ? discordDetailsStore.discordGuildMap[serverId]!.id
                            : "");
                      } else {
                        clashStore.removeSelectedServer(discordDetailsStore
                                    .discordGuildMap[serverId] !=
                                null
                            ? discordDetailsStore.discordGuildMap[serverId]!.id
                            : "");
                      }
                    },
                  ),
                );
              }).toList(),
            );
          },
        ),
      ),
    );
  }
}
