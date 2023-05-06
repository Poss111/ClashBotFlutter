import 'dart:collection';

import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/role_map.dart';
import 'package:clashbot_flutter/models/server.dart';
import 'package:clashbot_flutter/pages/shimmer_loading_page.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ShowLoadingPageUntilLoggedIn(child: HomeDashboard());
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Wrap(
          children: const [
            SmartUpcomingTournamentsWidget(),
            DiscordServersWidget(),
          ],
        ),
      ],
    );
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}

class SmartUpcomingTournamentsWidget extends StatefulWidget {
  const SmartUpcomingTournamentsWidget({
    super.key,
  });

  @override
  State<SmartUpcomingTournamentsWidget> createState() =>
      _SmartUpcomingTournamentsWidgetState();
}

class _SmartUpcomingTournamentsWidgetState
    extends State<SmartUpcomingTournamentsWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationDetailsStore>(
        builder: (context, appStore, child) => Observer(builder: (_) {
              var map = {
                for (var tourney in appStore.tournaments)
                  tourney.startTime: List<Event>.of(
                      [Event(tourney.tournamentName, tourney.startTime)])
              };
              return UpcomingTournamentsWidget(events: map);
            }));
  }
}

class DiscordServersWidget extends StatelessWidget {
  const DiscordServersWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationDetailsStore>(
        builder: (context, appStore, child) {
      return Observer(builder: (_) {
        if (appStore.loggedInClashUser.selectedServers.isNotEmpty) {
          List<ClashServer> servers = List.empty(growable: true);
          servers = appStore.loggedInClashUser.selectedServers
              .map((id) => ClashServer(id, "", "", []))
              .toList();
          var discordServerTiles = List.empty(growable: true);
          for (int i = 0; i < servers.length; i++) {
            var discordGuild =
                appStore.discordDetailsStore.discordGuildMap[servers[i].id];
            discordServerTiles.add(DiscordServerTile(
                serverName: discordGuild?.name ?? '',
                availableTeams: appStore.loggedInClashUser.mapOfClashTeamsToServer[servers[i].id] ?? [],
                imageLink: discordGuild?.iconURL ?? ''));
          }
          return Card(
              child: SizedBox(
            width: 400,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Discord Servers', style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 5),
                  Text('Your selected Discord Servers...', style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: 5),
                  ...discordServerTiles
                ],
              ),
            ),
          ));
        } else {
          return const Card(
              child:
                  SizedBox(width: 400, child: Text("No servers avaialble.")));
        }
      });
    });
  }
}

class DiscordServerTile extends StatefulWidget {
  const DiscordServerTile({
    super.key,
    required this.serverName,
    required this.availableTeams,
    required this.imageLink,
  });

  final String serverName;
  final List<ClashTeam> availableTeams;
  final String imageLink;

  @override
  State<DiscordServerTile> createState() => _DiscordServerTileState();
}

class _DiscordServerTileState extends State<DiscordServerTile>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.imageLink),
      ),
      title: Text(widget.serverName),
      subtitle: Row(
        children: [
          Text('Available Teams:', style: Theme.of(context).textTheme.labelSmall),
          const SizedBox(width: 5),
          ScaleTransition(
            scale: CurvedAnimation(
              parent: AnimationController(
                duration: const Duration(seconds: 1),
                vsync: this,
              )..forward(),
              curve: Curves.fastOutSlowIn,
            ),
            child: Text(widget.availableTeams.length.toString()),
          ),
        ],
      ),
      children: widget.availableTeams.map((team) {
        return ListTile(
          title: Text(team.name, style: Theme.of(context).textTheme.titleMedium),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Column(
              children: [
                Text('Available Roles', style: Theme.of(context).textTheme.titleSmall),
                const SizedBox(height: 3),
                Wrap(
                  spacing: 3,
                  runSpacing: 5,
                  children: Role.values.where((role) => !team.members.keys.contains(role)).map((e) => Chip(label: Text(roleToValueMapper[e] ?? ''))).toList()
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class UpcomingTournamentsWidget extends StatefulWidget {
  const UpcomingTournamentsWidget({super.key, required this.events});
  final Map<DateTime, List<Event>> events;

  @override
  State<UpcomingTournamentsWidget> createState() =>
      _UpcomingTournamentsWidgetState();
}

class _UpcomingTournamentsWidgetState extends State<UpcomingTournamentsWidget> {
  late DateTime _focusedDay = DateTime.now();

  late DateTime _selectedDay = DateTime.now();

  late final ValueNotifier<List<Event>> _selectedEvents;

  CalendarFormat _calendarFormat = CalendarFormat.week;

  late LinkedHashMap<DateTime, List<Event>> listOfEvents;

  @override
  void initState() {
    super.initState();
    listOfEvents = LinkedHashMap<DateTime, List<Event>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(widget.events);
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ConstrainedBox(
        constraints:
            const BoxConstraints(maxWidth: 400, maxHeight: 600, minHeight: 300),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Upcoming Tournaments',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TableCalendar(
                firstDay: DateTime.utc(2022, 10, 16),
                lastDay: DateTime.utc(2099, 3, 14),
                focusedDay: DateTime.now(),
                eventLoader: _getEventsForDay,
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _focusedDay = focusedDay;
                      _selectedDay = selectedDay;
                      _selectedEvents.value = _getEventsForDay(selectedDay);
                    });
                  }
                },
                calendarFormat: _calendarFormat,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
              ),
              const SizedBox(height: 8.0),
              Center(
                child: ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.separated(
                        shrinkWrap: true,
                        itemCount: value.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: TournamentEventTile(event: value[index]),
                          );
                        },
                      );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Event> _getEventsForDay(day) {
    return listOfEvents[day] ?? [];
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}

class TournamentEventTile extends StatelessWidget {
  const TournamentEventTile({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.event_available),
      title: Text(
        event.title,
        style: eventStyle,
      ),
      trailing: Text(DateFormat.yMMMd().format(event.date!)),
    );
  }
}

class Event {
  final String title;
  final DateTime? date;

  const Event(this.title, this.date);

  @override
  String toString() {
    return "$title : $date";
  }
}
