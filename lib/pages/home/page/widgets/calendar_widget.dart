import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/pages/home/page/home_v2.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:developer' as developer;

class CalendarWidget extends StatefulWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;

  const CalendarWidget(
      {super.key, required this.focusedDay, required this.selectedDay});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  late DateTime _focusedDay;
  DateTime? _hoveredDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay;
  }

  void onMonthChanged(DateTime day) {
    setState(() {
      _focusedDay = day;
    });
  }

  void onDaySelected(DateTime day, ClashStore clashStore) {
    setState(() {
      if (isSameDay(clashStore.filterDate, day)) {
        clashStore.turnOffDayFilter();
        clashStore.setFilterDate(DateTime.fromMicrosecondsSinceEpoch(0));
      } else {
        clashStore.turnOnDayFilter();
        clashStore.setFilterDate(day);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;
    ApplicationDetailsStore appStore = context.read<ApplicationDetailsStore>();
    ClashStore clashStore = context.read<ClashStore>();
    return SizedBox(
      width: 1000.0,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CalendarHeader(
              focusedDay: _focusedDay,
              onMonthChanged: onMonthChanged,
            ),
            CalendarBody(
              focusedDay: _focusedDay,
              hoveredDay: _hoveredDay,
              isDarkMode: isDarkMode,
              appStore: appStore,
              clashStore: clashStore,
              onDaySelected: onDaySelected,
              onHoveredDayChanged: (day) {
                setState(() {
                  _hoveredDay = day;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final ValueChanged<DateTime> onMonthChanged;

  const CalendarHeader({
    Key? key,
    required this.focusedDay,
    required this.onMonthChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            onMonthChanged(DateTime(focusedDay.year, focusedDay.month - 1));
          },
        ),
        Text(
          DateFormat('MMMM yyyy').format(focusedDay),
          style: const TextStyle(fontSize: 20.0),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward),
          onPressed: () {
            onMonthChanged(DateTime(focusedDay.year, focusedDay.month + 1));
          },
        ),
      ],
    );
  }
}

class CalendarBody extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? hoveredDay;
  final bool isDarkMode;
  final ApplicationDetailsStore appStore;
  final ClashStore clashStore;
  final Function onDaySelected;
  final ValueChanged<DateTime?> onHoveredDayChanged;

  const CalendarBody({
    Key? key,
    required this.focusedDay,
    required this.hoveredDay,
    required this.isDarkMode,
    required this.appStore,
    required this.clashStore,
    required this.onDaySelected,
    required this.onHoveredDayChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: constraints.maxWidth < 500 ? 1.0 : 1.5,
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
              return Observer(builder: (_) {
                List<Event> dayEvents = clashStore.events
                    .where((event) => isSameDay(event.date, currentDay))
                    .toList();
                return MouseRegion(
                  onEnter: (_) {
                    onHoveredDayChanged(currentDay);
                  },
                  onExit: (_) {
                    onHoveredDayChanged(null);
                  },
                  child: GestureDetector(
                    onTap: () {
                      onDaySelected(currentDay, clashStore);
                    },
                    child: Container(
                      margin: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: isSameDay(
                                clashStore.filterByDay
                                    ? clashStore.filterDate
                                    : null,
                                currentDay)
                            ? Colors.blue
                            : hoveredDay == currentDay
                                ? Colors.blue.withOpacity(0.2)
                                : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              '$day',
                              style: TextStyle(
                                color: isSameDay(
                                        clashStore.filterByDay
                                            ? clashStore.filterDate
                                            : null,
                                        currentDay)
                                    ? Colors.white
                                    : isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                              ),
                            ),
                          ),
                          if (dayEvents.isNotEmpty)
                            Positioned(
                              right: 4.0,
                              top: 4.0,
                              child: Row(
                                children: [
                                  ...dayEvents.take(5).map((event) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: Observer(
                                          builder: (_) => CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    appStore
                                                        .discordDetailsStore
                                                        .discordGuildMap[event
                                                            .team.serverId]!
                                                        .iconURL),
                                                radius: 8.0,
                                              )),
                                    );
                                  }).toList(),
                                  if (dayEvents.length > 5)
                                    const Padding(
                                      padding: EdgeInsets.only(left: 2.0),
                                      child: Text('...'),
                                    ),
                                ],
                              ),
                            ),
                          if (clashStore.tournaments.any((tournament) =>
                              isSameDay(tournament.startTime, currentDay)))
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.blue.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              });
            }
          },
        );
      },
    );
  }
}
