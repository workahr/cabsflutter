// To parse this JSON data, do
//
//     final cancelAddModel = cancelAddModelFromJson(jsonString);

import 'dart:convert';

CancelAddModel cancelAddModelFromJson(String str) =>
    CancelAddModel.fromJson(json.decode(str));

String cancelAddModelToJson(CancelAddModel data) => json.encode(data.toJson());

class CancelAddModel {
  String status;
  String code;
  String message;

  CancelAddModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory CancelAddModel.fromJson(Map<String, dynamic> json) => CancelAddModel(
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
