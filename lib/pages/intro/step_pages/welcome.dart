import 'package:clashbot_flutter/styles.dart';
import 'package:flutter/widgets.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
