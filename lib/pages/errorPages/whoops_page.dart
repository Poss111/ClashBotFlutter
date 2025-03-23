import 'package:flutter/material.dart';

class WhoopsPage extends StatelessWidget {
  const WhoopsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Whoops!'),
      ),
      body: Container(
        child: Column(
          children: [
            Flex(
              direction: Axis.vertical,
              children: [
                Center(
                  child: Text(
                    'Something went wrong and we were not able to load what we needed. Our bot is working tirelessly to resolve the issue!'
                  ),
                ),
                Center(
                  child: Text(
                          ' Please check back at a later time.',
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
