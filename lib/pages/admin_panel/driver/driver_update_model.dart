// To parse this JSON data, do
//
//     final driverupdateModel = driverupdateModelFromJson(jsonString);

import 'dart:convert';

DriverupdateModel driverupdateModelFromJson(String str) =>
    DriverupdateModel.fromJson(json.decode(str));

String driverupdateModelToJson(DriverupdateModel data) =>
    json.encode(data.toJson());

class DriverupdateModel {
  String status;
  String code;
  String message;

  DriverupdateModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory DriverupdateModel.fromJson(Map<String, dynamic> json) =>
      DriverupdateModel(
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
