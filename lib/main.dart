import 'package:flutter/material.dart';
import 'package:get_ip/get_ip.dart';
import 'package:streamdeck/screens/connect_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String ipAddress = await GetIp.ipAddress;
  runApp(MyApp(ipAddress));
}

class MyApp extends StatelessWidget {
  MyApp(this.ipAddress);
  final String ipAddress;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Stream Deck',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ConnectScreen() //NetworkTesting(ipAddress: ipAddress,) ,

        );
  }
}
