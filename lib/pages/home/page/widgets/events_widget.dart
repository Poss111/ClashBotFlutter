import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/pages/home/page/home_v2.dart';
import 'package:clashbot_flutter/snackbars/join_team_snackbar.dart';
import 'package:clashbot_flutter/snackbars/remove_team_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsListWidget extends StatelessWidget {
  final List<EventWTeams> upcomingEvents;

  const EventsListWidget({required this.upcomingEvents});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: upcomingEvents.length,
        itemBuilder: (context, index) {
          return EventTile(
            event: {
              'title': upcomingEvents[index].title,
              'date': upcomingEvents[index].startDate,
              'startTime': upcomingEvents[index].startTime,
              'endTime': upcomingEvents[index].endTime,
              'description': upcomingEvents[index].description,
              'registrationOpenDateTime':
                  upcomingEvents[index].registrationOpenDateTime,
              'serverId': upcomingEvents[index].teams.first.serverId,
            },
            eventTeams: upcomingEvents[index].teams,
          );
        },
      ),
    );
  }
}

class EventTile extends StatelessWidget {
  const EventTile({
    super.key,
    required this.event,
    required this.eventTeams,
  });

  final Map<String, String> event;
  final List<CalendarTeam> eventTeams;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        event['title']!,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      initiallyExpanded: true,
      subtitle: Column(
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_today),
              Text(
                DateFormat('MMMM dd, yyyy')
                    .format(DateTime.parse(event['date']!)),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.access_time),
              Text(
                DateFormat('hh:mm a Z')
                    .format(DateTime.parse(event['startTime']!)),
              ),
              const Text(' - '),
              Text(
                DateFormat('hh:mm a Z')
                    .format(DateTime.parse(event['endTime']!)),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.app_registration),
              Text(DateFormat('hh:mm a Z')
                  .format(DateTime.parse(event['registrationOpenDateTime']!))),
            ],
          )
        ],
      ),
      children: eventTeams.map((team) {
        return TeamTile(team: team);
      }).toList(),
    );
  }
}

class TeamTile extends StatelessWidget {
  TeamTile({
    super.key,
    required this.team,
  });

  final CalendarTeam team;
  final Map<Role, String> roleToImage = {
    Role.TOP: 'images/TopIcon.webp',
    Role.BOT: 'images/BotIcon.webp',
    Role.MID: 'images/MidIcon.webp',
    Role.JG: 'images/JGIcon.webp',
    Role.SUPP: 'images/SuppIcon.webp',
  };

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(team.iconURL),
        ),
        title: Text(
          team.teamName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        subtitle: Row(
            spacing: 4,
            children: Role.values.map((role) {
              return RoleChip(
                  image: roleToImage[role] ?? 'Unkown',
                  role: role,
                  player: team.members[role],
                  teamId: team.teamId);
            }).toList()));
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
    return FilledButton.tonal(
        onPressed: () {
          ScaffoldMessenger.of(context)
              .showSnackBar(joinTeam(role, player!.id, player!.name, teamId));
        },
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(spacing: 5, children: [
            SizedBox(
                width: 15, height: 15, child: Image(image: AssetImage(image))),
            // Text(role.toString())
          ]),
        ));
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
