// To parse this JSON data, do
//
//     final expensesupdateModel = expensesupdateModelFromJson(jsonString);

import 'dart:convert';

ExpensesupdateModel expensesupdateModelFromJson(String str) =>
    ExpensesupdateModel.fromJson(json.decode(str));

String expensesupdateModelToJson(ExpensesupdateModel data) =>
    json.encode(data.toJson());

class ExpensesupdateModel {
  String status;
  String code;
  String message;

  ExpensesupdateModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory ExpensesupdateModel.fromJson(Map<String, dynamic> json) =>
      ExpensesupdateModel(
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
