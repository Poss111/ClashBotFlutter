import 'dart:developer' as developer;

import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/short-lived/selected_server_form.store.dart';
import 'package:clashbot_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class ServerFormWidget extends StatelessWidget {
  const ServerFormWidget({
    super.key,
    required this.availableServers,
    required this.selectedServerFormStore,
  });

  final Map<int, DiscordGuild> availableServers;
  final SelectedServerFormStore selectedServerFormStore;

  @override
  Widget build(BuildContext context) {
    final applicationDetailsStore = context.read<ApplicationDetailsStore>();
    return Observer(
        builder: (_) => ServerFormContent(
              guilds: applicationDetailsStore.discordDetailsStore.discordGuilds,
              guildMap:
                  applicationDetailsStore.discordDetailsStore.discordGuildMap,
              selectedServerFormStore: selectedServerFormStore,
            ));
  }
}

class ServerFormContent extends StatelessWidget {
  const ServerFormContent({
    super.key,
    required this.guilds,
    required this.guildMap,
    required this.selectedServerFormStore,
  });

  final List<DiscordGuild> guilds;
  final Map<String, DiscordGuild> guildMap;
  final SelectedServerFormStore selectedServerFormStore;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text('Getting Started', style: headerStyle),
      const SizedBox(height: 10),
      const Text(
        'Almost there! Select the servers you want to use with Clash Bot.',
      ),
      const SizedBox(height: 10),
      const Text(
        'You can always change this later in the settings.',
        style: TextStyle(fontStyle: FontStyle.italic),
      ),
      const SizedBox(height: 10),
      Wrap(
        spacing: 6.0,
        runSpacing: 4.0,
        children: guilds.map<Widget>((guild) {
          return ServerChoiceChip(
              guild: guild, selectedServerFormStore: selectedServerFormStore);
        }).toList(),
      ),
    ]);
  }
}

class ServerChoiceChip extends StatefulWidget {
  const ServerChoiceChip({
    super.key,
    required this.guild,
    required this.selectedServerFormStore,
  });

  final DiscordGuild guild;
  final SelectedServerFormStore selectedServerFormStore;

  @override
  State<ServerChoiceChip> createState() => _ServerChoiceChipState();
}

class _ServerChoiceChipState extends State<ServerChoiceChip> {
  @override
  Widget build(BuildContext context) {
    ApplicationDetailsStore appStore = context.read<ApplicationDetailsStore>();
    return ChoiceChip(
      avatar: CircleAvatar(
        backgroundImage: NetworkImage(widget.guild.iconURL),
      ),
      // Trim if longer than 20 characters and add ellipsis
      label: widget.guild.name != "" || widget.guild.name != null
          ? Text(
              widget.guild.name!.length > 20
                  ? '${widget.guild.name!.substring(0, 20)}...'
                  : widget.guild.name!,
            )
          : const Text('No Name'),
      selected: widget.selectedServerFormStore.listOfSelectedServers
          .contains(widget.guild.id),
      onSelected: !widget.selectedServerFormStore.maxServersReached
          ? (bool selected) {
              setState(() {
                if (selected &&
                    !widget.selectedServerFormStore.maxServersReached) {
                  widget.selectedServerFormStore.addServer(widget.guild.id);
                  appStore.setPreferredServers(
                      widget.selectedServerFormStore.listOfSelectedServers);
                } else if (!selected &&
                    widget.selectedServerFormStore.listOfSelectedServers
                        .contains(widget.guild.id)) {
                  widget.selectedServerFormStore.removeServer(widget.guild.id);
                  appStore.setPreferredServers(
                      widget.selectedServerFormStore.listOfSelectedServers);
                }
              });
            }
          : null,
    );
  }
}

class ServerFormController extends MaterialStatesController {
  Set<String> listOfSelectedServers = {};

  void setValue(String value) {
    listOfSelectedServers.add(value);
    notifyListeners();
  }

  void removeValue(String value) {
    listOfSelectedServers.remove(value);
    notifyListeners();
  }
}
