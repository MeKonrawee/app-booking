// To parse this JSON data, do
//
//     final bookingModel = bookingModelFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/material.dart';

List<BookingModel> bookingModelFromJson(String str) => List<BookingModel>.from(
    json.decode(str).map((x) => BookingModel.fromJson(x)));

String bookingModelToJson(List<BookingModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingModel {
  BookingModel({
    @required this.id,
    @required this.foodMenu,
    @required this.fullName,
    @required this.personNumber,
    @required this.tableNumber,
    @required this.tel,
    @required this.date,
    @required this.totalPrice,
    @required this.averageCalories,
  });

  String id;
  List<FoodMenu> foodMenu;
  String fullName;
  String personNumber;
  String tableNumber;
  String tel;
  String date;
  double totalPrice;
  int averageCalories;

  factory BookingModel.fromJson(Map<String, dynamic> json) => BookingModel(
        id: json["id"],
        foodMenu: List<FoodMenu>.from(
            json["food_menu"].map((x) => FoodMenu.fromJson(x))),
        fullName: json["full_name"],
        personNumber: json["person_number"],
        tableNumber: json["table_number"],
        tel: json["tel"],
        date: json["date"],
        totalPrice: json["total_price"]?.toDouble(),
        averageCalories: json["average_calories"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "food_menu": List<dynamic>.from(foodMenu.map((x) => x.toJson())),
        "full_name": fullName,
        "person_number": personNumber,
        "table_number": tableNumber,
        "tel": tel,
        "date": date,
        "total_price": totalPrice,
        "average_calories": averageCalories,
      };
}

class FoodMenu {
  FoodMenu({
    @required this.name,
    @required this.price,
    @required this.cal,
    @required this.quantity,
  });

  String name;
  int price;
  int cal;
  int quantity;

  factory FoodMenu.fromJson(Map<String, dynamic> json) => FoodMenu(
        name: json["name"],
        price: json["price"],
        cal: json["cal"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "cal": cal,
        "quantity": quantity,
      };
}
