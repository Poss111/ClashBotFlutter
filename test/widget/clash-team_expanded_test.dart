import 'dart:io';

import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/globals/color_schemes.dart';
import 'package:clashbot_flutter/models/clash_notification.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/models/lol_champion.dart';
import 'package:clashbot_flutter/pages/teams/team_expanded_page.dart';
import 'package:clashbot_flutter/pages/teams/team_page.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/clashbot_player.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:mobx/mobx.dart' as mobx;
import 'package:provider/provider.dart';

void main() {
  testGoldens('Clash Bot Team Expanded - Golden', (WidgetTester tester) async {
    await loadAppFonts();
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ])
      ..addScenario(
        name: 'Clash Card - Team Expanded',
        widget: Builder(builder: (context) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(body: TeamExpandedPage()),
            theme: ThemeData(
                brightness: Brightness.dark,
                colorScheme: darkColorScheme,
                useMaterial3: true,
                snackBarTheme: SnackBarThemeData(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
          );
        })
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'clash_bot_team_card_expanded_page');
  });
}
