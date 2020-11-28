import 'dart:io';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:hive/hive.dart';
import 'package:streamdeck/utils/enums.dart';

class DeckButton extends StatefulWidget {
  DeckButton({
    @required this.id,
    @required this.socket,
    @required this.loadedData,
    this.onTap,
  });

  final int id;
  final Socket socket;

  final Function onTap;

  final List loadedData;

  @override
  _DeckButtonState createState() => _DeckButtonState();
}

class _DeckButtonState extends State<DeckButton> {
  dynamic currentFunction;
  dynamic additinalData;
  dynamic tempData;
  bool activated;

  ImageProvider currentImage;
  final Map<String, ImageProvider> images = {
    "mute": AssetImage("assets/images/Mute.png"),
    "unmute": AssetImage("assets/images/Sound.png"),
    "hide": AssetImage("assets/images/Hidden.png"),
    "unhide": AssetImage("assets/images/Visible.png"),
    "switchScene": AssetImage("assets/images/Switch Scenes.png"),
    "disconnect": AssetImage("assets/images/Disconnect.png"),
    "startRecording": AssetImage("assets/images/Start Recording.png"),
    "stopRecording": AssetImage("assets/images/Stop Recording.png"),
    "pauseRecording": AssetImage("assets/images/Pause Recording.png"),
    "resumeRecording": AssetImage("assets/images/Resume Recording.png"),
    "startStream": AssetImage("assets/images/Start Streaming.png"),
    "stopStream": AssetImage("assets/images/Stop Streaming.png"),
  };

  Socket socket;

  @override
  void initState() {
    super.initState();

    currentFunction = widget.loadedData[widget.id]["functionality"] ??
        Functionality.switchScene;
    additinalData =
        widget.loadedData[widget.id]["additionalData"] ?? widget.id.toString();

    if (widget.id == 18 &&
        widget.loadedData[widget.id]["functionality"] == null &&
        widget.loadedData[widget.id]["additionalData"] == null) {
      currentFunction = Functionality.disconnect;
      additinalData = "";
    }

    activated = widget.loadedData[widget.id]["activated"] ?? true;
    socket = widget.socket;

    _setImages();
  }

  void _setImages() {
    setState(() {
      if (currentFunction == Functionality.switchScene) {
        currentImage = images["switchScene"];
      } else if (currentFunction == Functionality.hideSource && !activated) {
        currentImage = images["hide"];
      } else if (currentFunction == Functionality.muteAudio && !activated) {
        currentImage = images["mute"];
      } else if (currentFunction == Functionality.muteAudio && activated) {
        currentImage = images["unmute"];
      } else if (currentFunction == Functionality.hideSource && activated) {
        currentImage = images["unhide"];
      } else if (currentFunction == Functionality.disconnect) {
        currentImage = images["disconnect"];
      } else if (currentFunction == Functionality.toggleRecording &&
          !activated) {
        currentImage = images["stopRecording"];
      } else if (currentFunction == Functionality.toggleRecording &&
          activated) {
        currentImage = images["startRecording"];
      } else if (currentFunction == Functionality.toggleStream && !activated) {
        currentImage = images["stopStream"];
      } else if (currentFunction == Functionality.toggleStream && activated) {
        currentImage = images["startStream"];
      } else if (currentFunction == Functionality.pauseRecording &&
          !activated) {
        currentImage = images["resumeRecording"];
      } else if (currentFunction == Functionality.pauseRecording && activated) {
        currentImage = images["pauseRecording"];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FocusedMenuHolder(
        animateMenuItems: false,
        menuWidth: MediaQuery.of(context).size.width * 0.50,
        duration: Duration(milliseconds: 75),
        menuItems: [
          FocusedMenuItem(
            title: Text("Mute Audio"),
            trailingIcon: Icon(Icons.volume_off),
            onPressed: () {
              setState(() {
                tempData = null;
                // Show prompt to choose additional Data (Name of mic)
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Enter name of the audio track"),
                      backgroundColor: Colors.white,
                      content: StatefulBuilder(
                        builder: (context, setState) {
                          return TextField(
                            onChanged: (value) {
                              setState(() {
                                tempData = value;
                              });
                            },
                          );
                        },
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            if (tempData != null) {
                              setState(() {
                                currentFunction = Functionality.muteAudio;
                                additinalData = tempData;
                                tempData = null;
                                _setImages();
                              });

                              Hive.box("prefs").put("${widget.id.toString()}", [
                                "muteAudio",
                                additinalData.toString(),
                                activated
                              ]);
                            } else {
                              // Warn user
                            }

                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                        FlatButton(
                          onPressed: () {
                            tempData = null;
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    );
                  },
                );
              });
            },
          ),
          FocusedMenuItem(
            title: Text("Switch Scene"),
            trailingIcon: Icon(Icons.switch_account),
            onPressed: () {
              setState(() {
                tempData = null;
                // Show prompt to choose additional Data (Index)
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Choose which scene to assign"),
                      backgroundColor: Colors.white,
                      content: StatefulBuilder(
                        builder: (context, setState) {
                          var items = new List<String>.generate(
                            18,
                            (i) => (i + 1).toString(),
                          );

                          return DropdownButton(
                            items: items.map<DropdownMenuItem<String>>(
                              (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              },
                            ).toList(),
                            onChanged: (value) {
                              setState(() {
                                tempData = value;
                              });
                            },
                            value: tempData ?? "1",
                          );
                        },
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              currentFunction = Functionality.switchScene;
                              additinalData = tempData ?? "1";
                              tempData = null;
                              _setImages();
                            });

                            Hive.box("prefs").put("${widget.id.toString()}", [
                              "switchScene",
                              additinalData.toString(),
                              activated
                            ]);

                            print(widget.id);
                            print(Hive.box("prefs").get(widget.id.toString()));

                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                        FlatButton(
                          onPressed: () {
                            tempData = null;
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    );
                  },
                );
              });
            },
          ),
          FocusedMenuItem(
            title: Text("Hide Source"),
            trailingIcon: Icon(Icons.visibility_off),
            onPressed: () {
              setState(() {
                tempData = null;
                // Show prompt to choose additional Data (Title)
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text("Enter title of source"),
                      backgroundColor: Colors.white,
                      content: StatefulBuilder(
                        builder: (context, setState) {
                          return TextField(
                            onChanged: (value) {
                              setState(() {
                                tempData = value;
                              });
                            },
                          );
                        },
                      ),
                      actions: [
                        FlatButton(
                          onPressed: () async {
                            if (tempData != null) {
                              setState(() {
                                currentFunction = Functionality.hideSource;
                                additinalData = tempData;
                                tempData = null;
                                _setImages();
                              });

                              Hive.box("prefs").put("${widget.id.toString()}", [
                                "hideSource",
                                additinalData.toString(),
                                activated
                              ]);
                            } else {
                              // Warn user
                            }

                            Navigator.pop(context);
                          },
                          child: Text("OK"),
                        ),
                        FlatButton(
                          onPressed: () {
                            tempData = null;
                            Navigator.pop(context);
                          },
                          child: Text("Cancel"),
                        ),
                      ],
                    );
                  },
                );
              });
            },
          ),
          FocusedMenuItem(
            title: Text("Toggle Stream"),
            trailingIcon: Icon(Icons.ac_unit),
            onPressed: () {
              setState(() {
                currentFunction = Functionality.toggleStream;
                additinalData = "";
                _setImages();
              });

              Hive.box("prefs").put(
                  "${widget.id.toString()}", ["toggleStream", "", activated]);
            },
          ),
          FocusedMenuItem(
            title: Text("Toggle Recording"),
            trailingIcon: Icon(Icons.ac_unit),
            onPressed: () {
              setState(() {
                currentFunction = Functionality.toggleRecording;
                additinalData = "";
                _setImages();
              });

              Hive.box("prefs").put(
                  "${widget.id.toString()}", ["startRecording", "", activated]);
            },
          ),
          FocusedMenuItem(
            title: Text("Pause Recording"),
            trailingIcon: Icon(Icons.ac_unit),
            onPressed: () {
              setState(() {
                currentFunction = Functionality.pauseRecording;
                additinalData = "";
                _setImages();
              });

              Hive.box("prefs").put(
                  "${widget.id.toString()}", ["pauseRecording", "", activated]);
            },
          ),
          FocusedMenuItem(
            title: Text("Disconnect"),
            trailingIcon: Icon(Icons.phonelink_off),
            onPressed: () {
              setState(() {
                currentFunction = Functionality.disconnect;
                additinalData = "";
                _setImages();
              });

              Hive.box("prefs").put(
                  "${widget.id.toString()}", ["disconnect", "", activated]);
            },
          ),
        ],
        onPressed: () {
          if (currentFunction == Functionality.muteAudio ||
              currentFunction == Functionality.hideSource ||
              currentFunction == Functionality.pauseRecording ||
              currentFunction == Functionality.toggleRecording ||
              currentFunction == Functionality.toggleStream) {
            setState(() {
              activated = !activated;
            });
            Hive.box("prefs").put("${widget.id.toString()}", [
              currentFunction.toString().replaceAll(r"Functionality.", ""),
              additinalData.toString(),
              activated
            ]);
          }

          // send: "s_hidetest" | "s_unhidetest"
          // send: "s_mutetest2" | "s_unmutetest2"
          // send: "scene1"

          if (currentFunction == Functionality.hideSource &&
              additinalData != null) {
            if (!activated) {
              socket.write("s_hide$additinalData");
            } else {
              socket.write("s_unhide$additinalData");
            }
          } else if (currentFunction == Functionality.muteAudio &&
              additinalData != null) {
            if (!activated) {
              socket.write("s_mute$additinalData");
            } else {
              socket.write("s_unmute$additinalData");
            }
          } else if (currentFunction == Functionality.switchScene &&
              additinalData != null) {
            socket.write("scene${(int.parse(additinalData) - 1).toString()}");
          } else if (currentFunction == Functionality.disconnect) {
            socket.close(); // Server is still online
            Navigator.pop(context);
          } else if (currentFunction == Functionality.pauseRecording) {
            socket.write("re_pause");
          } else if (currentFunction == Functionality.toggleStream) {
            if (!activated) {
              socket.write("st_start");
            } else {
              socket.write("st_stop");
            }
          } else if (currentFunction == Functionality.toggleRecording) {
            if (!activated) {
              socket.write("re_start");
            } else {
              socket.write("re_stop");
            }
          }

          _setImages();

          print("Functionality: $currentFunction");
          print("Additional Data: $additinalData");
          print("Id: ${widget.id}");
          print("Activated: $activated");
          print("\n");
        },
        child: Container(
          margin: EdgeInsets.all(7),
          decoration: BoxDecoration(
            //color: activated ? Colors.lightBlue : Colors.red,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: currentImage,
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /* Text(
                  widget.id.toString(),
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ), */
                Text(
                  additinalData.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 8,
                )
                /* Text(
                  currentFunction.toString().replaceAll(r"Functionality.", ""),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
