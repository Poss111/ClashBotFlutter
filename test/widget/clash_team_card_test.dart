import 'dart:io';

import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/globals/color_schemes.dart';
import 'package:clashbot_flutter/models/clash_notification.dart';
import 'package:clashbot_flutter/models/clash_team.dart';
import 'package:clashbot_flutter/models/discord_guild.dart';
import 'package:clashbot_flutter/models/discord_user.dart';
import 'package:clashbot_flutter/models/lol_champion.dart';
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

import 'clash_team_card_test.mocks.dart';

@GenerateMocks([
  ApplicationDetailsStore, 
  DiscordDetailsStore, 
  ClashPlayerStore, 
  RiotChampionStore
])
void main() {
  testGoldens('Clash Bot Team Card - Golden', (WidgetTester tester) async {
    final mockAppStore = MockApplicationDetailsStore();
    final mockDetailsStore = MockDiscordDetailsStore();
    final mockClashPlayerStore = MockClashPlayerStore();
    final mockRiotChampionStore = MockRiotChampionStore();
    when(mockAppStore.id).thenReturn("1234");
    when(mockClashPlayerStore.callInProgress).thenReturn(false);
    when(mockDetailsStore.discordGuildMap).thenReturn(Map.of(
        {"serverId": DiscordGuild("serverId", "Goon Squad", "", false)}));
    when(mockDetailsStore.discordIdToName)
        .thenReturn(mobx.ObservableMap.of(Map.of({"1234": "My Name"})));
    when(mockDetailsStore.discordUser)
        .thenReturn(DiscordUser("1234", "My Name", "", ""));
    when(mockRiotChampionStore.lChampionsData)
      .thenReturn(LoLChampionsData(data: Map.of(
        {
          'Anivia': const LoLChampion(key: ''),
          'Ahri': const LoLChampion(key: '')
        }
      )));
    when(mockAppStore.discordDetailsStore).thenReturn(mockDetailsStore);
    when(mockAppStore.loggedInClashUser).thenReturn(mockClashPlayerStore);
    when(mockAppStore.riotChampionStore).thenReturn(mockRiotChampionStore);
    await loadAppFonts();
    var mapWithTopOnly = Map.of({
      Role.TOP: PlayerDetails("1234", "Some Player", ["Anivia", "Ahri"])
    });
    var mapWithJgOnly = Map.of({
      Role.JG: PlayerDetails("1234", "Some Player", ["Anivia", "Ahri"])
    });

    var mapWithMidOnly = Map.of({
      Role.MID: PlayerDetails("1234", "Some Player", ["Anivia", "Ahri"])
    });

    var mapWithBotOnly = Map.of({
      Role.BOT: PlayerDetails("1234", "Some Player", ["Anivia", "Ahri"])
    });

    var mapWithSuppOnly = Map.of({
      Role.SUPP: PlayerDetails("1234", "Some Player", ["Anivia", "Ahri"])
    });

    var mapWithAllRoles = Map.of({
      Role.TOP: PlayerDetails("1234", "Some Player", ["Anivia", "Ahri"]),
      Role.MID: PlayerDetails("1234", "Some Player", ["Anivia", "Ahri"]),
      Role.JG: PlayerDetails("1234", "Some Player", ["Anivia", "Ahri"]),
      Role.BOT: PlayerDetails("1234", "Some Player", ["Anivia", "Ahri"]),
      Role.SUPP: PlayerDetails("1234", "Some Player", ["Anivia", "Ahri"]),
    });
    final clashTeam2 = ClashTeam(
        "123",
        "Some Team",
        "awesome_sauce",
        "1",
        mapWithTopOnly,
        "123",
        DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true));
    final clashTeamJungle = ClashTeam(
        "123",
        "Some Team",
        "awesome_sauce",
        "1",
        mapWithJgOnly,
        "123",
        DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true));
    final clashTeamMid = ClashTeam(
        "123",
        "Some Team",
        "awesome_sauce",
        "1",
        mapWithMidOnly,
        "123",
        DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true));
    final clashTeamBot = ClashTeam(
        "123",
        "Some Team",
        "awesome_sauce",
        "1",
        mapWithBotOnly,
        "123",
        DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true));
    final clashTeamSupp = ClashTeam(
        "123",
        "Some Team",
        "awesome_sauce",
        "1",
        mapWithSuppOnly,
        "123",
        DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true));
    final allRolesTaken = ClashTeam(
        "123",
        "Some Team",
        "awesome_sauce",
        "1",
        mapWithAllRoles,
        "123",
        DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true));
    final builder = GoldenBuilder.grid(
        columns: 6, widthToHeightRatio: 1, bgColor: Colors.grey)
      ..addScenario(
        'Clash Card - Only Top Role Taken',
        ClashCard(clashTeam: clashTeam2),
      )
      ..addScenario(
        'Clash Card - Only Jungle Role Taken',
        ClashCard(clashTeam: clashTeamJungle),
      )
      ..addScenario(
        'Clash Card - Only Mid Role Taken',
        ClashCard(clashTeam: clashTeamMid),
      )
      ..addScenario(
        'Clash Card - Only Bottem Role Taken',
        ClashCard(clashTeam: clashTeamBot),
      )
      ..addScenario(
        'Clash Card - Only Support Role Taken',
        ClashCard(clashTeam: clashTeamSupp),
      )
      ..addScenario(
        'Clash Card - All Roles Taken',
        ClashCard(clashTeam: allRolesTaken),
      );
    await tester.pumpWidgetBuilder(Builder(builder: (context) {
      return MultiProvider(providers: [
        Provider<ApplicationDetailsStore>(create: (_) => mockAppStore),
      ], child: builder.build());
    }),
        surfaceSize: const Size(5000, 1500),
        wrapper: materialAppWrapper(
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
        ));
    await screenMatchesGolden(
      tester,
      'clash_bot_team_card',
    );
  });

  testGoldens('Clash Bot Team Card - Champions List - Golden', (tester) async {
    final mockAppStore = MockApplicationDetailsStore();
    final mockDetailsStore = MockDiscordDetailsStore();
    final mockClashPlayerStore = MockClashPlayerStore();
    final mockRiotChampionStore = MockRiotChampionStore();
    when(mockAppStore.id).thenReturn("1234");
    when(mockClashPlayerStore.callInProgress).thenReturn(false);
    when(mockDetailsStore.discordGuildMap).thenReturn(Map.of(
        {"serverId": DiscordGuild("serverId", "Goon Squad", "", false)}));
    when(mockDetailsStore.discordIdToName)
        .thenReturn(mobx.ObservableMap.of(Map.of({"1234": "My Name"})));
    when(mockDetailsStore.discordUser)
        .thenReturn(DiscordUser("1234", "My Name", "", ""));
    when(mockRiotChampionStore.lChampionsData)
      .thenReturn(LoLChampionsData(data: Map.of(
        {
          'Anivia': const LoLChampion(key: ''),
          'Ahri': const LoLChampion(key: '')
        })
      ));
    when(mockAppStore.discordDetailsStore).thenReturn(mockDetailsStore);
    when(mockAppStore.loggedInClashUser).thenReturn(mockClashPlayerStore);
    when(mockAppStore.riotChampionStore).thenReturn(mockRiotChampionStore);
    await loadAppFonts();
    var mapWithTopOnly = Map.of({
      Role.TOP: PlayerDetails("1234", "Some Player", ["Anivia", "Ahri"])
    });
    final clashTeam2 = ClashTeam(
        "123",
        "Some Team",
        "awesome_sauce",
        "1",
        mapWithTopOnly,
        "123",
        DateTime.fromMicrosecondsSinceEpoch(0, isUtc: true));
    final builder = DeviceBuilder()
      ..overrideDevicesForAllScenarios(devices: [
        Device.phone,
        Device.iphone11,
        Device.tabletPortrait,
        Device.tabletLandscape,
      ])
      ..addScenario(
        name: 'Clash Card - Champion List Open',
        widget: Builder(builder: (context) {
          return MultiProvider(
              providers: [
                Provider<ApplicationDetailsStore>(create: (_) => mockAppStore),
              ],
              child: MaterialApp(
                debugShowCheckedModeBanner: false,
                home: Scaffold(body: Center(
                  child: Wrap(children: [
                    ClashCard(clashTeam: clashTeam2)
                  ]),
                )),
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
              ));
        }),
        onCreate: (scenarioWidgetKey) async {
          final finder = find.descendant(
              of: find.byKey(scenarioWidgetKey),
              matching: find.byType(ExpansionTile));
          expect(finder, findsOneWidget);
          await tester.tap(finder);
        },
      );

    await tester.pumpDeviceBuilder(builder);

    await screenMatchesGolden(tester, 'clash_bot_team_card_champion_list');
  });
}
