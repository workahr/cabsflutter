// To parse this JSON data, do
//
//     final expensesDeleteModel = expensesDeleteModelFromJson(jsonString);

import 'dart:convert';

ExpensesDeleteModel expensesDeleteModelFromJson(String str) =>
    ExpensesDeleteModel.fromJson(json.decode(str));

String expensesDeleteModelToJson(ExpensesDeleteModel data) =>
    json.encode(data.toJson());

class ExpensesDeleteModel {
  String status;
  String code;
  String message;

  ExpensesDeleteModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory ExpensesDeleteModel.fromJson(Map<String, dynamic> json) =>
      ExpensesDeleteModel(
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
