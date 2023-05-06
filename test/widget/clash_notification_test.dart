import 'package:clashbot_flutter/globals/color_schemes.dart';
import 'package:clashbot_flutter/main.dart';
import 'package:clashbot_flutter/models/clash_notification.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'clash_notification_test.mocks.dart';

@GenerateMocks([ApplicationDetailsStore, DiscordDetailsStore])
void main() {
  testGoldens('Clash Bot Notifications - Golden', (WidgetTester tester) async {
    final mockAppStore = MockApplicationDetailsStore();
    final mockDetailsStore = MockDiscordDetailsStore();
    when(mockDetailsStore.discordGuildMap)
      .thenReturn(Map.of({"serverId": DiscordGuild("serverId", "Goon Squad", "", false)}));
    when(mockAppStore.discordDetailsStore)
      .thenReturn(mockDetailsStore);
    await loadAppFonts();
    final builder = GoldenBuilder.column()
      ..addScenario(
          'Simple',
          SizedBox(
            width: 500,
            height: 500,
            child: MaterialApp(
              themeMode: ThemeMode.dark,
              debugShowCheckedModeBanner: false,
              darkTheme: ThemeData(
                  brightness: Brightness.dark,
                  colorScheme: darkColorScheme,
                  useMaterial3: true,
                  snackBarTheme: SnackBarThemeData(
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )),
              home: const Scaffold(
                body: ClashBotNotificationsWidget(),
              ),
            ),
          ));
    await tester.pumpWidgetBuilder(Builder(
      builder: (context) {
        when(mockAppStore.sortedNotifications)
          .thenAnswer((_) => [
            ClashNotification("uuid", false, "Has created a Team New Team", "Roidrage", "serverId", DateTime.now()),
            ClashNotification("uuid", true, "message", "Some one", "serverId", DateTime.now()),
            ClashNotification("uuid", false, "message", "Shiragaku", "serverId", DateTime.now())
          ]);
        return MultiProvider(
          providers: [
            Provider<ApplicationDetailsStore>(create: (_) => mockAppStore), 
          ],
          child: builder.build());
      }
    ));
    await tester.tap(find.byType(Icon));
    await screenMatchesGolden(tester, 'clash_bot_notification');
  });
}
