import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/team_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsListWidget extends StatelessWidget {
  final Map<ClashTournament, List<ClashTeam>> upcomingEvents;

  const EventsListWidget({required this.upcomingEvents});

  @override
  Widget build(BuildContext context) {
    var events = upcomingEvents.entries.toList();
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    return SingleChildScrollView(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventTile(
            event: {
              'title': events[index].key.tournamentName +
                  events[index].key.tournamentDay,
              'date': formatter.format(events[index].key.startTime),
              'startTime': formatter.format(events[index].key.startTime),
              'endTime': formatter.format(events[index].key.startTime),
              'description': "Some description.",
              'registrationOpenDateTime':
                  formatter.format(events[index].key.startTime)
            },
            eventTeams: events[index].value,
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
  final List<ClashTeam> eventTeams;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(
          event['title']!,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        initiallyExpanded: true,
        subtitle: Wrap(
          spacing: 10,
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.calendar_today),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    DateFormat('MMMM dd, yyyy')
                        .format(DateTime.parse(event['date']!)),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.access_time),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    DateFormat('h:mm a Z')
                        .format(DateTime.parse(event['startTime']!)),
                  ),
                ),
                const Text(' - '),
                Text(
                  DateFormat('h:mm a Z')
                      .format(DateTime.parse(event['endTime']!)),
                ),
              ],
            ),
            Row(
              children: [
                const Icon(Icons.app_registration),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(DateFormat('h:mm a Z').format(
                      DateTime.parse(event['registrationOpenDateTime']!))),
                ),
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
