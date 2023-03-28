import 'dart:convert';

import 'package:flutter/material.dart';

List<TableResponse> tableResponseFromJson(String str) => List<TableResponse>.from(json.decode(str).map((x) => TableResponse.fromJson(x)));

String tableResponseToJson(List<TableResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TableResponse {
    TableResponse({
        @required this.id,
        @required this.number,
        @required this.status,
    });

    String id;
    String number;
    bool status;

    factory TableResponse.fromJson(Map<String, dynamic> json) => TableResponse(
        id: json["id"],
        number: json["number"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "number": number,
        "status": status,
    };
}
