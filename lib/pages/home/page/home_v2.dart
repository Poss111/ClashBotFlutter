import 'dart:developer' as developer;

import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/pages/errorPages/whoops_page.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/calendar_widget.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/events_widget.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/server_chip_list.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash_team.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/notification_handler.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeEvent {
  final DateTime date;
  final String title;
  final String description;
  final ClashTeamStore team;

  HomeEvent({
    required this.date,
    required this.title,
    required this.description,
    required this.team,
  });
}

class DiscordGuildWColor extends DiscordGuild {
  final Color color;

  DiscordGuildWColor({
    required String id,
    required String name,
    required String icon,
    required bool owner,
    required this.color,
  }) : super(id, name, icon, owner);
}

class EventWTeams {
  final String title;
  final DateTime startDate;
  final DateTime startTime;
  final DateTime endTime;
  final String description;
  final DateTime registrationOpenDateTime;
  final List<CalendarTeam> teams;

  EventWTeams(
      {required this.title,
      required this.startDate,
      required this.startTime,
      required this.endTime,
      required this.description,
      required this.registrationOpenDateTime,
      required this.teams});
}

class CalendarTeam {
  final String teamId;
  final String teamName;
  final String teamDescription;
  final String serverId;
  final DateTime lastUpdated;
  final String iconURL;
  final Map<Role, PlayerDetails> members;

  CalendarTeam(
    this.teamId,
    this.teamName,
    this.teamDescription,
    this.serverId,
    this.lastUpdated,
    this.iconURL,
    this.members,
  );
}

class HomeV2 extends StatefulWidget {
  @override
  _HomeV2State createState() => _HomeV2State();
}

class _HomeV2State extends State<HomeV2> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    ClashStore clashStore = context.read<ClashStore>();
    DiscordDetailsStore discordDetailsStore =
        context.read<DiscordDetailsStore>();
    NotificationHandlerStore errorHandlerStore =
        context.read<NotificationHandlerStore>();
    return Scaffold(
      body: Observer(
        builder: (_) => errorHandlerStore.irreconcilable
            ? const WhoopsPage()
            : LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 500) {
                    return Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: Flex(direction: Axis.vertical, children: [
                            const ServerChipList(),
                            CalendarWidget(
                                focusedDay: _focusedDay,
                                selectedDay: _selectedDay,
                                clashStore: clashStore,
                                discordDetailsStore: discordDetailsStore),
                            Expanded(
                              child: Card.filled(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.blueGrey
                                    : Colors.blueAccent,
                                margin: const EdgeInsets.all(16.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SvgPicture.asset(
                                    'svgs/ClashBot-HomePage.svg',
                                    semanticsLabel: 'Clash Bot Home Page',
                                    width: 100,
                                    height: 600,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        const Flexible(
                          flex: 2,
                          child: EventsListWidget(),
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        ServerChipList(),
                        CalendarWidget(
                            focusedDay: _focusedDay,
                            selectedDay: _selectedDay,
                            clashStore: clashStore,
                            discordDetailsStore: discordDetailsStore),
                        EventsListWidget(),
                      ],
                    );
                  }
                },
              ),
      ),
      floatingActionButton: Observer(
        builder: (_) => clashStore.canCreateTeam
            ? FloatingActionButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: const Text('Creating team coming soon.'),
                  ));
                },
                child: const Icon(Icons.add),
              )
            : Container(),
      ),
    );
  }
}
