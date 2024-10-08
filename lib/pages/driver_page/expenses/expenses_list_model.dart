// To parse this JSON data, do
//
//     final expensesListData = expensesListDataFromJson(jsonString);

import 'dart:convert';

ExpensesListData expensesListDataFromJson(String str) =>
    ExpensesListData.fromJson(json.decode(str));

String expensesListDataToJson(ExpensesListData data) =>
    json.encode(data.toJson());

class ExpensesListData {
  String status;
  List<ExpensesList> list;
  String code;
  String message;

  ExpensesListData({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory ExpensesListData.fromJson(Map<String, dynamic> json) =>
      ExpensesListData(
        status: json["status"],
        list: List<ExpensesList>.from(
            json["list"].map((x) => ExpensesList.fromJson(x))),
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "list": List<dynamic>.from(list.map((x) => x.toJson())),
        "code": code,
        "message": message,
      };
}

class ExpensesList {
  int id;
  int? bookingId;
  String reasons;
  int amount;
  int status;
  int createdBy;
  String createdDate;
  int? updatedBy;
  String? updatedDate;

  ExpensesList({
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

  factory ExpensesList.fromJson(Map<String, dynamic> json) => ExpensesList(
        id: json["id"],
        bookingId: json["booking_id"],
        reasons: json["reasons"],
        amount: json["amount"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: json["created_by"],
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "booking_id": bookingId,
        "reasons": reasons,
        "amount": amount,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate,
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
