// To parse this JSON data, do
//
//     final calculatebookingchargeModel = calculatebookingchargeModelFromJson(jsonString);

import 'dart:convert';

CalculatebookingchargeModel calculatebookingchargeModelFromJson(String str) =>
    CalculatebookingchargeModel.fromJson(json.decode(str));

String calculatebookingchargeModelToJson(CalculatebookingchargeModel data) =>
    json.encode(data.toJson());

class CalculatebookingchargeModel {
  String status;
  String code;
  int calculatedValue;
  String message;

  CalculatebookingchargeModel({
    required this.status,
    required this.code,
    required this.calculatedValue,
    required this.message,
  });

  factory CalculatebookingchargeModel.fromJson(Map<String, dynamic> json) =>
      CalculatebookingchargeModel(
        status: json["status"],
        code: json["code"],
        calculatedValue: json["calculated_value"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "calculated_value": calculatedValue,
        "message": message,
      };
}
