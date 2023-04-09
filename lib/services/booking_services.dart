import 'dart:convert';

import 'package:flutter_app/models/response/booking_response.dart';
import 'package:flutter_app/services/api.dart';
import 'package:http/http.dart' as http;

class BookingServices {
  static Future<bool> BookingFood(
    BookingModel resultData,
  ) async {
    final String url = host + "/api/booking";
    var result = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "average_calories": resultData.averageCalories,
          "date": resultData.date,
          "time_value": resultData.timeValue,
          "food_menu": resultData.foodMenu,
          "full_name": resultData.fullName,
          "person_number": resultData.personNumber,
          "table_number": resultData.tableNumber,
          "tel": resultData.tel,
          "total_price": resultData.totalPrice,
        },
      ),
    );
    return true;
  }
}
