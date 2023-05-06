import 'package:clashbot_flutter/pages/intro/welcome_page.dart';
import 'package:flutter/material.dart';

const headerStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 40);

const subHeaderStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontSize: 30,
);
const subGroupStyle = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

class MainContainer extends StatefulWidget {
  const MainContainer({super.key});

  @override
  State<MainContainer> createState() => _MainContainer();
}

class _MainContainer extends State<MainContainer> {
  var index = 0;

  @override
  Widget build(BuildContext context) {
    var mainContentWidth = 500.0;
    var margin = 15.0;
    return Scaffold(
      appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: const Text('ClashBot 2.0'),
          leading: const Text(
            'v 2.0.0',
            style: TextStyle(
              fontWeight: FontWeight.w100,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert),
              tooltip: 'Show Snackbar',
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('This is a snackbar')));
              },
            ),
          ]),
      body: WelcomeDashboard()
    );
  }
}
