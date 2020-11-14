import 'package:flutter/material.dart';
import 'package:streamdeck/screens/deck_screen.dart';
import 'package:streamdeck/screens/network_testing.dart';
import 'package:web_socket_channel/io.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Stream Deck',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NetworkTesting() //DeckScreen(),

        );
  }
}
