import 'dart:convert';
import 'package:flutter_app/models/response/table_response.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class TablesService {
  static Future<List<TableResponse>> getTables() async {
    try {
      final String url = host + "/api/tables";
      var result = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // Parse the JSON response and return a list of MenusResponse objects
      List<TableResponse> tables = tableResponseFromJson(result.body);
      return tables;
    } catch (e) {
      return [];
    }
  }
}
