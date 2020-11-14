import 'package:flutter/material.dart';
import 'package:streamdeck/widgets/deck_button.dart';

class DeckScreen extends StatelessWidget {
  const DeckScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DeckButton(
                        text: "1",
                      ),
                      DeckButton(
                        text: "4",
                      ),
                      DeckButton(
                        text: "7",
                      ),
                      DeckButton(
                        text: "10",
                      ),
                      DeckButton(
                        text: "13",
                      ),
                      DeckButton(
                        text: "16",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DeckButton(
                        text: "2",
                      ),
                      DeckButton(
                        text: "5",
                      ),
                      DeckButton(
                        text: "8",
                      ),
                      DeckButton(
                        text: "11",
                      ),
                      DeckButton(
                        text: "14",
                      ),
                      DeckButton(
                        text: "17",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DeckButton(
                        text: "3",
                      ),
                      DeckButton(
                        text: "6",
                      ),
                      DeckButton(
                        text: "9",
                      ),
                      DeckButton(
                        text: "12",
                      ),
                      DeckButton(
                        text: "15",
                      ),
                      DeckButton(
                        text: "18",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
