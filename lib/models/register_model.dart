import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    this.message,
    this.registred,
  });

  String ?message;
  bool? registred;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
    message: json["message"],
    registred: json["registred"],
  );

  Map<String, dynamic> toJson() => {
    "message": message,
    "registred": registred,
  };
}