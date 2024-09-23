// To parse this JSON data, do
//
//     final carEditModel = carEditModelFromJson(jsonString);

import 'dart:convert';

CarEditModel carEditModelFromJson(String str) =>
    CarEditModel.fromJson(json.decode(str));

String carEditModelToJson(CarEditModel data) => json.encode(data.toJson());

class CarEditModel {
  String status;
  CarDetails list;
  String code;
  String message;

  CarEditModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory CarEditModel.fromJson(Map<String, dynamic> json) => CarEditModel(
        status: json["status"],
        list: CarDetails.fromJson(json["list"]),
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

class CarDetails {
  int id;
  String brand;
  String modal;
  String fuelType;
  int seatCapacity;
  String vehicleNumber;
  String imageUrl;
  String status;
  String createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  CarDetails({
    required this.id,
    required this.brand,
    required this.modal,
    required this.fuelType,
    required this.seatCapacity,
    required this.vehicleNumber,
    required this.imageUrl,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory CarDetails.fromJson(Map<String, dynamic> json) => CarDetails(
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
      };
}
