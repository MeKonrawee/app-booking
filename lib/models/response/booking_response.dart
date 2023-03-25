// To parse this JSON data, do
//
//     final menusResponse = menusResponseFromJson(jsonString);

import 'dart:convert';

List<BookingResponse> bookingResponseFromJson(String str) =>
    List<BookingResponse>.from(
        json.decode(str).map((x) => BookingResponse.fromJson(x)));

String bookingResponseToJson(List<BookingResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BookingResponse {
  BookingResponse(
      {this.id,
      this.food_menu,
      this.full_name,
      this.person_number,
      this.table_number,
      this.tel,
      this.date,
      this.quantity});

  String id;
  String food_menu;
  String full_name;
  String person_number;
  String table_number;
  String tel;
  String date;
  int quantity;

  factory BookingResponse.fromJson(Map<String, dynamic> json) =>
      BookingResponse(
        id: json["id"],
        food_menu: json["food_menu"],
        full_name: json["full_name"],
        person_number: json["person_number"],
        table_number: json["table_number"],
        tel: json["tel"],
        date: json["date"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "food_menu": food_menu,
        "full_name": full_name,
        "person_number": person_number,
        "table_number": table_number,
        "tel": tel,
        "date": date,
        "quantity": quantity,
      };
}
