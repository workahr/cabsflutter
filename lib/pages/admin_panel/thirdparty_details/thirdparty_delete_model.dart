// To parse this JSON data, do
//
//     final thirdpartyDeleteModel = thirdpartyDeleteModelFromJson(jsonString);

import 'dart:convert';

ThirdpartyDeleteModel thirdpartyDeleteModelFromJson(String str) =>
    ThirdpartyDeleteModel.fromJson(json.decode(str));

String thirdpartyDeleteModelToJson(ThirdpartyDeleteModel data) =>
    json.encode(data.toJson());

class ThirdpartyDeleteModel {
  String status;
  String code;
  String message;

  ThirdpartyDeleteModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory ThirdpartyDeleteModel.fromJson(Map<String, dynamic> json) =>
      ThirdpartyDeleteModel(
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
