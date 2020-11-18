import 'dart:io';

import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:streamdeck/utils/enums.dart';

class DeckButton extends StatefulWidget {
  DeckButton({
    @required this.id,
    @required this.socket,
    this.onTap,
    @required this.function,
    this.addData = "1",
    this.acticated = true,
  });

  final int id;
  final Socket socket;

  final Function onTap;

  final dynamic function;
  final dynamic addData;
  final bool acticated; // acticated = on

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
  };

  Socket socket;

  @override
  void initState() {
    super.initState();
    currentFunction = widget.function;
    additinalData = widget.addData;
    activated = widget.acticated;
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
                          onPressed: () {
                            if (tempData != null) {
                              setState(() {
                                currentFunction = Functionality.hideSource;
                                additinalData = tempData;
                                tempData = null;
                                _setImages();
                              });
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
        ],
        onPressed: () {
          if (currentFunction != Functionality.switchScene) {
            setState(() {
              activated = !activated;
            });
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
            borderRadius: BorderRadius.circular(8),
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
