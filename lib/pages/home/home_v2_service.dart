import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/pages/home/page/home_v2.dart';
import 'package:flutter/material.dart';

class HomeV2Data extends StatelessWidget {
  const HomeV2Data({super.key});

  @override
  Widget build(BuildContext context) {
    List<DiscordGuild> serverIds = [
      DiscordGuild('460520499680641035', 'Goon Squad',
          '54d8b00023ca26be5c00a15f5ee9fe80', false),
      DiscordGuild('417825368062558219', 'League of Legends',
          'a093a2b1ce7dca7a4107cb4de610b40e', false),
      DiscordGuild('345678901234567890', 'Valorant', '', false),
    ];
    List<EventWTeams> events = [
      EventWTeams(
        title: 'ARAM Tournament',
        startDate: '2025-03-10T00:00:00Z',
        startTime: '2025-03-10T20:59:59Z',
        endTime: '2021-03-10T23:59:59Z',
        description: 'Event 1 Description',
        registrationOpenDateTime: '2021-06-01T00:00:00Z',
        teams: [
          CalendarTeam(
              '1',
              'Goon Squad Alpha',
              'The top team of the Goon Squad server',
              '460520499680641035',
              DateTime.now(),
              DiscordGuild('460520499680641035', 'Goon Squad',
                      '54d8b00023ca26be5c00a15f5ee9fe80', false)
                  .iconURL,
              Map.of({
                Role.TOP: PlayerDetails(
                  '1',
                  'Player One',
                  [],
                ),
                Role.BOT: PlayerDetails(
                  '2',
                  'Player Two',
                  [],
                ),
              })),
          CalendarTeam(
              '2',
              'Goon Squad Bravo',
              'The second team of the Goon Squad server',
              '460520499680641035',
              DateTime.now().subtract(Duration(days: 1)),
              DiscordGuild('460520499680641035', 'Goon Squad',
                      '54d8b00023ca26be5c00a15f5ee9fe80', false)
                  .iconURL,
              Map.of({
                Role.MID: PlayerDetails(
                  '3',
                  'Player Three',
                  [],
                ),
                Role.JG: PlayerDetails(
                  '4',
                  'Player Four',
                  [],
                ),
              })),
          CalendarTeam(
              '3',
              'League Legends Alpha',
              'The top team of the League of Legends server',
              '417825368062558219',
              DateTime.now().subtract(Duration(days: 2)),
              DiscordGuild('417825368062558219', 'League of Legends',
                      'a093a2b1ce7dca7a4107cb4de610b40e', false)
                  .iconURL,
              Map.of({
                Role.TOP: PlayerDetails(
                  '5',
                  'Player Five',
                  [],
                ),
                Role.SUPP: PlayerDetails(
                  '6',
                  'Player Six',
                  [],
                ),
              })),
          CalendarTeam(
              '4',
              'Valorant Alpha',
              'The top team of the Valorant server',
              '345678901234567890',
              DateTime.now().subtract(Duration(days: 3)),
              DiscordGuild('345678901234567890', 'Valorant', '', false).iconURL,
              Map.of({
                Role.TOP: PlayerDetails(
                  '7',
                  'Player Seven',
                  [],
                ),
                Role.BOT: PlayerDetails(
                  '8',
                  'Player Eight',
                  [],
                ),
              })),
          CalendarTeam(
              '5',
              'Valorant Bravo',
              'The second team of the Valorant server',
              '345678901234567890',
              DateTime.now().subtract(Duration(days: 4)),
              DiscordGuild('345678901234567890', 'Valorant', '', false).iconURL,
              Map.of({
                Role.MID: PlayerDetails(
                  '9',
                  'Player Nine',
                  [],
                ),
                Role.JG: PlayerDetails(
                  '10',
                  'Player Ten',
                  [],
                ),
              }))
        ],
      ),
      EventWTeams(
        title: 'Clash Tournament',
        startDate: '2025-03-15T00:00:00Z',
        startTime: '2025-03-15T18:00:00Z',
        endTime: '2025-03-15T21:00:00Z',
        description: 'Event 2 Description',
        registrationOpenDateTime: '2025-03-01T00:00:00Z',
        teams: [
          CalendarTeam(
              '6',
              'Goon Squad Charlie',
              'The third team of the Goon Squad server',
              '460520499680641035',
              DateTime.now().subtract(Duration(days: 5)),
              DiscordGuild('460520499680641035', 'Goon Squad',
                      '54d8b00023ca26be5c00a15f5ee9fe80', false)
                  .iconURL,
              Map.of({
                Role.TOP: PlayerDetails(
                  '11',
                  'Player Eleven',
                  [],
                ),
                Role.BOT: PlayerDetails(
                  '12',
                  'Player Twelve',
                  [],
                ),
              })),
          CalendarTeam(
              '7',
              'League Legends Bravo',
              'The second team of the League of Legends server',
              '417825368062558219',
              DateTime.now().subtract(Duration(days: 6)),
              DiscordGuild('417825368062558219', 'League of Legends',
                      'a093a2b1ce7dca7a4107cb4de610b40e', false)
                  .iconURL,
              Map.of({
                Role.MID: PlayerDetails(
                  '13',
                  'Player Thirteen',
                  [],
                ),
                Role.JG: PlayerDetails(
                  '14',
                  'Player Fourteen',
                  [],
                ),
              })),
          CalendarTeam(
              '8',
              'Valorant Charlie',
              'The third team of the Valorant server',
              '345678901234567890',
              DateTime.now().subtract(Duration(days: 7)),
              DiscordGuild('345678901234567890', 'Valorant', '', false).iconURL,
              Map.of({
                Role.TOP: PlayerDetails(
                  '15',
                  'Player Fifteen',
                  [],
                ),
                Role.BOT: PlayerDetails(
                  '16',
                  'Player Sixteen',
                  [],
                ),
              }))
        ],
      )
    ];
    return HomeV2(
      serverId: 0,
      servers: List.of(serverIds),
      events: events,
    );
  }
}
