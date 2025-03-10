import 'package:clashbot_flutter/pages/home/page/home_v2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final List<Event> upcomingEvents;
  final Function(DateTime) onDaySelected;
  final Function(DateTime) onMonthChanged;

  const CalendarWidget({
    required this.focusedDay,
    required this.selectedDay,
    required this.upcomingEvents,
    required this.onDaySelected,
    required this.onMonthChanged,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

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
                        DateTime(focusedDay.year, focusedDay.month - 1));
                  },
                ),
                Text(
                  DateFormat('MMMM yyyy').format(focusedDay),
                  style: const TextStyle(fontSize: 20.0),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed: () {
                    onMonthChanged(
                        DateTime(focusedDay.year, focusedDay.month + 1));
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
                  DateTime(focusedDay.year, focusedDay.month + 1, 0).day +
                      DateTime(focusedDay.year, focusedDay.month, 1).weekday -
                      1,
              itemBuilder: (context, index) {
                if (index <
                    DateTime(focusedDay.year, focusedDay.month, 1).weekday -
                        1) {
                  return Container();
                } else {
                  int day = index -
                      DateTime(focusedDay.year, focusedDay.month, 1).weekday +
                      2;
                  DateTime currentDay =
                      DateTime(focusedDay.year, focusedDay.month, day);
                  List<CalendarTeam> eventsForDay = upcomingEvents
                      .where((event) =>
                          event.date.day == day &&
                          event.date.month == focusedDay.month &&
                          event.date.year == focusedDay.year)
                      .map((e) => e.teams)
                      .expand((element) => element)
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
                                children: [
                                  ...eventsForDay.take(5).map((event) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 2.0),
                                      child: CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(event.iconURL),
                                        radius: 8.0,
                                      ),
                                    );
                                  }).toList(),
                                  if (eventsForDay.length > 5)
                                    const Padding(
                                      padding: EdgeInsets.only(left: 2.0),
                                      child: Text('...'),
                                    ),
                                ],
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
      ),
    );
  }
}
