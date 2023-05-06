import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/short-lived/league_champion_form.store.dart';
import 'package:clashbot_flutter/stores/short-lived/settings_rail.store.dart';
import 'package:clashbot_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../shimmer_loading_page.dart';

class SettingsPage extends StatelessWidget {
const SettingsPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return const ShowLoadingPageUntilLoggedIn(child: SettingsDashboard());
  }
}

class SettingsDashboard extends StatefulWidget {
  const SettingsDashboard({super.key});

  @override
  State<SettingsDashboard> createState() => _SettingsDashboardState();
}

class _SettingsDashboardState extends State<SettingsDashboard> {
  bool subscribed = false;
  Set<String> champions = {};
  List<String> validationList = ['abc'];
  late final LeagueChampionForm leagueChampionFormState;
  final SettingsRailStore settingsRailStore = SettingsRailStore();
  bool championNameIsValid = true;
  bool maxChampions = true;

  @override
  void dispose() {
    super.dispose();
    leagueChampionFormState.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ApplicationDetailsStore appStore =
        context.read<ApplicationDetailsStore>();
    leagueChampionFormState =
        LeagueChampionForm(appStore.riotChampionStore.lChampionsData);
    leagueChampionFormState.initValidator();
    return Observer(builder: (_) {
      return Row(
        children: [
          NavigationRail(
            selectedIndex: settingsRailStore.selectedIndex,
            groupAlignment: -1,
            onDestinationSelected: (int index) {
              settingsRailStore.changeIndex(index);
            },
            labelType: NavigationRailLabelType.selected,
            destinations: const <NavigationRailDestination>[
              NavigationRailDestination(
                icon: Icon(Icons.favorite_border),
                selectedIcon: Icon(Icons.favorite),
                label: Text('Clash Bot'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.discord_outlined),
                selectedIcon: Icon(Icons.discord),
                label: Text('Discord'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.group_add_outlined),
                selectedIcon: Icon(Icons.group),
                label: Text('League of Legends'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          const SizedBox(width: 10),
          Center(child: railSelection),
        ],
      );
    });
  }

  get railSelection {
    switch (settingsRailStore.selectedIndex) {
      case 0:
        return const ClashBotSettingsSection();
      case 1:
        return const DiscordSettingsSection();
      case 2:
        return const LeagueOfLegendsSettingsSection();
    }
    ;
  }
}

class ClashBotSettingsSection extends StatelessWidget {
  const ClashBotSettingsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size.fromWidth(500)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Clash Bot Settings', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 10),
          Text('Subscriptions',
            style: Theme.of(context).textTheme.headlineSmall),
          const DiscordSubscriptionWidget(),
        ],
      ),
    );
  }
}

class LeagueOfLegendsSettingsSection extends StatelessWidget {
  const LeagueOfLegendsSettingsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size.fromWidth(500)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('League of Legends Settings', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 10),
          const PreferredChampionsWidget(),
        ],
      ),
    );
  }
}

class DiscordSettingsSection extends StatelessWidget {
  const DiscordSettingsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size.fromWidth(500)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Discord Settings', style: Theme.of(context).textTheme.displaySmall),
          const SizedBox(height: 10),
          DiscordUserTile(),
          const SelectedServersSetting(),
        ],
      ),
    );
  }
}

class DiscordUserTile extends StatelessWidget {
  const DiscordUserTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    return Observer(
        builder: (context) => ConstrainedBox(
          constraints: const BoxConstraints.tightFor(width: 400),
          child: Card(
            child: ListTile(
              leading: CircleAvatar(backgroundImage: NetworkImage(appStore.discordDetailsStore.discordUser.avatarURL)),
              title: Text(appStore.discordDetailsStore.discordUser.username),
              subtitle: Text(appStore.id),
              trailing: const Icon(Icons.discord),
            ),
          ),
        ));
  }
}

class DiscordSubscriptionWidget extends StatelessWidget {
  const DiscordSubscriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    return Observer(
        builder: (_) => ListTile(
          title: Text(
              "Upcoming Tournament notification?",
              style: Theme.of(context).textTheme.titleSmall),
          subtitle: Text(
            "If subscribed, you will recieve a Discord message of the Monday prior to a Clash Tournament.",
             style: Theme.of(context).textTheme.bodySmall
          ),
          trailing: Switch(
              value: appStore
                      .loggedInClashUser
                      .subscriptions[SubscriptionType
                          .DISCORD_MONDAY_NOTIFICATION.value]
                      ?.isOn ??
                  false,
              activeColor: Colors.green,
              onChanged: (value) => appStore.loggedInClashUser
                  .toggleSubscription(
                      SubscriptionType.DISCORD_MONDAY_NOTIFICATION)),
        ));
  }
}

class PreferredChampionsWidget extends StatelessWidget {
  const PreferredChampionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    return Observer(
      builder: (_) => Column(
        children: [
          Row(children: [
            Text('Preferred Champions', style: Theme.of(context).textTheme.headlineSmall),
          ]),
          appStore.loggedInClashUser.canAddMorePreferredChampions
              ? Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    if (textEditingValue.text == '') {
                      return const Iterable<String>.empty();
                    }
                    return appStore.riotChampionStore.championNames
                        .where((String option) {
                      return option.contains(textEditingValue.text);
                    });
                  },
                  onSelected:
                      appStore.loggedInClashUser.canAddMorePreferredChampions
                          ? appStore.loggedInClashUser.addChampion
                          : null,
                )
              : Text("Maximum preferred champions reached.", style: Theme.of(context).textTheme.labelSmall),
          const SmallBreak(),
          Wrap(
              spacing: 5,
              runSpacing: 3,
              children: appStore.loggedInClashUser.champions.map((name) {
                var champion = appStore.riotChampionStore.lChampionsData.data?[name];
                return Chip(
                  avatar: CircleAvatar(
                    foregroundImage: isNull(champion?.key) ? null : NetworkImage(champion?.imageUrl ?? '')
                  ),
                  label: Text(name),
                  onDeleted: () =>
                      appStore.loggedInClashUser.removeChampion(name),
                );
              }).toList())
        ],
      ),
    );
  }
}

class SelectedServersSetting extends StatelessWidget {
  const SelectedServersSetting({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    return Observer(builder: (_) {
      return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Your currently selected Servers to use.',
            style: Theme.of(context).textTheme.headlineSmall),
        Text('(Maximum of 5)', style: Theme.of(context).textTheme.labelSmall),
          ],
        ),
        const SmallBreak(),
        DropdownButton<String>(
            value: null,
            hint: const Text("Select a Discord Server..."),
            icon: const Icon(Icons.arrow_downward),
            menuMaxHeight: 300.0,
            elevation: 16,
            onChanged: appStore.loggedInClashUser.canAddMoreSelectedServers
                ? (String? value) {
                    if (null != value) {
                      appStore.loggedInClashUser.addSelectedServer(value);
                    }
                  }
                : null,
            items: appStore.discordDetailsStore.discordGuilds
                .map<DropdownMenuItem<String>>((guild) {
              return DropdownMenuItem<String>(
                value: guild.id,
                child: Text(guild.name ?? ''),
              );
            }).toList()),
        const SmallBreak(),
        SizedBox(
          width: 300,
          child: Wrap(
              spacing: 6.0,
              runSpacing: 4.0,
              children: appStore.loggedInClashUser.selectedServers
                  .map<Chip>((String server) {
                var guild =
                    appStore.discordDetailsStore.discordGuildMap[server];
                return Chip(
                  avatar: CircleAvatar(
                    backgroundImage: NetworkImage(guild?.iconURL ?? ''),
                  ),
                  label: Text(guild?.name ?? ''),
                  deleteIcon: const Icon(Icons.cancel),
                  onDeleted: () =>
                      appStore.loggedInClashUser.removeSelectedServer(server),
                );
              }).toList()),
        ),
      ]);
    });
  }
}

class SmallBreak extends StatelessWidget {
  const SmallBreak({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 10,
    );
  }
}
