import 'package:clashbot_flutter/pages/settings/settings_page.dart';
import 'package:clashbot_flutter/styles.dart';
import 'package:flutter/widgets.dart';

class HowToUseClashBotWidget extends StatelessWidget {
  const HowToUseClashBotWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
