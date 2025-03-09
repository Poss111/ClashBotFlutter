import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

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

class HomeV2 extends StatefulWidget {
  final int serverId;
  final List<Map<String, String>> events;
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

  List<Map<String, String>> get _upcomingEvents => widget.events
      .where((event) => _selectedServers.contains(event['serverId']))
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
            upcomingEvents: _upcomingEvents,
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
            serversWColors: serversWColors,
          ),
          Expanded(
            child: EventsListWidget(upcomingEvents: _upcomingEvents),
          ),
        ],
      ),
    );
  }
}

class ServerChipList extends StatelessWidget {
  final List<DiscordGuildWColor> servers;
  final List<String> selectedServers;
  final ValueChanged<List<String>> onSelectionChanged;

  const ServerChipList({
    required this.servers,
    required this.selectedServers,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List<Widget>.generate(
            servers.length > 5 ? 5 : servers.length,
            (index) {
              bool isSelected = selectedServers.contains(servers[index].id);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: FilterChip(
                  avatar: CircleAvatar(
                    backgroundImage: NetworkImage(servers[index].iconURL),
                    foregroundColor: isSelected ? Colors.white : Colors.black,
                  ),
                  label: Text(servers[index].name ?? 'Unknown'),
                  selected: isSelected,
                  onSelected: (selected) {
                    List<String> newSelectedServers =
                        List.from(selectedServers);
                    if (selected) {
                      newSelectedServers.add(servers[index].id);
                    } else {
                      newSelectedServers.remove(servers[index].id);
                    }
                    onSelectionChanged(newSelectedServers);
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final List<Map<String, String>> upcomingEvents;
  final Function(DateTime) onDaySelected;
  final Function(DateTime) onMonthChanged;
  final List<DiscordGuildWColor> serversWColors;

  const CalendarWidget({
    required this.focusedDay,
    required this.selectedDay,
    required this.upcomingEvents,
    required this.onDaySelected,
    required this.onMonthChanged,
    required this.serversWColors,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  onMonthChanged(
                      DateTime(focusedDay.year, focusedDay.month - 1));
                },
              ),
              Text(
                '${focusedDay.year}-${focusedDay.month.toString().padLeft(2, '0')}',
                style: TextStyle(fontSize: 20.0),
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  onMonthChanged(
                      DateTime(focusedDay.year, focusedDay.month + 1));
                },
              ),
            ],
          ),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              childAspectRatio: 1.5,
            ),
            itemCount: DateTime(focusedDay.year, focusedDay.month + 1, 0).day +
                DateTime(focusedDay.year, focusedDay.month, 1).weekday -
                1,
            itemBuilder: (context, index) {
              if (index <
                  DateTime(focusedDay.year, focusedDay.month, 1).weekday - 1) {
                return Container();
              } else {
                int day = index -
                    DateTime(focusedDay.year, focusedDay.month, 1).weekday +
                    2;
                DateTime currentDay =
                    DateTime(focusedDay.year, focusedDay.month, day);
                List<Map<String, String>> eventsForDay = upcomingEvents
                    .where((event) =>
                        DateTime.parse(event['date']!).day == day &&
                        DateTime.parse(event['date']!).month ==
                            focusedDay.month &&
                        DateTime.parse(event['date']!).year == focusedDay.year)
                    .toList();
                return GestureDetector(
                  onTap: () {
                    onDaySelected(currentDay);
                  },
                  child: Container(
                    margin: EdgeInsets.all(4.0),
                    decoration: BoxDecoration(
                      color: isSameDay(selectedDay, currentDay)
                          ? Colors.blue
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            '$day',
                            style: TextStyle(
                              color: isSameDay(selectedDay, currentDay)
                                  ? Colors.white
                                  : isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                            ),
                          ),
                        ),
                        if (eventsForDay.isNotEmpty)
                          Positioned(
                            right: 4.0,
                            top: 4.0,
                            child: Row(
                              children: eventsForDay.map((event) {
                                String serverId = event['serverId']!;
                                DiscordGuildWColor server =
                                    serversWColors.firstWhere(
                                        (server) => server.id == serverId);
                                return Padding(
                                  padding: const EdgeInsets.only(left: 2.0),
                                  child: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(server.iconURL),
                                    radius: 8.0,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class EventsListWidget extends StatelessWidget {
  final List<Map<String, String>> upcomingEvents;

  EventsListWidget({required this.upcomingEvents});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: upcomingEvents.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(upcomingEvents[index]['title']!),
          subtitle: Text(upcomingEvents[index]['date']!),
        );
      },
    );
  }
}
