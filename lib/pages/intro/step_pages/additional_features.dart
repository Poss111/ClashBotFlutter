import 'package:clashbot_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdditonalFeaturesWidget extends StatelessWidget {
  const AdditonalFeaturesWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
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
