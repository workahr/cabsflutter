// To parse this JSON data, do
//
//     final driverDeleteModel = driverDeleteModelFromJson(jsonString);

import 'dart:convert';

DriverDeleteModel driverDeleteModelFromJson(String str) =>
    DriverDeleteModel.fromJson(json.decode(str));

String driverDeleteModelToJson(DriverDeleteModel data) =>
    json.encode(data.toJson());

class DriverDeleteModel {
  String status;
  String code;
  String message;

  DriverDeleteModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory DriverDeleteModel.fromJson(Map<String, dynamic> json) =>
      DriverDeleteModel(
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
