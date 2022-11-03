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
  AddVideoScreen(),
  Text('Messages Screen'),
  ProfileScreen(),
  //UploadImageScreen(),
];

// COLORS
var backgroundColor = Colors.black;
var buttonColor = Colors.red[400];
const borderColor = Colors.grey;
