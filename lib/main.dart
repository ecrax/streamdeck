import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streamdeck/screens/connect_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs));
}

class MyApp extends StatelessWidget {
  MyApp(this.p);

  final SharedPreferences p;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Deck',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ConnectScreen(p),
    );
  }
}
