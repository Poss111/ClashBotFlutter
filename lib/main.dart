import 'package:clash_bot_api/api.dart';
import 'package:clashbot_flutter/core/config/env.dart';
import 'package:clashbot_flutter/globals/color_schemes.dart';
import 'package:clashbot_flutter/models/model_first_time.dart';
import 'package:clashbot_flutter/models/websocket_state.dart';
import 'package:clashbot_flutter/pages/errorPages/whoops_page.dart';
import 'package:clashbot_flutter/pages/home/page/home_v2.dart';
import 'package:clashbot_flutter/pages/intro/welcome_page.dart';
import 'package:clashbot_flutter/routes.dart';
import 'package:clashbot_flutter/services/clashbot_service.dart';
import 'package:clashbot_flutter/services/clashbot_service_impl.dart';
import 'package:clashbot_flutter/services/discord_service.dart';
import 'package:clashbot_flutter/services/discord_service_impl.dart';
import 'package:clashbot_flutter/services/riot_resources_service.dart';
import 'package:clashbot_flutter/services/riot_resources_service_impl.dart';
import 'package:clashbot_flutter/stores/application_details.store.dart';
import 'package:clashbot_flutter/stores/clash_events.store.dart';
import 'package:clashbot_flutter/stores/discord_details.store.dart';
import 'package:clashbot_flutter/stores/riot_champion.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/notification_handler.store.dart';
import 'package:clashbot_flutter/styles.dart';
import 'package:clashbot_flutter/utils/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:validators/validators.dart';

import 'generated/git_info.dart';
import 'globals/global_settings.dart';
import 'models/model_theme.dart';

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
                  return HomeV2();
                }),
            GoRoute(
                name: 'whoops',
                path: WHOOPS_ROUTE,
                builder: (BuildContext context, GoRouterState state) {
                  return const WhoopsPage();
                }),
          ]),
    ],
    errorBuilder: (context, state) => const Scaffold(
            body: Center(
          child: Column(
            children: [
              Text('Page Not Found', style: headerStyle),
            ],
          ),
        )),
    debugLogDiagnostics: false);

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
          Provider<NotificationHandlerStore>(
              create: (_) => NotificationHandlerStore()),
          Provider<DiscordService>(
              create: (_) => DiscordServiceImpl(setupOauth2Helper())),
          Provider<ApiClient>(
              create: (_) => ApiClient(basePath: Env.clashbotServiceUrl)),
          ProxyProvider2<ApiClient, NotificationHandlerStore, ClashBotService>(
              update: (_, apiClient, errorHandlerStore, __) =>
                  ClashBotServiceImpl(
                      UserApi(apiClient),
                      TeamApi(apiClient),
                      ChampionsApi(apiClient),
                      SubscriptionApi(apiClient),
                      TentativeApi(apiClient),
                      TournamentApi(apiClient),
                      errorHandlerStore)),
          Provider<RiotResourcesService>(
              create: (_) => RiotResourceServiceImpl()),
          ProxyProvider2<ClashBotService, NotificationHandlerStore, ClashStore>(
              update: (_, clashBotService, errorHandlerStore, __) =>
                  ClashStore(clashBotService, errorHandlerStore)),
          ProxyProvider2<ClashStore, NotificationHandlerStore,
                  ClashEventsStore>(
              update: (_, clashStore, errorHandlerStore, __) =>
                  ClashEventsStore(clashStore, errorHandlerStore)),
          ProxyProvider2<DiscordService, NotificationHandlerStore,
                  DiscordDetailsStore>(
              update: (_, discordService, errorHandlerStore, __) =>
                  DiscordDetailsStore(discordService, errorHandlerStore)),
          ProxyProvider2<RiotResourcesService, NotificationHandlerStore,
                  RiotChampionStore>(
              update: (_, riotResourceService, errorHandlerStore, __) =>
                  RiotChampionStore(riotResourceService, errorHandlerStore)),
          // Depends on ClashStore, DiscordDetailsStore, RiotChampionStore, ErrorHandlerStore
          ProxyProvider5<
                  ClashStore,
                  ClashEventsStore,
                  DiscordDetailsStore,
                  RiotChampionStore,
                  NotificationHandlerStore,
                  ApplicationDetailsStore>(
              update: (_, clashStore, clashEventsStore, discordDetailsStore,
                      riotChampionStore, errorHandlerStore, __) =>
                  ApplicationDetailsStore(
                      clashStore,
                      clashEventsStore,
                      discordDetailsStore,
                      riotChampionStore,
                      errorHandlerStore)),
        ],
        child: Consumer2<ApplicationDetailsStore, ModelFirstTime>(builder:
            (context, ApplicationDetailsStore appStore,
                ModelFirstTime modelFirstTime, child) {
          if (modelFirstTime.visited && !appStore.isLoggedIn) {
            appStore.refreshDiscordUser();
          }
          return const MainApp();
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
    ));
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

Color hexToColor(String hex) {
  hex = hex.replaceAll("#", "");
  if (hex.length == 6) {
    hex = "FF$hex"; // Add full opacity if not provided
  }
  return Color(int.parse(hex, radix: 16));
}

class MainContainer extends StatelessWidget {
  const MainContainer({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final discordDetailsStore = context.read<DiscordDetailsStore>();
    final errorStore = context.read<NotificationHandlerStore>();
    autorun((_) {
      if ('' != errorStore.notification.message) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: hexToColor(errorStore.notification.type.color),
            content: Text(errorStore.notification.message)));
        errorStore.notification.message = '';
      }
    });
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, consChild) {
      return Scaffold(
        appBar: AppBar(title: const Text('ClashBot 2.0'), actions: <Widget>[
          // Observer(
          //     builder: (_) => Badge.count(
          //           count: appStore.unreadNotifications.length,
          //           alignment: AlignmentDirectional.bottomStart,
          //           isLabelVisible: appStore.unreadNotifications.isNotEmpty,
          //           child: const ClashBotNotificationsWidget(),
          //         )),
          Column(
            mainAxisSize: MainAxisSize.min,
            // spacing: 1.0,
            children: [
              IconButton(
                icon: const Icon(Icons.code),
                tooltip: 'GitHub',
                onPressed: () async {
                  const url = 'https://github.com/Poss111/ClashBotFlutter';
                  if (await canLaunchUrl(Uri(path: url))) {
                    await launchUrl(Uri(path: url),
                        mode: LaunchMode.inAppBrowserView,
                        webOnlyWindowName: '_blank');
                  }
                },
              ),
              const Text(
                GitInfo.commitDetails,
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
            if (discordDetailsStore.userHasLoggedIn) {
              return PopupMenuButton(
                  icon: CircleAvatar(
                          backgroundImage: NetworkImage(
                              discordDetailsStore.discordUser.avatarURL))
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
                          enabled: false,
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
        body: child,
      );
    });
  }
}

// class ClashBotNotificationsWidget extends StatelessWidget {
//   const ClashBotNotificationsWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final discordDetailsStore = context.read<DiscordDetailsStore>();
//     return Observer(builder: (_) {
//       return PopupMenuButton(
//         icon: const Icon(Icons.add_alert),
//         tooltip: 'Notifications',
//         position: PopupMenuPosition.under,
//         itemBuilder: (BuildContext context) {
//           return appStore.sortedNotifications.map((notification) {
//             var discordGuild = appStore
//                 .discordDetailsStore.discordGuildMap[notification.serverId];
//             return PopupMenuItem<String>(
//                 value: notification.uuid,
//                 enabled: !notification.read,
//                 padding: const EdgeInsets.all(2.0),
//                 child: ClashBotNotificationBody(
//                   serverName: discordGuild?.name ?? '',
//                   message: notification.message,
//                   causedBy: notification.causedBy,
//                   timestamp: notification.timestamp,
//                   iconUrl: discordGuild?.iconURL ?? '',
//                 ));
//           }).toList();
//         },
//         onSelected: (value) => appStore.readNotification(value),
//       );
//     });
//   }
// }

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
    final discordDetailsStore = context.read<DiscordDetailsStore>();
    return Column(
      children: [
        Observer(
          builder: (_) {
            if (applicationDetailsStore.isLoggedIn) {
              return Row(children: [
                ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(discordDetailsStore.discordUser.avatarURL),
                    radius: 20,
                  ),
                  title: Text(
                    discordDetailsStore.discordUser.username,
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
                        title: Text(discordDetailsStore.discordUser.id,
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
