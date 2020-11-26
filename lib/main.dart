import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:streamdeck/screens/connect_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('prefs');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream Deck',
      theme: ThemeData(
        brightness: Brightness.light,
        accentColor: Color(0xFF5E5CE6),
      ),
      home: ConnectScreen(),
    );
  }
}
