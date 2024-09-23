// To parse this JSON data, do
//
//     final carupdateModel = carupdateModelFromJson(jsonString);

import 'dart:convert';

CarupdateModel carupdateModelFromJson(String str) =>
    CarupdateModel.fromJson(json.decode(str));

String carupdateModelToJson(CarupdateModel data) => json.encode(data.toJson());

class CarupdateModel {
  String status;
  String code;
  String message;

  CarupdateModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory CarupdateModel.fromJson(Map<String, dynamic> json) => CarupdateModel(
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
