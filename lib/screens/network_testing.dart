import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class NetworkTesting extends StatefulWidget {
  NetworkTesting({this.socket});

  Socket socket;

  @override
  _NetworkTestingState createState() => _NetworkTestingState();
}

class _NetworkTestingState extends State<NetworkTesting> {
  Socket socket;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (socket != null) {
              socket.write("scene2");
            }
          },
        ),
        body: Center(
          child: Column(
            children: [
              RaisedButton(
                child: Text("Connect"),
                onPressed: () async {
                  socket = await Socket.connect('172.20.0.1', 6971);
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
            ],
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
