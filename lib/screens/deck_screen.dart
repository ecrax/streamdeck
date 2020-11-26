import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:streamdeck/utils/enums.dart';
import 'package:streamdeck/utils/layouts.dart';

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
  List<Map> loadedData;

  @override
  void initState() {
    super.initState();
    //loadData();
  }

  void loadData() {
    loadedData = List<Map>();
    loadedData.add({
      "test": "test",
      "test2": "test2",
      "test3": "test3",
    }); // List will be 1 indexed because of button ids being 1 indexed

    for (var i = 1; i <= 18; i++) {
      List<dynamic> data = Hive.box("prefs").get(i.toString());

      Functionality functionality;
      String additionalData;
      bool activated;

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

        activated = data[2];
      }

      loadedData.add({
        "functionality": functionality,
        "additionalData": additionalData,
        "activated": activated,
      });
    }
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
            child: OrientationBuilder(
              // ignore: missing_return
              builder: (context, orientation) {
                if (orientation == Orientation.portrait) {
                  loadData();
                  return verticalLayout(loadedData, widget);
                } else if (orientation == Orientation.landscape) {
                  loadData();
                  return horizontalLayout(loadedData, widget);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
