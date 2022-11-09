import 'dart:convert';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.message,
    this.login,
    this.token,
  });

  String ? message;
  String ?token;
  bool? login;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
    message: json["message"],
    login: json["login"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "login": login,
    "token": token,
  };
}