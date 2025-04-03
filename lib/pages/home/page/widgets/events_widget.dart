import 'package:clashbot_flutter/enums/api_call_state.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/pages/home/page/widgets/team_card.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash_team.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

class EventsListWidget extends StatelessWidget {
  const EventsListWidget(
      {super.key,
      required this.clashStore,
      required this.applicationDetailsStore,
      required this.discordDetailStore});
  final ClashStore clashStore;
  final ApplicationDetailsStore applicationDetailsStore;
  final DiscordDetailsStore discordDetailStore;

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    return Observer(builder: (_) {
      if (clashStore.teamsApiCallState == ApiCallState.error) {
        return Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: IconButton.filled(
                    onPressed: () {
                      clashStore.refreshClashTeams(
                          clashStore.clashBotUser.discordId!,
                          clashStore.selectedServers);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Retrying to load teams...'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    color: Theme.of(context).colorScheme.error,
                    tooltip: 'Failed to load teams. Click to retry.',
                  ),
                ),
              ),
            ]);
      } else if (clashStore.teamsApiCallState == ApiCallState.loading) {
        return const Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            ]);
      }
      var events =
          clashStore.tournamentsToTeamsFilteredToADayIfActive.entries.toList();
      return Flexible(
        child: SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: clashStore.tournamentsToTeams.entries.length,
            itemBuilder: (context, index) {
              if (clashStore.filterByDay && events[index].value.isEmpty) {
                return const SizedBox.shrink();
              }
              return EventTile(
                event: {
                  'title': events[index].key.tournamentName,
                  'day': events[index].key.tournamentDay,
                  'date':
                      formatter.format(events[index].key.startTime.toLocal()),
                  'startTime':
                      formatter.format(events[index].key.startTime.toLocal()),
                  'endTime':
                      formatter.format(events[index].key.startTime.toLocal()),
                  'description': "Some description.",
                  'registrationOpenDateTime':
                      formatter.format(events[index].key.startTime.toLocal())
                },
                eventTeams: events[index].value,
                applicationDetailsStore: applicationDetailsStore,
                discordDetailStore: discordDetailStore,
              );
            },
          ),
        ),
      );
    });
  }
}

class EventTile extends StatelessWidget {
  const EventTile(
      {super.key,
      required this.event,
      required this.eventTeams,
      required this.applicationDetailsStore,
      required this.discordDetailStore});

  final Map<String, String> event;
  final List<ClashTeamStore> eventTeams;
  final ApplicationDetailsStore applicationDetailsStore;
  final DiscordDetailsStore discordDetailStore;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(
          event['title']!,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        initiallyExpanded: eventTeams.isNotEmpty,
        trailing: Text(
          event['day']!,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
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
                const Icon(Icons.how_to_reg),
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
                return TeamCard(
                    team: team,
                    applicationDetailsStore: applicationDetailsStore,
                    discordDetailsStore: discordDetailStore);
              }).toList(),
            ),
          )
        ]);
  }
}
