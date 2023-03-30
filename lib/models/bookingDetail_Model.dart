import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/response/booking_response.dart';

BookingDetailModel bookingDetailModelFromJson(String str) =>
    BookingDetailModel.fromJson(json.decode(str));

String bookingDetailModelToJson(BookingDetailModel data) =>
    json.encode(data.toJson());

class BookingDetailModel {
  BookingDetailModel({
    @required this.fullname,
    @required this.phone,
    @required this.tableName,
    @required this.people,
    @required this.dateBook,
    @required this.timeBook,
    @required this.foodList,
    @required this.totalAllPrice,
    @required this.cal,
    @required this.avgCal,
  });

  String fullname;
  String phone;
  String tableName;
  int people;
  String dateBook;
  String timeBook;
  List<FoodMenu> foodList;
  int totalAllPrice;
  int cal;
  double avgCal;

  factory BookingDetailModel.fromJson(Map<String, dynamic> json) =>
      BookingDetailModel(
        fullname: json["fullname"],
        phone: json["phone"],
        tableName: json["tableName"],
        people: json["people"],
        dateBook: json["dateBook"],
        timeBook: json["timeBook"],
        foodList: List<FoodMenu>.from(
            json["foodList"].map((x) => FoodMenu.fromJson(x))),
        totalAllPrice: json["totalAllPrice"],
        cal: json["cal"],
        avgCal: json["avg_cal"],
      );

  Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "phone": phone,
        "tableName": tableName,
        "people": people,
        "dateBook": dateBook,
        "timeBook": timeBook,
        "foodList": List<dynamic>.from(foodList.map((x) => x.toJson())),
        "totalAllPrice": totalAllPrice,
        "cal": cal,
        "avg_cal": avgCal,
      };
}

class FoodList {
  FoodList({
    @required this.foodname,
    @required this.quantity,
    @required this.totalPrice,
  });

  String foodname;
  int quantity;
  int totalPrice;

  factory FoodList.fromJson(Map<String, dynamic> json) => FoodList(
        foodname: json["Foodname"],
        quantity: json["quantity"],
        totalPrice: json["totalPrice"],
      );

  Map<String, dynamic> toJson() => {
        "Foodname": foodname,
        "quantity": quantity,
        "totalPrice": totalPrice,
      };
}
