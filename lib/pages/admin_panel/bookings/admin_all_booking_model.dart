// To parse this JSON data, do
//
//     final allbookingListData = allbookingListDataFromJson(jsonString);

import 'dart:convert';

AllbookingListData allbookingListDataFromJson(String str) =>
    AllbookingListData.fromJson(json.decode(str));

String allbookingListDataToJson(AllbookingListData data) =>
    json.encode(data.toJson());

class AllbookingListData {
  String status;
  List<AllBookings> list;
  String code;
  String message;

  AllbookingListData({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory AllbookingListData.fromJson(Map<String, dynamic> json) =>
      AllbookingListData(
        status: json["status"],
        list: List<AllBookings>.from(
            json["list"].map((x) => AllBookings.fromJson(x))),
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

class AllBookings {
  int id;
  String? brand;
  String? modal;
  String? fuelType;
  int? seatCapacity;
  String? vehicleNumber;
  String? currentStatus;
  dynamic latitude;
  dynamic longitude;
  dynamic imageUrl;
  String status;
  int createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;
  String driverId;
  String carId;
  String customerId;
  dynamic bookingOtp;
  BookingStatus bookingStatus;
  DateTime fromDatetime;
  DateTime toDatetime;
  String pickupLocation;
  String dropLocation;
  dynamic totalDistance;
  dynamic bookingCharges;
  String? cancelReason;

  AllBookings({
    required this.id,
    required this.brand,
    required this.modal,
    required this.fuelType,
    required this.seatCapacity,
    required this.vehicleNumber,
    required this.currentStatus,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    this.updatedBy,
    this.updatedDate,
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
  });

  factory AllBookings.fromJson(Map<String, dynamic> json) => AllBookings(
        id: json["id"],
        brand: json["brand"],
        modal: json["modal"],
        fuelType: json["fuel_type"],
        seatCapacity: json["seat_capacity"],
        vehicleNumber: json["vehicle_number"],
        currentStatus: json["current_status"],
        latitude: json["latitude"],
        longitude: json["longitude"],
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
        bookingStatus: bookingStatusValues.map[json["booking_status"]]!,
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
        "current_status": currentStatus,
        "latitude": latitude,
        "longitude": longitude,
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
        "booking_status": bookingStatusValues.reverse[bookingStatus],
        "from_datetime": fromDatetime.toIso8601String(),
        "to_datetime": toDatetime.toIso8601String(),
        "pickup_location": pickupLocation,
        "drop_location": dropLocation,
        "total_distance": totalDistance,
        "booking_charges": bookingCharges,
        "cancel_reason": cancelReason,
      };
}

enum BookingStatus { COMPLETED, NEW }

final bookingStatusValues = EnumValues(
    {"COMPLETED": BookingStatus.COMPLETED, "NEW": BookingStatus.NEW});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
