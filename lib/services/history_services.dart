import 'package:flutter_app/models/response/history_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/services/api.dart';

class HistoryService {
  static Future<List<HistoryModel>> getMenu(String id) async {
    try {
      final String url = host + "/api/history/${id}";
      var result = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      List<HistoryModel> menus = historyModelFromJson(result.body);
      return menus;
    } catch (e) {
      return [];
    }
  }
}
