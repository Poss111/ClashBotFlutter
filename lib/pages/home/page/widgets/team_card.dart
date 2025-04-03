import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/snackbars/join_team_snackbar.dart';
import 'package:clashbot_flutter/snackbars/remove_team_snackbar.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash_team.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'dart:developer' as developer;

class TeamCard extends StatelessWidget {
  TeamCard({
    super.key,
    required this.team,
  });

  final ClashTeamStore team;
  final Map<Role, String> roleToImage = {
    Role.top: 'images/TopIcon.webp',
    Role.bot: 'images/BotIcon.webp',
    Role.mid: 'images/MidIcon.webp',
    Role.jg: 'images/JGIcon.webp',
    Role.supp: 'images/SuppIcon.webp',
  };

  @override
  Widget build(BuildContext context) {
    ApplicationDetailsStore applicationDetailsStore =
        context.read<ApplicationDetailsStore>();
    DiscordDetailsStore discordDetailsStore =
        context.read<DiscordDetailsStore>();
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Tooltip(
                        child: Text(
                          team.name.length > 20
                              ? '${team.name.substring(0, 20)}...'
                              : team.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        message: 'ID ${team.id}',
                      ),
                    ],
                  ),
                  const IconButton.filledTonal(
                      tooltip: 'Coming soon...',
                      icon: Icon(Icons.fullscreen),
                      onPressed: null)
                ],
              ),
              Observer(
                builder: (_) => Expanded(
                  child: Flex(
                      direction: Axis.vertical,
                      spacing: 4,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: Role.values.map((role) {
                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder:
                              (Widget child, Animation<double> animation) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                          child: RoleChip(
                            key: ValueKey(team.members[role]?.id ?? role),
                            image: roleToImage[role] ?? 'Unknown',
                            role: role,
                            id: team.members[role]?.id,
                            teamId: team.id,
                            isUser: team.members[role]?.id ==
                                applicationDetailsStore.clashBotUser.discordId,
                            onJoinPressed: joinTeam(
                                role,
                                team.members[role]?.id,
                                team.name,
                                team.serverId),
                            onRemovePressed: removeFromTeam(
                                role,
                                team.members[role]?.id,
                                team.name,
                                team.serverId),
                            discordDetailsStore: discordDetailsStore,
                          ),
                        );
                      }).toList()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RoleChip extends StatelessWidget {
  RoleChip(
      {super.key,
      required this.image,
      required this.role,
      this.id,
      required this.teamId,
      required this.isUser,
      required this.onJoinPressed,
      required this.onRemovePressed,
      required this.discordDetailsStore});

  final String image;
  final Role role;
  String? id;
  final String teamId;
  final bool isUser;
  final SnackBar onJoinPressed;
  final SnackBar onRemovePressed;
  final DiscordDetailsStore discordDetailsStore;

  @override
  Widget build(BuildContext context) {
    return id != null
        ? Observer(builder: (_) {
            var name = discordDetailsStore.discordIdToName[id];
            if (name == null || name == 'N/A') {
              discordDetailsStore.pushForName(id!);
              name = id;
            }
            return isUser
                ? UsersFilledButton(
                    role: role,
                    name: name!,
                    teamId: teamId,
                    image: image,
                    onPressed: onRemovePressed)
                : RoleFilledWidget(
                    role: role, name: name!, teamId: teamId, image: image);
          })
        : UnfilledRoleWidget(
            role: role, teamId: teamId, image: image, onPressed: onJoinPressed);
  }
}

class UsersFilledButton extends StatelessWidget {
  const UsersFilledButton(
      {super.key,
      required this.role,
      required this.name,
      required this.teamId,
      required this.image,
      required this.onPressed});

  final Role role;
  final String name;
  final String teamId;
  final String image;
  final SnackBar onPressed;

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(onPressed);
      },
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(
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
                  name,
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
    required this.teamId,
    required this.image,
    required this.onPressed,
  });

  final Role role;
  final String teamId;
  final String image;
  final SnackBar onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72.5,
      child: FilledButton.tonal(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(onPressed);
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
    required this.name,
    required this.teamId,
    required this.image,
  });

  final Role role;
  final String name;
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
                name,
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
