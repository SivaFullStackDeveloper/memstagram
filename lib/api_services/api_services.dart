import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';

import '../models/login_model.dart';
import '../models/register_model.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/search_model.dart';
import '../models/updateprofilepic.dart';
import '../models/user.dart';
import '../models/user2.dart';

class ApiConfig{
  //var baseurl = "http://10.0.2.2:8000/";
  var baseurl = "http://54.157.21.45:8000/";
  final storage = FlutterSecureStorage();


  var headers =  {
    'Content-Type': 'application/json',
    'Access-Control-Allow-Origin': '*',
    //'Authorization': 'Bearer $token'
  };



}

Future register(var photourl,var username,var email,var password)async{
  var response = await http.post(
      Uri.parse('${ApiConfig().baseurl}register'),
      headers: ApiConfig().headers,
      body:jsonEncode({
        "profilepicture":'',
        "name":username,
        "email":email,
        "password":password,
      }));

  if(response.statusCode==200){
    var model = Register.fromJson(json.decode(response.body));
    print(response.statusCode.toString());
    return model;
  }else{
    var model = Register.fromJson(json.decode(response.body));
    return model;
  }
}

Future login(var username,var password)async{
  var response = await http.post(
      Uri.parse('${ApiConfig().baseurl}login'),
      headers: ApiConfig().headers,
      body:jsonEncode({

        "name":username,
        "password":password,
      }));

  if(response.statusCode==200){
    var model = Login.fromJson(json.decode(response.body));
    print(response.statusCode.toString());
    return model;
  }else{
    var model = Login.fromJson(json.decode(response.body));
    return model;
  }
  }

Future<Search> search(var searchletter)async {
final storage = await FlutterSecureStorage();

  var token = await storage.read(key: 'token');

  print('this is token $token');
  var response = await http.post(
      Uri.parse('${ApiConfig().baseurl}search/$searchletter'),
      headers:  {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'auth-token': '$token'
      },

      body: jsonEncode({
      }));

  if (response.statusCode == 200) {
    var model = Search.fromJson(json.decode(response.body));
    print(response.statusCode.toString() + "printing from search letter");
    return model;
  } else {
    var model = Search.fromJson(json.decode(response.body));
    return model;
  }
}


Future<User> user(var name)async {
  final storage = await FlutterSecureStorage();

  var token = await storage.read(key: 'token');

  print('this is token $token');
  var response = await http.post(
      Uri.parse('${ApiConfig().baseurl}get_profile'),
      headers:  {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'auth-token': '$token'
      },

      body: jsonEncode({
        "name":name
      }));

  if (response.statusCode == 200) {
    var model = User.fromJson(json.decode(response.body));
    print(response.statusCode.toString() + "printing from search letter");
    return model;
  } else {
    var model = User.fromJson(json.decode(response.body));
    return model;
  }
}


 Future<User2>edit(var name,var youtubelink,var instagramlink)async {
  final storage = await FlutterSecureStorage();

  var token = await storage.read(key: 'token');

  print('this is token $token');
  var response = await http.post(
      Uri.parse('${ApiConfig().baseurl}editprofile/$name'),
      headers:  {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'auth-token': '$token'
      },

      body: jsonEncode({
        "youtubelink":youtubelink,
        "instagramlink":instagramlink,

      }));

  if (response.statusCode == 200) {
    var model = User2.fromJson(json.decode(response.body));
    print(response.statusCode.toString() + "printing from search letter");
    return model;
  } else {
    var model = User2.fromJson(json.decode(response.body));
    return model;
  }
}

