import 'dart:io';

import 'package:flutter/material.dart';
import 'package:streamdeck/widgets/deck_button.dart';
import 'package:streamdeck/utils/enums.dart';

class DeckScreen extends StatelessWidget {
  const DeckScreen({Key key, @required this.socket}) : super(key: key);

  final Socket socket;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/BG.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(16),
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
                        id: 1,
                        function: Functionality.switchScene,
                        socket: socket,
                        addData: "1",
                      ),
                      DeckButton(
                        id: 4,
                        function: Functionality.switchScene,
                        socket: socket,
                        addData: "4",
                      ),
                      DeckButton(
                        id: 7,
                        function: Functionality.switchScene,
                        socket: socket,
                        addData: "7",
                      ),
                      DeckButton(
                        id: 10,
                        function: Functionality.switchScene,
                        socket: socket,
                      ),
                      DeckButton(
                        id: 13,
                        function: Functionality.switchScene,
                        socket: socket,
                      ),
                      DeckButton(
                        id: 16,
                        function: Functionality.switchScene,
                        socket: socket,
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
                        id: 2,
                        function: Functionality.switchScene,
                        socket: socket,
                        addData: "2",
                      ),
                      DeckButton(
                        id: 5,
                        function: Functionality.switchScene,
                        socket: socket,
                        addData: "5",
                      ),
                      DeckButton(
                        id: 8,
                        function: Functionality.switchScene,
                        socket: socket,
                        addData: "8",
                      ),
                      DeckButton(
                        id: 11,
                        function: Functionality.switchScene,
                        socket: socket,
                      ),
                      DeckButton(
                        id: 14,
                        function: Functionality.switchScene,
                        socket: socket,
                      ),
                      DeckButton(
                        id: 17,
                        function: Functionality.switchScene,
                        socket: socket,
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
                        id: 3,
                        function: Functionality.switchScene,
                        socket: socket,
                        addData: "3",
                      ),
                      DeckButton(
                        id: 6,
                        function: Functionality.switchScene,
                        socket: socket,
                        addData: "6",
                      ),
                      DeckButton(
                        id: 9,
                        function: Functionality.switchScene,
                        socket: socket,
                        addData: "9",
                      ),
                      DeckButton(
                        id: 12,
                        function: Functionality.switchScene,
                        socket: socket,
                      ),
                      DeckButton(
                        id: 15,
                        function: Functionality.switchScene,
                        socket: socket,
                      ),
                      DeckButton(
                        id: 18,
                        function: Functionality.switchScene,
                        socket: socket,
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
