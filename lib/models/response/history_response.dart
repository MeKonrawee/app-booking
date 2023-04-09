import 'dart:convert';

import 'package:flutter/material.dart';

List<HistoryModel> historyModelFromJson(String str) => List<HistoryModel>.from(json.decode(str).map((x) => HistoryModel.fromJson(x)));

String historyModelToJson(List<HistoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HistoryModel {
    HistoryModel({
        @required this.id,
        @required this.foodMenu,
        @required this.fullName,
        @required this.personNumber,
        @required this.tableNumber,
        @required this.tel,
        @required this.date,
        @required this.timeValue,
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
    String timeValue;
    int totalPrice;
    int averageCalories;

    factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        id: json["id"],
        foodMenu: List<FoodMenu>.from(json["food_menu"].map((x) => FoodMenu.fromJson(x))),
        fullName: json["full_name"],
        personNumber: json["person_number"],
        tableNumber: json["table_number"],
        tel: json["tel"],
        date: json["date"],
        timeValue: json["time_value"],
        totalPrice: json["total_price"],
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
        "time_value": timeValue,
        "total_price": totalPrice,
        "average_calories": averageCalories,
    };
}

class FoodMenu {
    FoodMenu({
        @required this.name,
        @required this.quantity,
        @required this.price,
        @required this.cal,
    });

    String name;
    int quantity;
    int price;
    int cal;

    factory FoodMenu.fromJson(Map<String, dynamic> json) => FoodMenu(
        name: json["name"],
        quantity: json["quantity"],
        price: json["price"],
        cal: json["cal"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "quantity": quantity,
        "price": price,
        "cal": cal,
    };
}
