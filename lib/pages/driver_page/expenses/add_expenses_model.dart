// To parse this JSON data, do
//
//     final expensesAddModel = expensesAddModelFromJson(jsonString);

import 'dart:convert';

ExpensesAddModel expensesAddModelFromJson(String str) =>
    ExpensesAddModel.fromJson(json.decode(str));

String expensesAddModelToJson(ExpensesAddModel data) =>
    json.encode(data.toJson());

class ExpensesAddModel {
  String status;
  String code;
  String message;

  ExpensesAddModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory ExpensesAddModel.fromJson(Map<String, dynamic> json) =>
      ExpensesAddModel(
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
