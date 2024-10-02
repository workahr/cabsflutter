// To parse this JSON data, do
//
//     final thirdpartyupdateModel = thirdpartyupdateModelFromJson(jsonString);

import 'dart:convert';

ThirdpartyupdateModel thirdpartyupdateModelFromJson(String str) =>
    ThirdpartyupdateModel.fromJson(json.decode(str));

String thirdpartyupdateModelToJson(ThirdpartyupdateModel data) =>
    json.encode(data.toJson());

class ThirdpartyupdateModel {
  String status;
  String code;
  String message;

  ThirdpartyupdateModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory ThirdpartyupdateModel.fromJson(Map<String, dynamic> json) =>
      ThirdpartyupdateModel(
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
