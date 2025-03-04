import 'package:clashbot_flutter/pages/settings/settings_page.dart';
import 'package:clashbot_flutter/styles.dart';
import 'package:flutter/widgets.dart';

class WhatIsClashBotWidget extends StatelessWidget {
  const WhatIsClashBotWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('What is Clash Bot?', style: subHeaderStyle),
        SmallBreak(),
        Text(
            'Clash Bot is an app built to help you setup a League of Legends Clash Team through Discord!'),
      ],
    );
  }
}
