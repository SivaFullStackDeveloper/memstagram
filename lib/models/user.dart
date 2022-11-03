// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.name,
    required this.email,
    required this.youtubelink,
    required this.instagramlink,
    required this.followers,
    required this.following,
    required this.profilepicture,
  });

  String name;
  String email;
  String youtubelink;
  String instagramlink;
  List<dynamic> followers;
  List<dynamic> following;
  String profilepicture;

  factory User.fromJson(Map<String, dynamic> json) => User(
    name: json["name"],
    email: json["email"],
    youtubelink: json["youtubelink"]==null?"":json["youtubelink"],
    instagramlink: json["instagramlink"]==null?"":json["instagramlink"],
    followers: List<dynamic>.from(json["followers"].map((x) => x)),
    following: List<dynamic>.from(json["following"].map((x) => x)),
    profilepicture: json["profilepicture"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "youtubelink":youtubelink,
    "instagramlink":instagramlink,
    "followers": List<dynamic>.from(followers.map((x) => x)),
    "following": List<dynamic>.from(following.map((x) => x)),
    "profilepicture": profilepicture,
  };
}
