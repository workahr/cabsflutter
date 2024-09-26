// To parse this JSON data, do
//
//     final bookingAddModel = bookingAddModelFromJson(jsonString);

import 'dart:convert';

BookingAddModel bookingAddModelFromJson(String str) =>
    BookingAddModel.fromJson(json.decode(str));

String bookingAddModelToJson(BookingAddModel data) =>
    json.encode(data.toJson());

class BookingAddModel {
  String status;
  String code;
  String message;

  BookingAddModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory BookingAddModel.fromJson(Map<String, dynamic> json) =>
      BookingAddModel(
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
