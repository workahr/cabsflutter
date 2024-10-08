// To parse this JSON data, do
//
//     final bookingListData = bookingListDataFromJson(jsonString);

import 'dart:convert';

BookingListData bookingListDataFromJson(String str) =>
    BookingListData.fromJson(json.decode(str));

String bookingListDataToJson(BookingListData data) =>
    json.encode(data.toJson());

class BookingListData {
  String status;
  List<BookingList> list;
  String code;
  String message;

  BookingListData({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory BookingListData.fromJson(Map<String, dynamic> json) =>
      BookingListData(
        status: json["status"],
        list: List<BookingList>.from(
            json["list"].map((x) => BookingList.fromJson(x))),
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

class BookingList {
  int id;
  String? brand;
  String? modal;
  String? fuelType;
  int? seatCapacity;
  String? vehicleNumber;
  String? imageUrl;
  int? status;
  int? createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;
  String? driverId;
  String? carId;
  String? customerId;
  String? bookingOtp;
  String bookingStatus;
  DateTime fromDatetime;
  DateTime toDatetime;
  String pickupLocation;
  String dropLocation;
  String? totalDistance;
  String? bookingCharges;
  String? cancelReason;

  BookingList({
    required this.id,
    this.brand,
    this.modal,
    this.fuelType,
    this.seatCapacity,
    this.vehicleNumber,
    this.imageUrl,
    this.status,
    this.createdBy,
    required this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.driverId,
    this.carId,
    this.customerId,
    this.bookingOtp,
    required this.bookingStatus,
    required this.fromDatetime,
    required this.toDatetime,
    required this.pickupLocation,
    required this.dropLocation,
    this.totalDistance,
    this.bookingCharges,
    this.cancelReason,
  });

  factory BookingList.fromJson(Map<String, dynamic> json) => BookingList(
        id: json["id"],
        brand: json["brand"],
        modal: json["modal"],
        fuelType: json["fuel_type"],
        seatCapacity: json["seat_capacity"],
        vehicleNumber: json["vehicle_number"],
        imageUrl: json["image_url"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brand": brand,
        "modal": modal,
        "fuel_type": fuelType,
        "seat_capacity": seatCapacity,
        "vehicle_number": vehicleNumber,
        "image_url": imageUrl,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
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
      };
}
