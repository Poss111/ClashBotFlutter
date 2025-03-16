import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/snackbars/join_team_snackbar.dart';
import 'package:clashbot_flutter/snackbars/remove_team_snackbar.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class TeamCard extends StatelessWidget {
  TeamCard({
    super.key,
    required this.team,
  });

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
    ApplicationDetailsStore applicationDetailsStore =
        context.read<ApplicationDetailsStore>();
    return Card(
      surfaceTintColor: Theme.of(context).brightness == Brightness.dark
          ? const Color.fromARGB(
              255, 134, 177, 255) // Lighter blue for dark mode
          : const Color.fromARGB(
              255, 38, 0, 255), // Original color for light mode
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 330),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Observer(builder: (_) {
                        return CircleAvatar(
                          backgroundImage: NetworkImage(applicationDetailsStore
                              .discordDetailsStore
                              .discordGuildMap[team.serverId]!
                              .iconURL),
                        );
                      }),
                      SizedBox(width: 5),
                      Expanded(
                        child: Text(
                          team.name.length > 20
                              ? '${team.name.substring(0, 20)}...'
                              : team.name,
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Flex(
                      direction: Axis.vertical,
                      spacing: 4,
                      children: Role.values.map((role) {
                        return RoleChip(
                            image: roleToImage[role] ?? 'Unknown',
                            role: role,
                            player: team.members[role],
                            teamId: team.id);
                      }).toList())
                ],
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
      required this.teamId});

  final String image;
  final Role role;
  final PlayerDetails? player;
  final String teamId;

  @override
  Widget build(BuildContext context) {
    return player != null
        ? RoleFilledWidget(
            role: role, player: player, teamId: teamId, image: image)
        : UnfilledRoleWidget(
            role: role, player: player, teamId: teamId, image: image);
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
                  width: 15,
                  height: 15,
                  child: Image(image: AssetImage(image))),
              // Text(role.toString())
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
    return FilledButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
              removeFromTeam(role, player!.id, player!.name, teamId));
        },
        child: SizedBox(
          width: 150,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(spacing: 5, children: [
              SizedBox(
                  width: 15,
                  height: 15,
                  child: Image(image: AssetImage(image))),
              Text(player?.name ?? 'Unknown')
            ]),
          ),
        ));
  }
}
