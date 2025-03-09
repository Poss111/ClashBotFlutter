import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/pages/home/home_v2.dart';
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
    const List<Map<String, String>> events = [
      {
        'title': 'Event 1',
        'date': '2025-03-05',
        'description': 'Description 1',
        'serverId': '460520499680641035',
      },
      {
        'title': 'Event 2',
        'date': '2025-03-05',
        'description': 'Description 2',
        'serverId': '460520499680641035',
      },
      {
        'title': 'Event 2',
        'date': '2025-03-06',
        'description': 'Description 2',
        'serverId': '417825368062558219',
      },
      {
        'title': 'Event 3',
        'date': '2025-03-07',
        'description': 'Description 3',
        'serverId': '417825368062558219',
      },
    ];
    return HomeV2(
      serverId: 0,
      servers: List.of(serverIds),
      events: events,
    );
  }
}
