import 'package:flutter/material.dart';

class WhoopsPage extends StatelessWidget {
  const WhoopsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whoops!'),
      ),
      body: const Center(
          child: Text(
        'Something went wrong and we were not able to load what we needed. Our bot is working tirelessly to resolve the issue! Please check back at a later time.',
      )),
    );
  }
}
