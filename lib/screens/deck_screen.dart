import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:streamdeck/widgets/deck_button.dart';
import 'package:streamdeck/utils/enums.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({
    Key key,
    @required this.socket,
  }) : super(key: key);

  final Socket socket;

  @override
  _DeckScreenState createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  @override
  void initState() {
    super.initState();
  }

  Map<String, dynamic> loadData(int id) {
    List<String> data = Hive.box("prefs").get(id.toString());

    // print(data);

    Functionality functionality;
    String additionalData;

    if (data != null) {
      if (data[0].contains("muteAudio")) {
        functionality = Functionality.muteAudio;
      } else if (data[0].contains("switchScene")) {
        functionality = Functionality.switchScene;
      } else if (data[0].contains("hideSource")) {
        functionality = Functionality.hideSource;
      } else if (data[0].contains("disconnect")) {
        functionality = Functionality.disconnect;
      }

      if (functionality == Functionality.disconnect) {
        additionalData = "";
      } else {
        additionalData = data[1];
      }
    }

    return {
      "functionality": functionality,
      "additionalData": additionalData,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              /* image: DecorationImage(
                image: AssetImage("assets/images/BG.jpg"),
                fit: BoxFit.cover,
              ), */
              color: Colors.grey[900],
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
                        function: loadData(1)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(1)["additionalData"] ?? "1",
                      ),
                      DeckButton(
                        id: 4,
                        function: loadData(4)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(4)["additionalData"] ?? "4",
                      ),
                      DeckButton(
                        id: 7,
                        function: loadData(7)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(7)["additionalData"] ?? "7",
                      ),
                      DeckButton(
                        id: 10,
                        function: loadData(10)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(10)["additionalData"] ?? "10",
                      ),
                      DeckButton(
                        id: 13,
                        function: loadData(13)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(13)["additionalData"] ?? "13",
                      ),
                      DeckButton(
                        id: 16,
                        function: loadData(16)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(16)["additionalData"] ?? "16",
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
                        function: loadData(2)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(2)["additionalData"] ?? "2",
                      ),
                      DeckButton(
                        id: 5,
                        function: loadData(5)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(5)["additionalData"] ?? "5",
                      ),
                      DeckButton(
                        id: 8,
                        function: loadData(8)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(8)["additionalData"] ?? "8",
                      ),
                      DeckButton(
                        id: 11,
                        function: loadData(11)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(11)["additionalData"] ?? "11",
                      ),
                      DeckButton(
                        id: 14,
                        function: loadData(14)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(14)["additionalData"] ?? "14",
                      ),
                      DeckButton(
                        id: 17,
                        function: loadData(17)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(17)["additionalData"] ?? "17",
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
                        function: loadData(3)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(3)["additionalData"] ?? "3",
                      ),
                      DeckButton(
                        id: 6,
                        function: loadData(6)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(6)["additionalData"] ?? "6",
                      ),
                      DeckButton(
                        id: 9,
                        function: loadData(9)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(9)["additionalData"] ?? "9",
                      ),
                      DeckButton(
                        id: 12,
                        function: loadData(12)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(12)["additionalData"] ?? "12",
                      ),
                      DeckButton(
                        id: 15,
                        function: loadData(15)["functionality"] ??
                            Functionality.switchScene,
                        socket: widget.socket,
                        addData: loadData(15)["additionalData"] ?? "15",
                      ),
                      DeckButton(
                        id: 18,
                        function: Functionality.disconnect,
                        socket: widget.socket,
                        addData: "",
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
