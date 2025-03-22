import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

class ServerChipList extends StatelessWidget {
  const ServerChipList({super.key});

  @override
  Widget build(BuildContext context) {
    ApplicationDetailsStore appStore = context.read<ApplicationDetailsStore>();
    DiscordDetailsStore discordDetailsStore =
        context.read<DiscordDetailsStore>();
    ClashStore clashStore = context.read<ClashStore>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Observer(
          builder: (_) {
            developer.log("Preferred servers: ${appStore.preferredServers}");
            return Row(
              children: appStore.preferredServers.map((serverId) {
                bool isSelected = clashStore.selectedServers.contains(serverId);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: FilterChip(
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
