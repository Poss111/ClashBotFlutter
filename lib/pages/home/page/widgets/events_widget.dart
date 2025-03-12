import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/pages/home/page/home_v2.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/team_card.dart';
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
                Text(DateFormat('hh:mm a Z').format(
                    DateTime.parse(event['registrationOpenDateTime']!))),
              ],
            )
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.center,
              children: eventTeams.map((team) {
                return TeamCard(team: team);
              }).toList(),
            ),
          )
        ]);
  }
}
