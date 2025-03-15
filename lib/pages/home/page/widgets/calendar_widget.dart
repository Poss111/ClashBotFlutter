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
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = widget.focusedDay;
    _selectedDay = widget.selectedDay;
  }

  void onMonthChanged(DateTime day) {
    setState(() {
      _focusedDay = day;
    });
  }

  void onDaySelected(DateTime day) {
    setState(() {
      _selectedDay = day;
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    onMonthChanged(
                        DateTime(_focusedDay.year, _focusedDay.month - 1));
                  },
                ),
                Text(
                  DateFormat('MMMM yyyy').format(_focusedDay),
                  style: const TextStyle(fontSize: 20.0),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    onMonthChanged(
                        DateTime(_focusedDay.year, _focusedDay.month + 1));
                  },
                ),
              ],
            ),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1.5,
              ),
              itemCount:
                  DateTime(_focusedDay.year, _focusedDay.month + 1, 0).day +
                      DateTime(_focusedDay.year, _focusedDay.month, 1).weekday -
                      1,
              itemBuilder: (context, index) {
                if (index <
                    DateTime(_focusedDay.year, _focusedDay.month, 1).weekday -
                        1) {
                  return Container();
                } else {
                  int day = index -
                      DateTime(_focusedDay.year, _focusedDay.month, 1).weekday +
                      2;
                  DateTime currentDay =
                      DateTime(_focusedDay.year, _focusedDay.month, day);
                  return Observer(builder: (_) {
                    // Get all events for the selected day
                    List<Event> dayEvents = clashStore.events
                        .where((event) => isSameDay(event.date, currentDay))
                        .toList();
                    return GestureDetector(
                      onTap: () {
                        onDaySelected(currentDay);
                      },
                      child: Container(
                        margin: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                          color: isSameDay(_selectedDay, currentDay)
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
                                  color: isSameDay(_selectedDay, currentDay)
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
                                        padding:
                                            const EdgeInsets.only(left: 2.0),
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
                    );
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
