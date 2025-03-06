import 'package:clashbot_flutter/models/model_first_time.dart';
import 'package:clashbot_flutter/pages/intro/disclaimer.dart';
import 'package:clashbot_flutter/pages/intro/step_pages/additional_features.dart';
import 'package:clashbot_flutter/pages/intro/step_pages/how_to_use_clash_bot.dart';
import 'package:clashbot_flutter/pages/intro/step_pages/login_to_discord.dart';
import 'package:clashbot_flutter/pages/intro/step_pages/select_servers.dart';
import 'package:clashbot_flutter/pages/intro/step_pages/welcome.dart';
import 'package:clashbot_flutter/pages/intro/step_pages/what_is_clash.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/short-lived/selected_server_form.store.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

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
    showDisclaimer = true;
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

    if (showDisclaimer) {
      Future.delayed(
          Duration.zero,
          () => showDialog<String>(
              context: context,
              builder: (context) {
                return const Dialog(child: DisclaimerWidget());
              }));
      showDisclaimer = false;
    }

    final appStore = context.read<ApplicationDetailsStore>();

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
                              ? () async {
                                  await FirebaseAnalytics.instance.logEvent(
                                      name: 'welcome_page_next_button');
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
              foregroundColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
                if (selectedServerFormStore.callFailed) {
                  return Theme.of(context).colorScheme.error;
                }
                return null; // Use the component's default.
              }),
              iconColor: WidgetStateProperty.resolveWith<Color?>(
                  (Set<WidgetState> states) {
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
