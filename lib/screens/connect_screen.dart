import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamdeck/screens/deck_screen.dart';

class ConnectScreen extends StatefulWidget {
  ConnectScreen(this.p);

  final SharedPreferences p;

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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("IP Address:"),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        ip = value;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Port:"),
                    TextField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        port = value;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              RaisedButton(
                child: Text(
                  "Connect",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                color: Colors.blue,
                onPressed: () async {
                  if (ip != null && port != null) {
                    socket = await Socket.connect(ip, int.parse(port));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeckScreen(
                          socket: socket,
                          prefs: widget.p,
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
    );
  }
}
