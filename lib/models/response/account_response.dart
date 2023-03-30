import 'dart:convert';

import 'package:flutter/material.dart';

AccountModel accountModelFromJson(String str) =>
    AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
  AccountModel({
    @required this.weight,
    @required this.phonenumber,
    @required this.email,
    @required this.birthday,
    @required this.fullname,
    @required this.username,
    @required this.sex,
    @required this.bmr,
    @required this.height,
    @required this.bmi,
    @required this.password,
  });

  String weight;
  String phonenumber;
  String email;
  String birthday;
  String fullname;
  String username;
  String sex;
  String bmr;
  String height;
  String bmi;
  String password;

  factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        weight: json["weight"],
        phonenumber: json["phonenumber"],
        email: json["email"],
        birthday: json["Birthday"],
        fullname: json["fullname"],
        username: json["username"],
        sex: json["sex"],
        bmr: json["bmr"],
        height: json["height"],
        bmi: json["bmi"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "weight": weight,
        "phonenumber": phonenumber,
        "email": email,
        "Birthday": birthday,
        "fullname": fullname,
        "username": username,
        "sex": sex,
        "bmr": bmr,
        "height": height,
        "bmi": bmi,
        "password": password,
      };
}
