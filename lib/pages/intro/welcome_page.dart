import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/model_first_time.dart';
import 'package:clashbot_flutter/pages/settings/settings_page.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/short-lived/selected_server_form.store.dart';
import 'package:clashbot_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

class WelcomeDashboard extends StatefulWidget {
  const WelcomeDashboard({super.key});

  @override
  State<WelcomeDashboard> createState() => _WelcomeDashboard();
}

class _WelcomeDashboard extends State<WelcomeDashboard> {
  var index = 0;
  bool allowNavigation = false;
  ServerFormController serverFormController = ServerFormController();
  late SelectedServerFormStore selectedServerFormStore;
  bool enableNavigation = true;
  bool showDisclaimer = true;

  @override
  void initState() {
    super.initState();
    allowNavigation = false;
    selectedServerFormStore = SelectedServerFormStore();
  }

  @override
  Widget build(BuildContext context) {
    callback(bool ableToNavigate) {
      if (enableNavigation != ableToNavigate) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          setState(() {
            enableNavigation = ableToNavigate;
          });
        });
      }
    }

    Future.delayed(
        Duration.zero,
        () => showDialog<String>(
            context: context,
            builder: (context) {
              return const Dialog(child: DisclaimerWidget());
            }));

    List<Widget> welcomeWidgetsOrder = List.empty(growable: true);
    welcomeWidgetsOrder.add(const WelcomeWidget());
    welcomeWidgetsOrder.add(const WhatIsClashBotWidget());
    welcomeWidgetsOrder.add(const HowToUseClashBotWidget());
    welcomeWidgetsOrder.add(const AdditonalFeaturesWidget());
    welcomeWidgetsOrder.add(LoginToDiscordWidget(callback: callback));
    welcomeWidgetsOrder.add(ServerFormWidget(
        availableServers: {},
        selectedServerFormStore: selectedServerFormStore));
    var mainContentWidth = 500.0;
    var margin = 15.0;
    return Container(
        margin: EdgeInsets.all(margin),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SizedBox(
                  width: mainContentWidth,
                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) =>
                              SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(2, 0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: child),
                      child: welcomeWidgetsOrder[index]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  index + 1 == welcomeWidgetsOrder.length
                      ? EndWelcomePageSessionButton(
                          selectedServerFormStore: selectedServerFormStore)
                      : ElevatedButton(
                          onPressed: enableNavigation
                              ? () {
                                  if (index + 1 < welcomeWidgetsOrder.length) {
                                    setState(() {
                                      index = index + 1;
                                      enableNavigation = false;
                                      if (index != 4) {
                                        callback(true);
                                      }
                                    });
                                  }
                                }
                              : null,
                          child: const Text("Next")),
                ],
              ),
            ]));
  }
}

class EndWelcomePageSessionButton extends StatelessWidget {
  const EndWelcomePageSessionButton({
    super.key,
    required this.selectedServerFormStore,
  });

  final SelectedServerFormStore selectedServerFormStore;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ModelFirstTime, ApplicationDetailsStore>(builder: (context,
        ModelFirstTime modelFirstTime,
        ApplicationDetailsStore appStore,
        consChild) {
      return Observer(builder: (context) {
        return ElevatedButton.icon(
            onPressed: !selectedServerFormStore.ableToSubmit
                ? null
                : () {
                    selectedServerFormStore.submittingForm();
                    appStore.loggedInClashUser
                        .createUser(
                            selectedServerFormStore.listOfSelectedServers.first
                                .toString(),
                            selectedServerFormStore.listOfSelectedServers)
                        .then((value) {
                      appStore.riotChampionStore.refreshChampionData();
                      appStore.loggedInClashUser.refreshTeamList();
                      appStore.loggedInClashUser.refreshTentativeQueue();
                      modelFirstTime.visited = true;
                      context.goNamed('teams');
                    }).catchError((error) {
                      selectedServerFormStore.callFailed = true;
                      selectedServerFormStore.submitting = false;
                    });
                  },
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (selectedServerFormStore.callFailed) {
                  return Theme.of(context).colorScheme.error;
                }
                return null; // Use the component's default.
              }),
              iconColor: MaterialStateProperty.resolveWith<Color?>(
                  (Set<MaterialState> states) {
                if (selectedServerFormStore.callFailed) {
                  return Theme.of(context).colorScheme.error;
                }
                return null; // Use the component's default.
              }),
            ),
            label: selectedServerFormStore.callFailed
                ? const Text("Please try again")
                : const Text("Lets Go!"),
            icon: selectedServerFormStore.submitting
                ? Container(
                    width: 24,
                    height: 24,
                    padding: const EdgeInsets.all(2.0),
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : selectedServerFormStore.callFailed
                    ? const Icon(Icons.error)
                    : const Icon(Icons.feedback));
      });
    });
  }
}

class LoginToDiscordWidget extends StatelessWidget {
  const LoginToDiscordWidget({
    super.key,
    required this.callback,
  });

  final Function(bool ableToNavigate) callback;

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    var dispose =
        when((_) => appStore.discordDetailsStore.detailsLoaded == true, () {
      callback(true);
    });
    return Observer(builder: (_) {
      return !appStore.discordDetailsStore.detailsLoaded
          ? const AskToLogin()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      appStore.discordDetailsStore.discordUser.avatarURL),
                  radius: 50,
                ),
                const SizedBox(height: 10),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Welcome ${appStore.discordDetailsStore.discordUser.username}!',
                      textStyle: subHeaderStyle,
                      speed: const Duration(milliseconds: 150),
                    ),
                  ],
                  totalRepeatCount: 1,
                  pause: const Duration(milliseconds: 1000),
                  displayFullTextOnTap: true,
                  stopPauseOnTap: true,
                )
              ],
            );
    });
  }
}

class AskToLogin extends StatelessWidget {
  const AskToLogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    return Observer(builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Lets log you in to Discord!", style: subHeaderStyle),
          const SizedBox(height: 10),
          appStore.discordDetailsStore.status == "NOT_LOADED"
              ? const LoginToDiscord()
              : ElevatedButton.icon(
                  onPressed: null,
                  icon: const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator()),
                  label: const Text("Logging in"))
        ],
      );
    });
  }
}

class LoginToDiscord extends StatelessWidget {
  const LoginToDiscord({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ApplicationDetailsStore>(
        builder: (context, appStore, child) => ElevatedButton(
            onPressed: () {
              appStore.discordDetailsStore.loadEverything();
            },
            child: const Text("Login to Discord")));
  }
}

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Welcome',
          style: headerStyle,
        ),
        Text(
          'to',
          style: headerStyle,
        ),
        Text(
          'ClashBot 2.0!',
          style: headerStyle,
        ),
      ],
    );
  }
}

class DisclaimerWidget extends StatelessWidget {
  const DisclaimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  Text('Disclaimers', style: subHeaderStyle),
                ],
              ),
              const SmallBreak(),
              const Text(
                  'Clash-Bot is not endorsed by Riot Games and does not reflect the views or opinions of Riot Games or anyone officially involved in producing or managing League of Legends. League of Legends and Riot Games are trademarks or registered trademarks of Riot Games, Inc. League of Legends &copy Riot Games, Inc.'),
              const SmallBreak(),
              const Text(
                  'Clash-Bot is not endorsed by Discord and does not reflect the views or opinions of Discord or anyone officially involved in producing or managing Discord. Discord is a trademark or registered trademark of Discord.'),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Dismiss"))
              ])
            ],
          ))),
    );
  }
}

class AdditonalFeaturesWidget extends StatelessWidget {
  const AdditonalFeaturesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('Additional Features', style: subHeaderStyle),
        ListTile(
          title: Text(
              'Setting a list of preferred LoL champions for your Discord account'),
          leading: Icon(Icons.looks_one),
        ),
        ListTile(
          title: Text('Knowing when the next Clash Tournament is'),
          leading: Icon(Icons.looks_two),
        ),
        ListTile(
          title: Text(
              'Notification of an upcoming Clash Tournaments through Discord'),
          leading: Icon(Icons.looks_3),
        ),
      ],
    );
  }
}

class HowToUseClashBotWidget extends StatelessWidget {
  const HowToUseClashBotWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('How to Use Clash Bot!', style: subHeaderStyle),
        SmallBreak(),
        Text('Teams', style: subGroupStyle),
        SmallBreak(),
        Text(
            'When you sign up for a Team, you are selecting a role and a LoL Clash Tournament based on a Discord Server you would like to participate in. A team can have up to 5 players, one for each position in League.'),
        SmallBreak(),
        Text('Tentative Queues', style: subGroupStyle),
        SmallBreak(),
        Text(
            'When you sign up for a Tentative Queue, you are letting members of your Discord Server know that you would like to play but you are not quite certain yet if you are able to join.'),
      ],
    );
  }
}

class WhatIsClashBotWidget extends StatelessWidget {
  const WhatIsClashBotWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text('What is Clash Bot?', style: subHeaderStyle),
        SmallBreak(),
        Text(
            'Clash Bot is an app built to help you setup a League of Legends Clash Team through Discord!'),
      ],
    );
  }
}

class ServerFormWidget extends StatelessWidget {
  const ServerFormWidget({
    super.key,
    required this.availableServers,
    required this.selectedServerFormStore,
  });

  final Map<int, DiscordGuild> availableServers;
  final SelectedServerFormStore selectedServerFormStore;

  @override
  Widget build(BuildContext context) {
    final applicationDetailsStore = context.read<ApplicationDetailsStore>();
    return Observer(
      builder: (_) =>
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text('Getting Started', style: headerStyle),
        const SizedBox(height: 10),
        const Text(
            'Almost there! To setup the servers you want to use, please select your top 5.'),
        const SizedBox(height: 10),
        DropdownButton<String>(
            value: null,
            hint: const Text("Select a Discord Server..."),
            icon: const Icon(Icons.arrow_downward),
            menuMaxHeight: 300.0,
            elevation: 16,
            onChanged: !selectedServerFormStore.maxServersReached
                ? (String? value) {
                    if (null != value) {
                      selectedServerFormStore.addServer(value);
                    }
                  }
                : null,
            items: applicationDetailsStore.discordDetailsStore.discordGuilds
                .map<DropdownMenuItem<String>>((guild) {
              return DropdownMenuItem<String>(
                value: guild.id,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(guild.iconURL),
                    ),
                    Text(guild.name ?? ''),
                  ],
                ),
              );
            }).toList()),
        const SizedBox(height: 10),
        SizedBox(
          width: 300,
          child: Wrap(
              spacing: 6.0,
              runSpacing: 4.0,
              children: selectedServerFormStore.listOfSelectedServers
                  .map<Chip>((String server) {
                var guild = applicationDetailsStore
                    .discordDetailsStore.discordGuildMap[server];
                return Chip(
                  avatar: CircleAvatar(
                    backgroundImage: NetworkImage(guild?.iconURL ?? ''),
                  ),
                  label: Text(guild?.name ?? ''),
                  deleteIcon: const Icon(Icons.cancel),
                  onDeleted: () => selectedServerFormStore.removeServer(server),
                );
              }).toList()),
        ),
      ]),
    );
  }
}

class ServerFormController extends MaterialStatesController {
  Set<String> listOfSelectedServers = {};

  void setValue(String value) {
    listOfSelectedServers.add(value);
    notifyListeners();
  }

  void removeValue(String value) {
    listOfSelectedServers.remove(value);
    notifyListeners();
  }
}

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
    context, message) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    action: null,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  ));
}
