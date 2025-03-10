import 'package:clashbot_flutter/pages/home/page/home_v2.dart';
import 'package:flutter/material.dart';

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
