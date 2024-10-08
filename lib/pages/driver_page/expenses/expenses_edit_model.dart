// To parse this JSON data, do
//
//     final expenseseditModel = expenseseditModelFromJson(jsonString);

import 'dart:convert';

ExpenseseditModel expenseseditModelFromJson(String str) =>
    ExpenseseditModel.fromJson(json.decode(str));

String expenseseditModelToJson(ExpenseseditModel data) =>
    json.encode(data.toJson());

class ExpenseseditModel {
  String status;
  ExpensesEdit list;
  String code;
  String message;

  ExpenseseditModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory ExpenseseditModel.fromJson(Map<String, dynamic> json) =>
      ExpenseseditModel(
        status: json["status"],
        list: ExpensesEdit.fromJson(json["list"]),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": list.toJson(),
        "code": code,
        "message": message,
      };
}

class ExpensesEdit {
  int id;
  int? bookingId;
  String reasons;
  int amount;
  int status;
  int createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  ExpensesEdit({
    required this.id,
    this.bookingId,
    required this.reasons,
    required this.amount,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory ExpensesEdit.fromJson(Map<String, dynamic> json) => ExpensesEdit(
        id: json["id"],
        bookingId: json["booking_id"],
        reasons: json["reasons"],
        amount: json["amount"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "reasons": reasons,
        "amount": amount,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
      };
}
