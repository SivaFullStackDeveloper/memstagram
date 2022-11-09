import 'package:flutter/material.dart';
import 'package:memz/controllers/auth_controller.dart';
import 'package:memz/views/screens/add_video_screen.dart';
import 'package:memz/views/screens/demo_image.dart';
import 'package:memz/views/screens/profile_screen.dart';
import 'package:memz/views/screens/search_screen.dart';
import 'package:memz/views/screens/video_screen.dart';

List pages = [

  VideoScreen(),
  SearchScreen(),
 const AddVideoScreen(),
 const  Center(child: Text('Messages Screen')),
   ProfileScreen(),
  //UploadImageScreen(),
];

// COLORS
var backgroundColor = Color(0xffF5646B);
var buttonColor =Color(0xffff4a00);
//logomakr.com/app/98VVca
//ff4a00
//ffc7618
const borderColor = Colors.grey;
