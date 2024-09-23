// To parse this JSON data, do
//
//     final driverAddModel = driverAddModelFromJson(jsonString);

import 'dart:convert';

DriverAddModel driverAddModelFromJson(String str) =>
    DriverAddModel.fromJson(json.decode(str));

String driverAddModelToJson(DriverAddModel data) => json.encode(data.toJson());

class DriverAddModel {
  String status;
  String code;
  String message;

  DriverAddModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory DriverAddModel.fromJson(Map<String, dynamic> json) => DriverAddModel(
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
