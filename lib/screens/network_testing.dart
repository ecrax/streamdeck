import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class NetworkTesting extends StatefulWidget {
  @override
  _NetworkTestingState createState() => _NetworkTestingState();
}

class _NetworkTestingState extends State<NetworkTesting> {
  final channel = IOWebSocketChannel.connect('ws://echo.websocket.org');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
        ),
        body: Center(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
