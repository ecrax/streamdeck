import 'dart:io';

import 'package:flutter/material.dart';
import 'package:streamdeck/screens/deck_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class ConnectScreen extends StatefulWidget {
  @override
  _ConnectScreenState createState() => _ConnectScreenState();
}

class _ConnectScreenState extends State<ConnectScreen> {
  Socket socket;

  String ip;
  String port;

  @override
  void dispose() {
    socket.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Welcome back!",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 32,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Connect to the server",
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "IP Address:",
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          autofocus: false,
                          keyboardAppearance: Brightness.dark,
                          decoration: InputDecoration(
                            hintText: "e.g. 192.186.420.69",
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            ip = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[700],
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Port:",
                        style: TextStyle(
                          color: Colors.grey[300],
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: TextField(
                          autofocus: false,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "e.g. 6969",
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            port = value;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () async {
                      const url = 'https://github.com/ecrax/streamdeck';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                    child: Text(
                      "Need help?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(
                  height: 32,
                ),
                ButtonTheme(
                  minWidth: MediaQuery.of(context).size.width,
                  height: 50,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7)),
                    child: Text(
                      "Connect",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    color: Color(0xFF5E5CE6),
                    onPressed: () async {
                      if (ip != null && port != null) {
                        FocusScope.of(context).unfocus();
                        socket = await Socket.connect(ip, int.parse(port));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeckScreen(
                              socket: socket,
                              ip: ip,
                              port: port,
                            ),
                          ),
                        );
                      }
                    },
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
