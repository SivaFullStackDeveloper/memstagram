
import 'package:flutter/material.dart';
import 'package:memz/constants.dart';
import 'package:memz/constants.dart';
import 'package:memz/controllers/auth_controller.dart';
import 'package:memz/models/login_model.dart';
import 'package:memz/views/screens/auth/login_screen.dart';
import 'package:memz/views/screens/auth/signup_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:memz/views/screens/home_screen.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final storage = FlutterSecureStorage();
  Widget ?screen;
  var token ;
  checktoken() async {
     token =  await storage.read(key: 'token');
    if (token != null) {
      print(token.toString());
      setState(() {
        screen = HomeScreen();
      });
    } else {
      setState((){
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
      theme: ThemeData.dark().copyWith(
        //scaffoldBackgroundColor: Colors.white,
      ),
      home: screen,
    );
  }
}
