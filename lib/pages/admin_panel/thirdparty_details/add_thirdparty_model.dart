// To parse this JSON data, do
//
//     final thirdpartyAddmodel = thirdpartyAddmodelFromJson(jsonString);

import 'dart:convert';

ThirdpartyAddmodel thirdpartyAddmodelFromJson(String str) =>
    ThirdpartyAddmodel.fromJson(json.decode(str));

String thirdpartyAddmodelToJson(ThirdpartyAddmodel data) =>
    json.encode(data.toJson());

class ThirdpartyAddmodel {
  String status;
  String code;
  String message;

  ThirdpartyAddmodel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory ThirdpartyAddmodel.fromJson(Map<String, dynamic> json) =>
      ThirdpartyAddmodel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
