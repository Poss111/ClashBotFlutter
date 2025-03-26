import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/snackbars/join_team_snackbar.dart';
import 'package:clashbot_flutter/snackbars/remove_team_snackbar.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as developer;

class TeamCard extends StatelessWidget {
  TeamCard({
    super.key,
    required this.team,
    required this.applicationDetailsStore,
    required this.discordDetailsStore,
  });

  final ApplicationDetailsStore applicationDetailsStore;
  final DiscordDetailsStore discordDetailsStore;

  final ClashTeam team;
  final Map<Role, String> roleToImage = {
    Role.TOP: 'images/TopIcon.webp',
    Role.BOT: 'images/BotIcon.webp',
    Role.MID: 'images/MidIcon.webp',
    Role.JG: 'images/JGIcon.webp',
    Role.SUPP: 'images/SuppIcon.webp',
  };

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    return Card(
      surfaceTintColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(
              255, 134, 177, 255) // Lighter blue for dark mode
          : const Color.fromARGB(
              255, 38, 0, 255), // Original color for light mode
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 325, maxWidth: 300),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flex(
            direction: Axis.vertical,
            spacing: 10,
            children: [
              Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Observer(builder: (_) {
                    return CircleAvatar(
                      backgroundImage: discordDetailsStore
                                  .discordGuildMap[team.serverId]?.iconURL !=
                              null
                          ? NetworkImage(discordDetailsStore
                              .discordGuildMap[team.serverId]!.iconURL)
                          : null,
                    );
                  }),
                  Observer(builder: (_) {
                    var formattedDate = DateFormat.yMd().add_jm().format(
                        DateTime.parse(
                            formatter.format(team.lastUpdatedAt.toLocal())));
                    return Column(
                      children: [
                        Text(
                          team.name.length > 20
                              ? '${team.name.substring(0, 20)}...'
                              : team.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          spacing: 5,
                          children: [
                            Icon(Icons.update),
                            Text(formattedDate,
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ],
                    );
                  }),
                  const IconButton.filledTonal(
                      tooltip: 'Coming soon...',
                      icon: Icon(Icons.fullscreen),
                      onPressed: null)
                ],
              ),
              Expanded(
                child: Flex(
                    direction: Axis.vertical,
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: Role.values.map((role) {
                      return RoleChip(
                          image: roleToImage[role] ?? 'Unknown',
                          role: role,
                          player: team.members[role],
                          teamId: team.id,
                          isUser: team.members[role]?.id ==
                              applicationDetailsStore.clashBotUser.discordId);
                    }).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleChip extends StatelessWidget {
  const RoleChip(
      {super.key,
      required this.image,
      required this.role,
      this.player,
      required this.teamId,
      required this.isUser});

  final String image;
  final Role role;
  final PlayerDetails? player;
  final String teamId;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return player != null
        ? (isUser
            ? UsersFilledButton(
                role: role, player: player, teamId: teamId, image: image)
            : RoleFilledWidget(
                role: role, player: player, teamId: teamId, image: image))
        : UnfilledRoleWidget(
            role: role, player: player, teamId: teamId, image: image);
  }
}

class UsersFilledButton extends StatelessWidget {
  const UsersFilledButton({
    super.key,
    required this.role,
    required this.player,
    required this.teamId,
    required this.image,
  });

  final Role role;
  final PlayerDetails? player;
  final String teamId;
  final String image;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
            removeFromTeam(role, player!.id, player!.name, teamId));
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).colorScheme.inversePrimary),
      ),
      child: Flex(
          direction: Axis.horizontal,
          spacing: 5,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 1,
              child: SizedBox(
                  width: 15,
                  height: 15,
                  child: Image(image: AssetImage(image))),
            ),
            Expanded(
              flex: 3,
              child: Center(
                child: Text(
                  player?.name ?? 'Unknown',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Flexible(
                flex: 1,
                child: Container(
                  width: 20,
                ))
          ]),
    );
  }
}

class UnfilledRoleWidget extends StatelessWidget {
  const UnfilledRoleWidget({
    super.key,
    required this.role,
    required this.player,
    required this.teamId,
    required this.image,
  });

  final Role role;
  final PlayerDetails? player;
  final String teamId;
  final String image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72.5,
      child: FilledButton.tonal(
          onPressed: () {
            ScaffoldMessenger.of(context)
                .showSnackBar(joinTeam(role, player!.id, player!.name, teamId));
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(spacing: 5, children: [
              SizedBox(
                  width: 15, height: 15, child: Image(image: AssetImage(image)))
            ]),
          )),
    );
  }
}

class RoleFilledWidget extends StatelessWidget {
  const RoleFilledWidget({
    super.key,
    required this.role,
    required this.player,
    required this.teamId,
    required this.image,
  });

  final Role role;
  final PlayerDetails? player;
  final String teamId;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Flex(
        direction: Axis.horizontal,
        spacing: 5,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
                width: 15, height: 15, child: Image(image: AssetImage(image))),
          ),
          Expanded(
            flex: 3,
            child: Center(
              child: Text(
                player?.name ?? 'Unknown',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
              flex: 1,
              child: Container(
                width: 20,
              ))
        ]);
  }
}
