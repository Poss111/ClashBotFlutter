import 'package:clashbot_flutter/pages/shimmer_loading_page.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/material.dart';
import 'package:markdown_widget/markdown_widget.dart';

class DisclaimerWidget extends StatelessWidget {
  const DisclaimerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                FutureBuilder(
                  future: DefaultAssetBundle.of(context)
                      .loadString('assets/markdown/privacy-policy.md'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return MarkdownBlock(data: snapshot.data ?? '');
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
                const SmallBreak(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Background color
                        foregroundColor: Colors.white, // Text color
                      ),
                      onPressed: () {
                        final Uri url = Uri.parse(
                            'https://www.google.com/search?q=sad+robot');
                        launchUrl(url);
                      },
                      child: const Text("Reject"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text("Approve"),
                    ),
                  ],
                ),
              ],
            ),
          ))),
    );
  }
}
