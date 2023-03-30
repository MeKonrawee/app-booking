import 'dart:convert';
import 'package:flutter_app/models/response/account_response.dart';
import 'package:http/http.dart' as http;

import '../common/to_boolean.dart';
import 'api.dart';

class Accountservices {
  static Future<dynamic> signUp(
      String username,
      String email,
      String password,
      String sex,
      String fullname,
      String weight,
      String height,
      String birthDay,
      String phonenumber) async {
    final String url = host + "/api/register";
    await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, dynamic>{
          "username": username,
          "email": email,
          "password": password,
          "sex": sex,
          "fullname": fullname,
          "weight": weight,
          "height": height,
          "Birthday": birthDay,
          "phonenumber": phonenumber
        },
      ),
    );
    return true;
  }

  static Future<dynamic> signIn(
    String username,
    String password,
  ) async {
    try {
      final String url = host + "/api/login";
      var result = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, dynamic>{
            "username": username,
            "password": password,
          },
        ),
      );

      AccountModel resultAccount = accountModelFromJson(result.body);
      return resultAccount;
    } catch (e) {
      return false;
    }
  }
}
