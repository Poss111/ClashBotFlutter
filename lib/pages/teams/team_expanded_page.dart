import 'package:clashbot_flutter/utils/reusable_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TeamExpandedPage extends StatelessWidget {
  const TeamExpandedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DisplayTextMedium(message: 'Team Name'),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HeadlineTextSmall(message: 'Top: Player 1'),
                        Row(children: [
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget()
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        HeadlineTextSmall(message: 'Jungle: Player 2'),
                        Row(children: [
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget()
                          ]),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        HeadlineTextSmall(message: 'Mid: Player 3'),
                        Row(children: [
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget()
                          ]),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        HeadlineTextSmall(message: 'Bot: Player 4'),
                        Row(children: [
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget()
                          ]),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        HeadlineTextSmall(message: 'Suppprt: Player 5'),
                        Row(children: [
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget(),
                            ChampionExpandedWidget()
                          ]),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChampionExpandedWidget extends StatelessWidget {
  const ChampionExpandedWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
      children: [
        TitleTextMedium(message: 'Champion 1'),
        Container(
          decoration: BoxDecoration(color: Colors.orange),
          child: SizedBox(width: 75, height: 100),
        )
      ],
    ));
  }
}
