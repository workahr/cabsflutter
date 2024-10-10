// To parse this JSON data, do
//
//     final bookingupdateModel = bookingupdateModelFromJson(jsonString);

import 'dart:convert';

BookingupdateModel bookingupdateModelFromJson(String str) =>
    BookingupdateModel.fromJson(json.decode(str));

String bookingupdateModelToJson(BookingupdateModel data) =>
    json.encode(data.toJson());

class BookingupdateModel {
  String status;
  String code;
  String message;

  BookingupdateModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory BookingupdateModel.fromJson(Map<String, dynamic> json) =>
      BookingupdateModel(
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
