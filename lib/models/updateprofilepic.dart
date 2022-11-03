import 'dart:convert';

Updatepic updatepicFromJson(String str) => Updatepic.fromJson(json.decode(str));

String updatepicToJson(Updatepic data) => json.encode(data.toJson());

class Updatepic {
  Updatepic({
    required this.name,
    required this.email,
    required this.followers,
    required this.following,
    required this.profilepicture,
  });

  String name;
  String email;
  List<dynamic> followers;
  List<dynamic> following;
  String profilepicture;

  factory Updatepic.fromJson(Map<String, dynamic> json) => Updatepic(
    name: json["name"],
    email: json["email"],
    followers: List<dynamic>.from(json["followers"].map((x) => x)),
    following: List<dynamic>.from(json["following"].map((x) => x)),
    profilepicture: json["profilepicture"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "followers": List<dynamic>.from(followers.map((x) => x)),
    "following": List<dynamic>.from(following.map((x) => x)),
    "profilepicture": profilepicture,
  };
}