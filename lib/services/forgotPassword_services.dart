import 'dart:convert';
import 'package:flutter_app/models/response/account_response.dart';
import 'package:http/http.dart' as http;

import '../common/to_boolean.dart';
import 'api.dart';

class ForgotPasswordservices {
  static Future<dynamic> sendOTP(
    String email,
  ) async {
    final String url = host + "/api/send/email/${email}";
    var result = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(result.body);
    return result.body;
  }

  static Future<dynamic> changePassword(
    String email,
    String password,
  ) async {
    final String url = host + "/api/forget/${email}/${password}";
    var result = await http.get(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return result.body;
  }
}
