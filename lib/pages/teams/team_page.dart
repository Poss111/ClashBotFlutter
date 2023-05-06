import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/clash_tournament.dart';
import 'package:clashbot_flutter/models/role_map.dart';
import 'package:clashbot_flutter/models/tentative_queue.dart';
import 'package:clashbot_flutter/pages/shimmer_loading_page.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/short-lived/create_team_form.store.dart';
import 'package:clashbot_flutter/stores/short-lived/create_tentative_form.store.dart';
import 'package:clashbot_flutter/utils/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:developer' as developer;

import 'package:recase/recase.dart';
import 'package:validators/validators.dart';

class TeamPage extends StatelessWidget {
  const TeamPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ShowLoadingPageUntilLoggedIn(child: TeamsDashboard());
  }
}

class TeamsDashboard extends StatefulWidget {
  const TeamsDashboard({super.key});

  @override
  State<TeamsDashboard> createState() => _TeamsDashboardState();
}

class _TeamsDashboardState extends State<TeamsDashboard> {
  @override
  Widget build(BuildContext context) {
    var margin = 15.0;
    final appStore = context.read<ApplicationDetailsStore>();
    final createTeamStore = CreateTeamFormStore(appStore);
    final createTentativeFormStore = CreateTentativeFormStore(appStore);
    return Observer(builder: (_) {
      List<Widget> tentativeCards = appStore
          .loggedInClashUser.filteredTentativeQueues
          .map((tentative) => TentativeQueueCard(tentativeQueue: tentative)
              .animate()
              .fadeIn(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn))
          .toList();
      List<Widget> clashTeamCards = appStore.loggedInClashUser.filteredTeamsList
          .map((team) => ClashCard(clashTeam: team).animate().fadeIn(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn))
          .toList();
      List<Widget> toShow = appStore.loggedInClashUser.showTeams
          ? clashTeamCards
          : tentativeCards;
      return Scaffold(
          body: Container(
            margin: EdgeInsets.all(margin),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Choose a Server to filter by...'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 5,
                  children: appStore.loggedInClashUser.selectedServers.map(
                    (server) {
                      var guild =
                          appStore.discordDetailsStore.discordGuildMap[server];
                      return ChoiceChip(
                          label: Text(guild!.name ?? ''),
                          selected: appStore.loggedInClashUser.serverFilter ==
                              guild.id,
                          onSelected: (bool selected) {
                            appStore.loggedInClashUser.filterByServer(guild.id);
                          });
                    },
                  ).toList(),
                ),
                const SizedBox(height: 10),
                const Text('What list do you want to view?'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 5,
                  children: [
                    ChoiceChip(
                        label: const Text('Teams'),
                        selected: appStore.loggedInClashUser.showTeams,
                        onSelected: (bool selected) {
                          appStore.loggedInClashUser.showTeamsView();
                        }),
                    ChoiceChip(
                        label: const Text('Tentative Queues'),
                        selected: !appStore.loggedInClashUser.showTeams,
                        onSelected: (bool selected) {
                          appStore.loggedInClashUser.showTentativeView();
                        })
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Choose a Tournament to filter by...'),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 5,
                  children: appStore.tournaments.map(
                    (tournament) {
                      return ChoiceChip(
                          label: Text(
                              "${tournament.tournamentName.sentenceCase} Day ${tournament.tournamentDay}"),
                          selected:
                              "${appStore.loggedInClashUser.tournamentNameFilter} ${appStore.loggedInClashUser.tournamentDayFilter}" ==
                                  "${tournament.tournamentName} ${tournament.tournamentDay}",
                          onSelected: (bool selected) {
                            appStore.loggedInClashUser.filterByTournamentName(
                                tournament.tournamentName);
                            appStore.loggedInClashUser.filterByTournamentDay(
                                tournament.tournamentDay);
                          });
                    },
                  ).toList(),
                ),
                Expanded(
                  child: Center(
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 4,
                      children: toShow,
                    ),
                  ),
                ),
              ],
            ),
          ),
          floatingActionButton: appStore.loggedInClashUser.showTeams
              ? FloatingActionButton.extended(
                  onPressed: appStore.loggedInClashUser.callInProgress
                      ? null
                      : () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return CreateTeamDialogWidget(
                                createTeamStore: createTeamStore,
                                appStore: appStore);
                          }),
                  label: const Icon(Icons.add),
                )
              : appStore.loggedInClashUser.availableTentativeTournaments
                      .isNotEmpty
                  ? FloatingActionButton.extended(
                      onPressed: appStore.loggedInClashUser.callInProgress
                          ? null
                          : () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) {
                                return CreateTenativeQueueDialogWidget(
                                    createTentativeFormStore:
                                        createTentativeFormStore,
                                    appStore: appStore);
                              }),
                      label: const Icon(Icons.add),
                    )
                  : null);
    });
  }
}

class CreateTenativeQueueDialogWidget extends StatelessWidget {
  const CreateTenativeQueueDialogWidget({
    super.key,
    required this.createTentativeFormStore,
    required this.appStore,
  });

  final CreateTentativeFormStore createTentativeFormStore;
  final ApplicationDetailsStore appStore;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Create a new Tentative Queue',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 270,
                      child: DropdownButton(
                          isExpanded: true,
                          hint: const Text('Tournament'),
                          value: createTentativeFormStore.clashTournament,
                          items: appStore
                              .loggedInClashUser.availableTentativeTournaments
                              .map((tourney) => DropdownMenuItem(
                                    value: tourney,
                                    child: Text(
                                        '${tourney.tournamentName} Day ${tourney.tournamentDay}'),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value is ClashTournament) {
                              createTentativeFormStore.clashTournament = value;
                            }
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                DropdownButton(
                    hint: const Text('Server'),
                    value: createTentativeFormStore.serverId,
                    items: appStore.loggedInClashUser.selectedServers
                        .map((serverId) => DropdownMenuItem(
                              value: serverId,
                              child: Text(appStore.discordDetailsStore
                                      .discordGuildMap[serverId]?.name ??
                                  ''),
                            ))
                        .toList(),
                    onChanged: (value) =>
                        createTentativeFormStore.serverId = value),
                const SizedBox(height: 10),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: createTentativeFormStore.ableToSubmit
                          ? () {
                              createTentativeFormStore.submit();
                              Navigator.pop(context);
                            }
                          : null,
                      child: const Text('Create'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class CreateTeamDialogWidget extends StatelessWidget {
  const CreateTeamDialogWidget({
    super.key,
    required this.createTeamStore,
    required this.appStore,
  });

  final CreateTeamFormStore createTeamStore;
  final ApplicationDetailsStore appStore;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text('Create a new Team',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 15),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Team Name',
                  ),
                  maxLength: 20,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  onChanged: (value) => createTeamStore.teamName = value,
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 270,
                      child: DropdownButton(
                          isExpanded: true,
                          hint: const Text('Tournament'),
                          value: createTeamStore.clashTournament,
                          items: appStore.tournaments
                              .map((tourney) => DropdownMenuItem(
                                    value: tourney,
                                    child: Text(
                                        '${tourney.tournamentName} Day ${tourney.tournamentDay}'),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value is ClashTournament) {
                              createTeamStore.clashTournament = value;
                            }
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton(
                        hint: const Text('Server'),
                        value: createTeamStore.serverId,
                        items: appStore.loggedInClashUser.selectedServers
                            .map((serverId) => DropdownMenuItem(
                                  value: serverId,
                                  child: Text(appStore.discordDetailsStore
                                          .discordGuildMap[serverId]?.name ??
                                      ''),
                                ))
                            .toList(),
                        onChanged: (value) => createTeamStore.serverId = value),
                    DropdownButton(
                        hint: const Text('Role'),
                        value: createTeamStore.role,
                        items: roleToValueMapper.entries
                            .map((keyValuePair) => DropdownMenuItem(
                                  value: keyValuePair.key,
                                  child: Text(keyValuePair.value),
                                ))
                            .toList(),
                        onChanged: (value) => createTeamStore.role = value),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: createTeamStore.ableToSubmit
                          ? () {
                              createTeamStore.submit();
                              Navigator.pop(context);
                            }
                          : null,
                      child: const Text('Create'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class TentativeQueueCard extends StatelessWidget {
  const TentativeQueueCard({
    super.key,
    required this.tentativeQueue,
  });

  final TentativeQueue tentativeQueue;

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();

    var discordGuild =
        appStore.discordDetailsStore.discordGuildMap[tentativeQueue.serverId];
    return Observer(builder: (_) {
      return SizedBox(
        width: 300,
        child: Card(
            child: Column(
          children: [
            ListTile(
                leading: CircleAvatar(
                  backgroundImage: isNull(discordGuild?.iconURL)
                      ? null
                      : NetworkImage(discordGuild?.iconURL ?? ''),
                ),
                title: TournamentText(
                    tournamentName: tentativeQueue.tournamentName,
                    tournamentDay: tentativeQueue.tournamentDay),
                subtitle: const LabelTextSmall(
                    message: "Tap to add or remove yourself."),
                onTap: appStore.loggedInClashUser.callInProgress
                    ? null
                    : () => {
                          if (!tentativeQueue.users.contains(appStore.id))
                            {
                              appStore.loggedInClashUser
                                  .addToTentativeQueue(tentativeQueue.id)
                            }
                          else
                            {
                              appStore.loggedInClashUser
                                  .removeFromTentativeQueue(tentativeQueue.id)
                            }
                        },
                trailing: Text(tentativeQueue.users.length.toString())),
            ...tentativeQueue.users.map((user) {
              return ListTile(
                  leading: const Icon(Icons.person),
                  title: Observer(
                    builder: (_) {
                      String? username =
                          appStore.discordDetailsStore.discordIdToName[user];
                      if (isNull(username)) {
                        appStore.discordDetailsStore.fetchUserDetails(user);
                      }
                      return Text(username ?? user);
                    },
                  ));
            }).toList()
          ],
        )),
      );
    });
  }
}

class ClashCard extends StatelessWidget {
  const ClashCard({super.key, required this.clashTeam});

  final ClashTeam clashTeam;

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    List<Role> orderOfRoles =
        roleToValueMapper.entries.map((entry) => entry.key).toList();
    List<Widget> roles = orderOfRoles.map((element) {
      var member = clashTeam.members[element];
      var roleToDisplay = roleToValueMapper[element] ?? 'N/A';
      if (null != member) {
        return AssignedRole(
          role: element,
          roleToDisplay: roleToDisplay,
          username: appStore.id == member.id
              ? appStore.discordDetailsStore.discordUser.username
              : member.name,
          discordId: member.id,
          champions: member.champions,
          isUser: appStore.id == member.id,
          onRemove: () =>
              {appStore.loggedInClashUser.removeFromTeam(clashTeam.id)},
        );
      }
      return UnassignedRole(
          role: element, roleToDisplay: roleToDisplay, teamId: clashTeam.id);
    }).toList();

    var discordGuild =
        appStore.discordDetailsStore.discordGuildMap[clashTeam.serverId];

    return SizedBox(
      width: 300,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.update),
                      BodyTextSmall(
                          message:
                              DateFormat.yMd().add_jm().format(clashTeam.lastUpdatedAt.toLocal())),
                    ],
                  ),
              ListTile(
                leading: CircleAvatar(
                  radius:25,
                  foregroundImage: isNull(discordGuild?.iconURL)
                      ? null
                      : NetworkImage(discordGuild?.iconURL ?? ''),
                ),
                title: TitleTextLarge(message: clashTeam.name),
                subtitle: ListTile(
                  title: TournamentText(
                      tournamentName: clashTeam.tournamentName.sentenceCase,
                      tournamentDay: clashTeam.tournamentDay),
                ),
              ),
              ListView.builder(
                itemCount: roles.length,
                itemBuilder: (_, index) {
                  return roles[index];
                },
                shrinkWrap: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class TournamentText extends StatelessWidget {
  const TournamentText({
    super.key,
    required this.tournamentName,
    required this.tournamentDay,
  });

  final String tournamentName;
  final String tournamentDay;

  @override
  Widget build(BuildContext context) {
    return TitleTextSmall(message: '$tournamentName - Day $tournamentDay');
  }
}

class AssignedRole extends StatelessWidget {
  const AssignedRole(
      {super.key,
      required this.username,
      required this.discordId,
      required this.role,
      required this.roleToDisplay,
      required this.champions,
      required this.isUser,
      required this.onRemove});

  final String username;
  final String discordId;
  final Role role;
  final String roleToDisplay;
  final List<String> champions;
  final bool isUser;
  final Function onRemove;

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    return ExpansionTile(
      leading: isUser
          ? IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                onRemove();
              },
            )
          : null,
      title: Observer(builder: (_) {
        String? username =
            appStore.discordDetailsStore.discordIdToName[discordId];
        if (isNull(username)) {
          appStore.discordDetailsStore.fetchUserDetails(discordId);
        }
        return LabelTextLarge(message: username ?? discordId);
      }),
      subtitle: LabelTextSmall(message: roleToDisplay),
      children: [
        Wrap(
            spacing: 4,
            runSpacing: 2,
            children: champions
                .map((element) => ChampionTile(championName: element))
                .toList())
      ],
    );
  }
}

class ChampionTile extends StatelessWidget {
  const ChampionTile({
    super.key,
    required this.championName,
  });

  final String championName;

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    return Observer(builder: (_) {
      var championDetail = appStore.riotChampionStore.lChampionsData.data?[championName];
      return Chip(
          avatar: CircleAvatar(foregroundImage: isNull(championDetail?.imageUrl) ? 
            null : NetworkImage(championDetail?.imageUrl ?? '')),
          label: LabelTextLarge(message: championName));
    });
  }
}

class UnassignedRole extends StatelessWidget {
  const UnassignedRole({
    super.key,
    required this.roleToDisplay,
    required this.role,
    required this.teamId,
  });

  final String roleToDisplay;
  final Role role;
  final String teamId;

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    return Observer(builder: (_) {
      developer.log("Updating!!! ${appStore.loggedInClashUser.callInProgress}");
      return Card(
        child: FilledButton(
            style: FilledButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            onPressed: appStore.loggedInClashUser.callInProgress
                ? null
                : () {
                    appStore.loggedInClashUser.addToTeam(role, teamId);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Assigning to $role..."),
                      duration: const Duration(milliseconds: 500),
                    ));
                  },
            child: Text(roleToDisplay)),
      );
    });
  }
}
