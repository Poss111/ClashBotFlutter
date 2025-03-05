import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/core/config/env.dart';
import 'package:clashbot_flutter/globals/color_schemes.dart';
import 'package:clashbot_flutter/models/model_first_time.dart';
import 'package:clashbot_flutter/pages/intro/welcome_page.dart';
import 'package:clashbot_flutter/pages/settings/settings_page.dart';
import 'package:clashbot_flutter/pages/teams/team_page.dart';
import 'package:clashbot_flutter/routes.dart';
import 'package:clashbot_flutter/services/clashbot_service.dart';
import 'package:clashbot_flutter/services/clashbot_service_impl.dart';
import 'package:clashbot_flutter/services/discord_service.dart';
import 'package:clashbot_flutter/services/discord_service_impl.dart';
import 'package:clashbot_flutter/services/riot_resources_service.dart';
import 'package:clashbot_flutter/services/riot_resources_service_impl.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/styles.dart';
import 'package:clashbot_flutter/utils/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;
import 'package:intl/intl.dart';
import 'package:validators/validators.dart';

import 'generated/git_info.dart';
import 'globals/global_settings.dart';
import 'models/model_theme.dart';
import 'pages/home/home.dart';
import 'services/clashbot_events_service.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: HOME_ROUTE,
    redirect: (context, state) {
      final model = context.read<ModelFirstTime>();
      if (!model.visited) {
        return GETTING_STARTED_ROUTE;
      }
      return null;
    },
    routes: <RouteBase>[
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return MainContainer(child: child);
          },
          routes: <RouteBase>[
            GoRoute(
              name: 'gettings-started',
              path: GETTING_STARTED_ROUTE,
              builder: (BuildContext context, GoRouterState state) {
                return const WelcomeDashboard();
              },
            ),
            GoRoute(
                name: 'home',
                path: HOME_ROUTE,
                builder: (BuildContext context, GoRouterState state) {
                  return const HomePage();
                }),
            GoRoute(
              name: 'teams',
              path: TEAMS_DASHBOARD_ROUTE,
              builder: (BuildContext context, GoRouterState state) {
                return const TeamPage();
              },
            ),
            GoRoute(
              name: 'settings',
              path: SETTINGS_ROUTE,
              builder: (BuildContext context, GoRouterState state) {
                return const SettingsPage();
              },
            ),
          ]),
    ],
    errorBuilder: (context, state) => Scaffold(
            body: Center(
          child: Column(
            children: const [
              Text('Page Not Found', style: headerStyle),
            ],
          ),
        )),
    debugLogDiagnostics: true);

void main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});
  final ModelFirstTime modelFirstTime = ModelFirstTime();
  final ModelTheme modelTheme = ModelTheme();

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AnimationController controller;
  var loaded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => widget.modelFirstTime),
          ChangeNotifierProvider(create: (context) => widget.modelTheme),
          Provider<DiscordService>(
              create: (_) => DiscordServiceImpl(setupOauth2Helper())),
          Provider<ApiClient>(
              create: (_) => ApiClient(basePath: Env.clashbotServiceUrl)),
          ProxyProvider<ApiClient, ClashBotService>(
              update: (_, apiClient, __) => ClashBotServiceImpl(
                  UserApi(apiClient),
                  TeamApi(apiClient),
                  ChampionsApi(apiClient),
                  SubscriptionApi(apiClient),
                  TentativeApi(apiClient),
                  TournamentApi(apiClient))),
          Provider<RiotResourcesService>(
              create: (_) => RiotResourceServiceImpl()),
          Provider<ClashBotEventsService>(
              create: (_) => ClashBotEventsService()),
          ProxyProvider4<DiscordService, ClashBotService, RiotResourcesService,
                  ClashBotEventsService, ApplicationDetailsStore>(
              update: (_, discordService, clashBotService, riotResourceService,
                      clashBotEventService, __) =>
                  ApplicationDetailsStore(discordService, clashBotService,
                      riotResourceService, clashBotEventService)),
        ],
        child: Consumer2<ApplicationDetailsStore, ModelFirstTime>(builder:
            (context, ApplicationDetailsStore appStore,
                ModelFirstTime modelFirstTime, child) {
          if (modelFirstTime.visited) {
            appStore.loadUserDetails();
          }
          return Observer(builder: (_) {
            return const MainApp();
          });
        }));
  }
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: darkColorScheme,
            useMaterial3: true,
            textTheme: const TextTheme(
                //   headlineLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
                //   titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
                //   bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
                ),
            snackBarTheme: SnackBarThemeData(
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            )),
        title: 'Clash Bot Test',
        themeMode: ThemeMode.dark,
        home: const TestWidget());
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('This is a display large',
                  style: Theme.of(context).textTheme.displayLarge),
              Text('This is a display medium',
                  style: Theme.of(context).textTheme.displayMedium),
              Text('This is a display small',
                  style: Theme.of(context).textTheme.displaySmall),
              Text('This is a headline large',
                  style: Theme.of(context).textTheme.headlineLarge),
              Text('This is a headline medium',
                  style: Theme.of(context).textTheme.headlineMedium),
              Text('This is a headline small',
                  style: Theme.of(context).textTheme.headlineSmall),
              Text('This is a title large',
                  style: Theme.of(context).textTheme.titleLarge),
              Text('This is a title medium',
                  style: Theme.of(context).textTheme.titleMedium),
              Text('This is a title small',
                  style: Theme.of(context).textTheme.titleSmall),
              Text('This is a label large',
                  style: Theme.of(context).textTheme.labelLarge),
              Text('This is a label medium',
                  style: Theme.of(context).textTheme.labelMedium),
              Text('This is a label small',
                  style: Theme.of(context).textTheme.labelSmall),
              Text('This is a body large',
                  style: Theme.of(context).textTheme.bodyLarge),
              Text('This is a body medium',
                  style: Theme.of(context).textTheme.bodyMedium),
              Text('This is a body small',
                  style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, themeNotifier, child) => MaterialApp.router(
            title: 'ClashBot',
            routerConfig: router,
            theme: ThemeData(
                brightness: Brightness.light,
                colorScheme: lightColorScheme,
                useMaterial3: true,
                snackBarTheme: SnackBarThemeData(
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                )),
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
            themeMode:
                themeNotifier.isDark ? ThemeMode.dark : ThemeMode.light));
  }
}

class MainContainer extends StatelessWidget {
  const MainContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    autorun((_) {
      if ('' != appStore.error) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.redAccent, content: Text(appStore.error)));
        appStore.error = '';
      }
      appStore.discordDetailsStore.discordIdToName.forEach((key, value) {
        developer.log("$key => $value");
      });
    });
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, consChild) {
      return Scaffold(
        appBar: AppBar(title: const Text('ClashBot 2.0'), actions: <Widget>[
          Observer(
              builder: (_) => Badge.count(
                    count: appStore.unreadNotifications.length,
                    alignment: AlignmentDirectional.bottomStart,
                    isLabelVisible: appStore.unreadNotifications.isNotEmpty,
                    child: const ClashBotNotificationsWidget(),
                  )),
          Column(
            mainAxisSize: MainAxisSize.min,
            // spacing: 1.0,
            children: [
              IconButton(
                icon: const Icon(Icons.code),
                tooltip: 'GitHub',
                onPressed: () {
                  // Add your GitHub link or functionality here
                },
              ),
              const Text(
                "${GitInfo.branchName} - ${GitInfo.commitHash}",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w100,
                ),
              )
            ],
          ),
          IconButton(
              icon: Icon(themeNotifier.isDark
                  ? Icons.nightlight_round
                  : Icons.wb_sunny),
              onPressed: () {
                themeNotifier.isDark
                    ? themeNotifier.isDark = false
                    : themeNotifier.isDark = true;
              }),
          Observer(builder: (_) {
            if (appStore.isLoggedIn) {
              return PopupMenuButton(
                  icon: CircleAvatar(
                          backgroundImage: NetworkImage(appStore
                              .discordDetailsStore.discordUser.avatarURL))
                      .animate()
                      .shake(duration: const Duration(seconds: 1)),
                  offset: const Offset(0, 50),
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        const PopupMenuItem<String>(
                          value: 'Settings',
                          child: ListTile(
                              leading: Icon(Icons.settings),
                              title: Text('Settings')),
                        ),
                      ],
                  onSelected: (value) {
                    GoRouter.of(context).go(SETTINGS_ROUTE);
                  });
            } else {
              return Container();
            }
          })
        ]),
        drawer: const ClashDrawer(),
        body: child,
      );
    });
  }
}

class ClashBotNotificationsWidget extends StatelessWidget {
  const ClashBotNotificationsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final appStore = context.read<ApplicationDetailsStore>();
    return Observer(builder: (_) {
      return PopupMenuButton(
        icon: const Icon(Icons.add_alert),
        tooltip: 'Notifications',
        position: PopupMenuPosition.under,
        itemBuilder: (BuildContext context) {
          return appStore.sortedNotifications.map((notification) {
            var discordGuild = appStore
                .discordDetailsStore.discordGuildMap[notification.serverId];
            return PopupMenuItem<String>(
                value: notification.uuid,
                enabled: !notification.read,
                padding: const EdgeInsets.all(2.0),
                child: ClashBotNotificationBody(
                  serverName: discordGuild?.name ?? '',
                  message: notification.message,
                  causedBy: notification.causedBy,
                  timestamp: notification.timestamp,
                  iconUrl: discordGuild?.iconURL ?? '',
                ));
          }).toList();
        },
        onSelected: (value) => appStore.readNotification(value),
      );
    });
  }
}

class ClashBotNotificationBody extends StatelessWidget {
  ClashBotNotificationBody({
    super.key,
    required this.serverName,
    this.timestamp,
    required this.message,
    required this.causedBy,
    required this.iconUrl,
  });

  final String serverName;
  DateTime? timestamp;
  final String message;
  final String causedBy;
  final String iconUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
          leading: CircleAvatar(
            foregroundImage: isNull(iconUrl) ? null : NetworkImage(iconUrl),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LabelTextLarge(message: serverName),
              LabelTextSmall(
                  message: DateFormat.yMd().add_jm().format(timestamp!)),
            ],
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message),
              LabelTextSmall(message: "Caused By: $causedBy")
            ],
          ),
        ),
      ),
    );
  }
}

class ClashDrawer extends StatelessWidget {
  const ClashDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ListTile(
            leading: const Icon(Icons.home),
            onTap: () {
              GoRouter.of(context).go(HOME_ROUTE);
            },
            title: const Text('Home'),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            onTap: () {
              GoRouter.of(context).go(TEAMS_DASHBOARD_ROUTE);
            },
            title: const Text('Teams'),
          ),
        ],
      ),
    );
  }
}

class DrawerHeaderContentWidget extends StatelessWidget {
  const DrawerHeaderContentWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final applicationDetailsStore = context.read<ApplicationDetailsStore>();
    return Column(
      children: [
        Observer(
          builder: (_) {
            if (applicationDetailsStore.isLoggedIn) {
              return Row(children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(applicationDetailsStore
                        .discordDetailsStore.discordUser.avatarURL),
                    radius: 20,
                  ),
                  title: Text(
                    applicationDetailsStore
                        .discordDetailsStore.discordUser.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                        leading: const Icon(Icons.discord),
                        title: Text(applicationDetailsStore.id,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ))),
                  ],
                ),
              ]);
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
