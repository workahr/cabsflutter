// To parse this JSON data, do
//
//     final vehicalstatusaddModel = vehicalstatusaddModelFromJson(jsonString);

import 'dart:convert';

VehicalstatusaddModel vehicalstatusaddModelFromJson(String str) =>
    VehicalstatusaddModel.fromJson(json.decode(str));

String vehicalstatusaddModelToJson(VehicalstatusaddModel data) =>
    json.encode(data.toJson());

class VehicalstatusaddModel {
  String status;
  String code;
  String message;

  VehicalstatusaddModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory VehicalstatusaddModel.fromJson(Map<String, dynamic> json) =>
      VehicalstatusaddModel(
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
