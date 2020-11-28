import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:streamdeck/utils/enums.dart';
import 'package:streamdeck/utils/layouts.dart';

class DeckScreen extends StatefulWidget {
  const DeckScreen({
    Key key,
    this.ip,
    this.port,
    @required this.socket,
  }) : super(key: key);

  final Socket socket;
  final String ip;
  final String port;

  @override
  _DeckScreenState createState() => _DeckScreenState();
}

class _DeckScreenState extends State<DeckScreen> {
  List<Map> loadedData;

  Socket socket;

  @override
  void initState() {
    super.initState();
    socket = widget.socket;
  }

  void dispose() {
    //socket.close();
    super.dispose();
  }

  List loadData() {
    List loadedDataTmp = List<Map>();
    loadedDataTmp.add({
      "test": "test",
      "test2": "test2",
      "test3": "test3",
    }); // List will be 1 indexed because of button ids being 1 indexed

    for (var i = 1; i <= 18; i++) {
      List<dynamic> data = Hive.box("prefs").get(i.toString());
      print(data);

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
        } else if (data[0].contains("toggleRecording")) {
          functionality = Functionality.toggleRecording;
        } else if (data[0].contains("toggleStream")) {
          functionality = Functionality.toggleStream;
        } else if (data[0].contains("pauseRecording")) {
          functionality = Functionality.pauseRecording;
        }

        if (functionality == Functionality.disconnect ||
            functionality == Functionality.toggleRecording ||
            functionality == Functionality.toggleStream ||
            functionality == Functionality.pauseRecording) {
          additionalData = "";
        } else {
          additionalData = data[1];
        }

        activated = data[2];
      }

      loadedDataTmp.add({
        "functionality": functionality,
        "additionalData": additionalData,
        "activated": activated,
      });
    }
    loadedData = loadedDataTmp;
    return loadedDataTmp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey[900],
          drawer: Drawer(
            child: Container(
              color: Colors.grey[900],
              child: ListView(
                children: [
                  DrawerHeader(
                      decoration: BoxDecoration(
                        color: Color(0xFF5E5CE6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Choose a Template",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                            ),
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Text(
                            "Warning:",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Switching templates will reset any changes you made to the buttons, like assinging a new functionality or assigning a different scene to switch to. ",
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      )),
                  ListTile(
                    title: Text(
                      "Default",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () async {
                      Hive.box("prefs").put("1", ["switchScene", "1", true]);
                      Hive.box("prefs").put("2", ["switchScene", "2", true]);
                      Hive.box("prefs").put("3", ["switchScene", "3", true]);
                      Hive.box("prefs").put("4", ["switchScene", "4", true]);
                      Hive.box("prefs").put("5", ["switchScene", "5", true]);
                      Hive.box("prefs").put("6", ["switchScene", "6", true]);
                      Hive.box("prefs").put("7", ["switchScene", "7", true]);
                      Hive.box("prefs").put("8", ["switchScene", "8", true]);
                      Hive.box("prefs").put("9", ["switchScene", "9", true]);
                      Hive.box("prefs")
                          .put("10", ["muteAudio", "Desktop Audio", true]);
                      Hive.box("prefs")
                          .put("11", ["muteAudio", "Mic/Aux", true]);
                      Hive.box("prefs")
                          .put("12", ["muteAudio", "Browser Source", true]);
                      Hive.box("prefs").put("13", ["toggleStream", "", true]);
                      Hive.box("prefs")
                          .put("14", ["toggleRecording", "", true]);
                      Hive.box("prefs").put("15", ["pauseRecording", "", true]);
                      Hive.box("prefs")
                          .put("16", ["hideSource", "Web Cam", true]);
                      Hive.box("prefs")
                          .put("17", ["hideSource", "Screen Capture", true]);
                      Hive.box("prefs").put("18", ["disconnect", "", true]);

                      Navigator.pop(context);
                      Navigator.pop(context);
                      if (widget.ip != null && widget.port != null) {
                        socket = await Socket.connect(
                            widget.ip, int.parse(widget.port));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeckScreen(
                              socket: socket,
                              ip: widget.ip,
                              port: widget.port,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                  Divider(
                    color: Colors.grey[500],
                    indent: 10,
                    endIndent: 10,
                  ),
                  ListTile(
                    title: Text(
                      "I am only switching scenes",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () async {
                      Hive.box("prefs").put("1", ["switchScene", "1", true]);
                      Hive.box("prefs").put("2", ["switchScene", "2", true]);
                      Hive.box("prefs").put("3", ["switchScene", "3", true]);
                      Hive.box("prefs").put("4", ["switchScene", "4", true]);
                      Hive.box("prefs").put("5", ["switchScene", "5", true]);
                      Hive.box("prefs").put("6", ["switchScene", "6", true]);
                      Hive.box("prefs").put("7", ["switchScene", "7", true]);
                      Hive.box("prefs").put("8", ["switchScene", "8", true]);
                      Hive.box("prefs").put("9", ["switchScene", "9", true]);
                      Hive.box("prefs").put("10", ["switchScene", "10", true]);
                      Hive.box("prefs").put("11", ["switchScene", "11", true]);
                      Hive.box("prefs").put("12", ["switchScene", "12", true]);
                      Hive.box("prefs").put("13", ["switchScene", "13", true]);
                      Hive.box("prefs").put("14", ["switchScene", "14", true]);
                      Hive.box("prefs").put("15", ["switchScene", "15", true]);
                      Hive.box("prefs").put("16", ["switchScene", "16", true]);
                      Hive.box("prefs").put("17", ["switchScene", "17", true]);
                      Hive.box("prefs").put("18", ["disconnect", "", true]);

                      Navigator.pop(context);
                      Navigator.pop(context);
                      if (widget.ip != null && widget.port != null) {
                        socket = await Socket.connect(
                            widget.ip, int.parse(widget.port));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeckScreen(
                              socket: socket,
                              ip: widget.ip,
                              port: widget.port,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
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
