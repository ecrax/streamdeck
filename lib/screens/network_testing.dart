import 'dart:io';

import 'package:flutter/material.dart';

class NetworkTesting extends StatefulWidget {
  NetworkTesting({this.socket, this.ipAddress});

  Socket socket;
  final String ipAddress;

  @override
  _NetworkTestingState createState() => _NetworkTestingState();
}

class _NetworkTestingState extends State<NetworkTesting> {
  Socket socket;

  String ip;
  String port;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text(widget.ipAddress),
                TextField(
                  decoration: InputDecoration(
                    hintText: "IP",
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    ip = value;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Port",
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    port = value;
                  },
                ),
                RaisedButton(
                  child: Text("Connect"),
                  onPressed: () async {
                    socket = await Socket.connect(ip, int.parse(port));
                  },
                ),
                RaisedButton(
                  child: Text("Disconnect"),
                  onPressed: () {
                    // stop server
                    socket.write("stop");
                    // close connection
                    socket.close();
                  },
                ),
                SizedBox(
                  height: 32,
                ),
                RaisedButton(
                  child: Text("1"),
                  onPressed: () {
                    if (socket != null) {
                      socket.write("scene0");
                    }
                  },
                ),
                RaisedButton(
                  child: Text("2"),
                  onPressed: () {
                    if (socket != null) {
                      socket.write("scene1");
                    }
                  },
                ),
                RaisedButton(
                  child: Text("3"),
                  onPressed: () {
                    if (socket != null) {
                      socket.write("scene2");
                    }
                  },
                ),
                RaisedButton(
                  child: Text("4"),
                  onPressed: () {
                    if (socket != null) {
                      socket.write("scene3");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
