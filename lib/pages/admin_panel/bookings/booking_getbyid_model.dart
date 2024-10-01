// To parse this JSON data, do
//
//     final bookingGetByIdModel = bookingGetByIdModelFromJson(jsonString);

import 'dart:convert';

BookingGetByIdModel bookingGetByIdModelFromJson(String str) =>
    BookingGetByIdModel.fromJson(json.decode(str));

String bookingGetByIdModelToJson(BookingGetByIdModel data) =>
    json.encode(data.toJson());

class BookingGetByIdModel {
  String status;
  BookingsDetails list;
  String code;
  String message;

  BookingGetByIdModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory BookingGetByIdModel.fromJson(Map<String, dynamic> json) =>
      BookingGetByIdModel(
        status: json["status"],
        list: BookingsDetails.fromJson(json["list"]),
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

class BookingsDetails {
  int id;
  String driverId;
  String carId;
  String customerId;
  dynamic bookingOtp;
  String bookingStatus;
  DateTime fromDatetime;
  DateTime toDatetime;
  String pickupLocation;
  String dropLocation;
  dynamic totalDistance;
  dynamic bookingCharges;
  dynamic cancelReason;
  String status;
  int createdBy;
  DateTime createdDate;
  dynamic updatedBy;
  dynamic updatedDate;

  BookingsDetails({
    required this.id,
    required this.driverId,
    required this.carId,
    required this.customerId,
    required this.bookingOtp,
    required this.bookingStatus,
    required this.fromDatetime,
    required this.toDatetime,
    required this.pickupLocation,
    required this.dropLocation,
    required this.totalDistance,
    required this.bookingCharges,
    required this.cancelReason,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory BookingsDetails.fromJson(Map<String, dynamic> json) =>
      BookingsDetails(
        id: json["id"],
        driverId: json["driver_id"],
        carId: json["car_id"],
        customerId: json["customer_id"],
        bookingOtp: json["booking_otp"],
        bookingStatus: json["booking_status"],
        fromDatetime: DateTime.parse(json["from_datetime"]),
        toDatetime: DateTime.parse(json["to_datetime"]),
        pickupLocation: json["pickup_location"],
        dropLocation: json["drop_location"],
        totalDistance: json["total_distance"],
        bookingCharges: json["booking_charges"],
        cancelReason: json["cancel_reason"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "driver_id": driverId,
        "car_id": carId,
        "customer_id": customerId,
        "booking_otp": bookingOtp,
        "booking_status": bookingStatus,
        "from_datetime": fromDatetime.toIso8601String(),
        "to_datetime": toDatetime.toIso8601String(),
        "pickup_location": pickupLocation,
        "drop_location": dropLocation,
        "total_distance": totalDistance,
        "booking_charges": bookingCharges,
        "cancel_reason": cancelReason,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
