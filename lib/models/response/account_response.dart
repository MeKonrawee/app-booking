import 'dart:convert';

import 'package:flutter/material.dart';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    @required this.sex,
    @required this.password,
    @required this.fullname,
    @required this.phonenumber,
    @required this.height,
    @required this.email,
    @required this.calories,
    @required this.weight,
    @required this.username,
    @required this.birthday,
    @required this.type,
  });

  String sex;
  String password;
  String fullname;
  String phonenumber;
  String height;
  String email;
  int calories;
  String weight;
  String username;
  DateTime birthday;
  String type;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        sex: json["sex"],
        password: json["password"],
        fullname: json["fullname"],
        phonenumber: json["phonenumber"],
        height: json["height"],
        email: json["email"],
        calories: json["calories"],
        weight: json["weight"],
        username: json["username"],
        birthday: DateTime.parse(json["Birthday"]),
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "sex": sex,
        "password": password,
        "fullname": fullname,
        "phonenumber": phonenumber,
        "height": height,
        "email": email,
        "calories": calories,
        "weight": weight,
        "username": username,
        "Birthday":
            "${birthday.year.toString().padLeft(4, '0')}-${birthday.month.toString().padLeft(2, '0')}-${birthday.day.toString().padLeft(2, '0')}",
        "type": type,
      };
}
