import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:memz/constants.dart';

import '../screens/auth/login_screen.dart';

class Dilog {
  Future showMyDialog(BuildContext context, String msg) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Text(
              msg,
              style: TextStyle(color: Colors.black),
              maxLines: 2,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: buttonColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future showMyDialog2(BuildContext context, String msg) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            content: Text(
              msg,
              style: TextStyle(
                color: Colors.black,
              ),
              maxLines: 2,
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: buttonColor),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
              ),
            ],
          );
        });
  }
}
