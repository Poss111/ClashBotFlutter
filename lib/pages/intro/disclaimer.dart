import 'package:clashbot_flutter/pages/settings/settings_page.dart';
import 'package:clashbot_flutter/utils/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DisclaimerWidget extends StatelessWidget {
  const DisclaimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const styleRiotGamesText = TextSpan(
      text: " Riot Games",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
    );
    const styleDiscordText = TextSpan(
      text: " Discord",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
    );
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
                  HeadlineTextMedium(message: 'Disclaimers'),
                ],
              ),
              const SmallBreak(),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                      text: "Clash-Bot",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " is not endorsed by",
                    ),
                    styleRiotGamesText,
                    TextSpan(
                        text: " and does not reflect the views or opinions of"),
                    styleRiotGamesText,
                    TextSpan(
                        text:
                            " or anyone officially involved in producing or managing League of Legends. League of Legends and"),
                    styleRiotGamesText,
                    TextSpan(
                        text: " are trademarks or registered trademarks of"),
                    styleRiotGamesText,
                    TextSpan(text: ", Inc. League of Legends \u00a9"),
                    styleRiotGamesText,
                    TextSpan(text: ", Inc.")
                  ],
                ),
              ),
              const SmallBreak(),
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: const <TextSpan>[
                    TextSpan(
                      text: "Clash-Bot",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: " is not endorsed by",
                    ),
                    styleDiscordText,
                    TextSpan(
                        text: " and does not reflect the views or opinions of"),
                    styleDiscordText,
                    TextSpan(
                        text:
                            " or anyone officially involved in producing or managing"),
                    styleDiscordText,
                    TextSpan(text: "."),
                    styleDiscordText,
                    TextSpan(
                        text: " is a trademark or registered trademark of"),
                    styleDiscordText,
                    TextSpan(text: "."),
                  ],
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Dismiss"))
              ])
            ],
          ))),
    );
  }
}
