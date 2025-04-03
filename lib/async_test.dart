import 'package:clashbot_flutter/core/config/env.dart';
import 'package:clashbot_flutter/globals/color_schemes.dart';
import 'package:clashbot_flutter/main.dart';
import 'package:clashbot_flutter/models/websocket_state.dart';
import 'package:clashbot_flutter/stores/clash_events.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/clash.store.dart';
import 'package:clashbot_flutter/stores/v2-stores/notification_handler.store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

void main() async {
  runApp(const MyAppEventsTest());
}

class MyAppEventsTest extends StatefulWidget {
  const MyAppEventsTest({super.key});

  @override
  State<MyAppEventsTest> createState() => _MyAppEventsTestState();
}

class _MyAppEventsTestState extends State<MyAppEventsTest> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NotificationHandlerStore>(
            create: (_) => NotificationHandlerStore()),
        ProxyProvider2<ClashStore, NotificationHandlerStore, ClashEventsStore>(
            update: (_, clashStore, notificationHandlerStore, __) =>
                ClashEventsStore(clashStore, notificationHandlerStore))
      ],
      child: MaterialApp(
        title: 'Clash Bot Test',
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
        home: Scaffold(body: const AsyncTestWidget()),
      ),
    );
  }
}

class AsyncTestWidget extends StatelessWidget {
  const AsyncTestWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    ClashEventsStore clashEventStore = context.read<ClashEventsStore>();
    return Observer(builder: (_) {
      var button;

      switch (clashEventStore.status) {
        case WebSocketState.connecting:
          button = const FilledButton(
            onPressed: null,
            child: Text('Connecting...'),
          );
          break;
        case WebSocketState.open:
          button = const FilledButton(
            onPressed: null,
            child: Text('Connected'),
          );
          break;
        case WebSocketState.closed:
          button = FilledButton(
            onPressed: () {
              clashEventStore.connect(Env.clashbotEventUrl);
            },
            child: const Text('Connect?'),
          );
          break;
        case WebSocketState.error:
          button = FilledButton(
            onPressed: () {
              clashEventStore.connect(Env.clashbotEventUrl);
            },
            child: const Text('Error Connecting'),
          );
          break;
        default:
          button = const FilledButton(
            onPressed: null,
            child: Text('Unknown State'),
          );
      }

      final errorStore = context.read<NotificationHandlerStore>();
      autorun((_) {
        if ('' != errorStore.notification.message) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: hexToColor(errorStore.notification.type.color),
              content: Text(errorStore.notification.message)));
          errorStore.notification.message = '';
        }
      });

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            button,
            const SizedBox(
              width: 20,
            ),
            const Text('Last Message Received:'),
            const SizedBox(
              width: 20,
            ),
            Text(clashEventStore.lastMessageReceived.toString()),
            const SizedBox(
              width: 20,
            ),
            const Text('Clash Bot Test'),
            Column(
              children: [
                SizedBox(
                  height: 400,
                  width: 400,
                  child: ListView.builder(
                      itemCount: clashEventStore.events.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              ListTile(
                                  title: Text(clashEventStore.events[index]
                                      .toString())),
                              const Divider(
                                height: 5,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        );
                      }),
                ),
                SizedBox(
                  height: 400,
                  width: 400,
                  child: ListView.builder(
                      itemCount: clashEventStore.teams.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding: const EdgeInsets.all(5),
                          child: Column(
                            children: [
                              ListTile(
                                title: Text(clashEventStore.teams[index].name),
                                subtitle: Text(clashEventStore.teams[index].id),
                              ),
                              const Divider(
                                height: 5,
                                color: Colors.black,
                              ),
                              ...clashEventStore.teams[index].members.entries
                                  .map((entry) {
                                return ListTile(
                                  title: Text(entry.key.toString()),
                                  trailing: Text(entry.value?.id ?? 'Unknown'),
                                );
                              }).toList(),
                            ],
                          ),
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
