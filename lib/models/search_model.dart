// To parse this JSON data, do
//
//     final search = searchFromJson(jsonString);

import 'dart:convert';

Search searchFromJson(String str) => Search.fromJson(json.decode(str));

String searchToJson(Search data) => json.encode(data.toJson());

class Search {
  Search({
    this.data,
  });

  List<Datum>? data;

  factory Search.fromJson(Map<String, dynamic> json) => Search(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.password,
    this.email,
    this.followers,
    this.following,
    this.date,
    this.v,
    this.profilepicture,
  });

  String? id;
  String? name;
  String? password;
  String ?email;
  List<dynamic>? followers;
  List<dynamic> ?following;
  DateTime ?date;
  int ?v;
  String ?profilepicture;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["_id"],
    name: json["name"],
    password: json["password"],
    email: json["email"],
    followers: List<dynamic>.from(json["followers"].map((x) => x)),
    following: List<dynamic>.from(json["following"].map((x) => x)),
    date: DateTime.parse(json["date"]),
    v: json["__v"],
    profilepicture: json["profilepicture"] == null ? null : json["profilepicture"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "password": password,
    "email": email,
    "followers": List<dynamic>.from(followers!.map((x) => x)),
    "following": List<dynamic>.from(following!.map((x) => x)),
    "date": date!.toIso8601String(),
    "__v": v,
    "profilepicture": profilepicture == null ? null : profilepicture,
  };
}
