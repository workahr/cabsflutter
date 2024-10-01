// To parse this JSON data, do
//
//     final mytripsListData = mytripsListDataFromJson(jsonString);

import 'dart:convert';

MytripsListData mytripsListDataFromJson(String str) =>
    MytripsListData.fromJson(json.decode(str));

String mytripsListDataToJson(MytripsListData data) =>
    json.encode(data.toJson());

class MytripsListData {
  String status;
  List<MyTrips> list;
  String code;
  String message;

  MytripsListData({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory MytripsListData.fromJson(Map<String, dynamic> json) =>
      MytripsListData(
        status: json["status"],
        list: List<MyTrips>.from(json["list"].map((x) => MyTrips.fromJson(x))),
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

class MyTrips {
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
  String? cancelReason;
  String status;
  int? createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  MyTrips({
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
    this.updatedBy,
    this.updatedDate,
  });

  factory MyTrips.fromJson(Map<String, dynamic> json) => MyTrips(
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
        bookingCharges:
            json["booking_charges"] == null ? "" : json["booking_charges"],
        cancelReason: json["cancel_reason"],
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
        "updated_date": updatedDate?.toIso8601String(),
      };
}
