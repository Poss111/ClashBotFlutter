import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/calendar_widget.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/events_widget.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/server_chip_list.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Event {
  final DateTime date;
  final String title;
  final String description;
  final String image;
  final List<CalendarTeam> teams;

  Event({
    required this.date,
    required this.title,
    required this.description,
    required this.image,
    required this.teams,
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
  final String startDate;
  final String startTime;
  final String endTime;
  final String description;
  final String registrationOpenDateTime;
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
  final int serverId;
  final List<EventWTeams> events;
  final List<DiscordGuild> servers;

  HomeV2({required this.serverId, required this.events, required this.servers});

  @override
  _HomeV2State createState() => _HomeV2State();
}

class _HomeV2State extends State<HomeV2> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late List<String> _selectedServers;
  late List<DiscordGuildWColor> serversWColors;

  @override
  void initState() {
    super.initState();
    // Initially have all servers selected
    _selectedServers = widget.servers.map((server) => server.id).toList();
    // Initialize a list of servers with random colors
    serversWColors = widget.servers
        .map((server) => DiscordGuildWColor(
              id: server.id,
              name: server.name ?? 'Unknown',
              icon: server.icon,
              owner: server.owner,
              // Generate a random color based on the server id
              color: Color(int.parse(server.id.substring(0, 6), radix: 16)),
            ))
        .toList();
  }

  List<EventWTeams> get _upcomingEvents => widget.events
      .map((event) {
        var filteredTeams = event.teams
            .where((team) => _selectedServers.contains(team.serverId))
            .toList();
        return EventWTeams(
          title: event.title,
          startDate: event.startDate,
          startTime: event.startTime,
          endTime: event.endTime,
          description: event.description,
          registrationOpenDateTime: event.registrationOpenDateTime,
          teams: filteredTeams,
        );
      })
      .where((event) => event.teams.isNotEmpty)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clash Tournaments'),
      ),
      body: Column(
        children: [
          ServerChipList(
            servers: serversWColors,
            selectedServers: _selectedServers,
            onSelectionChanged: (selectedServers) {
              setState(() {
                _selectedServers = selectedServers;
              });
            },
          ),
          CalendarWidget(
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            upcomingEvents: _upcomingEvents.map((event) {
              return Event(
                date: DateTime.parse(event.startDate),
                title: event.title,
                description: event.description,
                image: serversWColors
                    .firstWhere(
                        (server) => server.id == event.teams.first.serverId)
                    .iconURL,
                teams: event.teams,
              );
            }).toList(),
            onDaySelected: (selectedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            onMonthChanged: (newFocusedDay) {
              setState(() {
                _focusedDay = newFocusedDay;
              });
            },
          ),
          Expanded(
            child: EventsListWidget(upcomingEvents: _upcomingEvents),
          ),
        ],
      ),
    );
  }
}
