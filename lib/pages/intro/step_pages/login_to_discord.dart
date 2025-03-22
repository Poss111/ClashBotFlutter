import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class LoginToDiscordWidget extends StatelessWidget {
  const LoginToDiscordWidget({
    super.key,
    required this.callback,
  });

  final Function(bool ableToNavigate) callback;

  @override
  Widget build(BuildContext context) {
    final discordDetailsStore = context.read<DiscordDetailsStore>();
    var dispose = when(
        (_) =>
            discordDetailsStore.userHasLoggedIn == true &&
            discordDetailsStore.discordGuilds.isNotEmpty, () {
      callback(true);
    });
    return Observer(builder: (_) {
      return !discordDetailsStore.userHasLoggedIn
          ? const AskToLogin()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(discordDetailsStore.discordUser.avatarURL),
                  radius: 50,
                ),
                const SizedBox(height: 10),
                AnimatedTextKit(
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Welcome ${discordDetailsStore.discordUser.username}!',
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
    final discordDetailsStore = context.read<DiscordDetailsStore>();
    return Observer(builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Lets log you in to Discord!", style: subHeaderStyle),
          const SizedBox(height: 10),
          !discordDetailsStore.loadingData
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
    return Consumer<DiscordDetailsStore>(
        builder: (context, discordDetailsStore, child) => ElevatedButton(
            onPressed: () {
              discordDetailsStore.fetchCurrentUserDetails();
            },
            child: const Text("Login to Discord")));
  }
}
