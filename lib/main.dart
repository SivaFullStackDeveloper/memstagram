import 'package:flutter/material.dart';
import 'package:memz/views/screens/auth/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:memz/views/screens/home_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = const FlutterSecureStorage();
  Widget? screen;
  var token;

  checktoken() async {
    token = await storage.read(key: 'token');
    if (token != null) {
      setState(() {
        screen = const HomeScreen();
      });
    } else {
      setState(() {
        screen = LoginScreen();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checktoken();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Memestagram',

      home: screen,
    );
  }
}
