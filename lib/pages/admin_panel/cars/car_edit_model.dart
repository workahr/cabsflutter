// // To parse this JSON data, do
// //
// //     final carEditModel = carEditModelFromJson(jsonString);

// import 'dart:convert';

// CarEditModel carEditModelFromJson(String str) =>
//     CarEditModel.fromJson(json.decode(str));

// String carEditModelToJson(CarEditModel data) => json.encode(data.toJson());

// class CarEditModel {
//   String status;
//   CarDetails list;
//   String code;
//   String message;

//   CarEditModel({
//     required this.status,
//     required this.list,
//     required this.code,
//     required this.message,
//   });

//   factory CarEditModel.fromJson(Map<String, dynamic> json) => CarEditModel(
//         status: json["status"],
//         list: CarDetails.fromJson(json["list"]),
//         code: json["code"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "list": list.toJson(),
//         "code": code,
//         "message": message,
//       };
// }

// class CarDetails {
//   int id;
//   String rental;
//   int rentalId;
//   String brand;
//   String modal;
//   String fuelType;
//   int seatCapacity;
//   String vehicleNumber;
//   String currentStatus;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic imageUrl;
//   String status;
//   String createdBy;
//   DateTime createdDate;
//   int? updatedBy;
//   DateTime? updatedDate;

//   CarDetails({
//     required this.id,
//     required this.rental,
//     required this.rentalId,
//     required this.brand,
//     required this.modal,
//     required this.fuelType,
//     required this.seatCapacity,
//     required this.vehicleNumber,
//     required this.currentStatus,
//     required this.latitude,
//     required this.longitude,
//     required this.imageUrl,
//     required this.status,
//     required this.createdBy,
//     required this.createdDate,
//     this.updatedBy,
//     this.updatedDate,
//   });

//   factory CarDetails.fromJson(Map<String, dynamic> json) => CarDetails(
//         id: json["id"],
//         rental: json["rental"],
//         rentalId: json["rental_id"],
//         brand: json["brand"],
//         modal: json["modal"],
//         fuelType: json["fuel_type"],
//         seatCapacity: json["seat_capacity"],
//         vehicleNumber: json["vehicle_number"],
//         currentStatus: json["current_status"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         imageUrl: json["image_url"],
//         status: json["status"],
//         createdBy: json["created_by"],
//         createdDate: DateTime.parse(json["created_date"]),
//         updatedBy: json["updated_by"],
//         updatedDate: json["updated_date"] == null
//             ? null
//             : DateTime.parse(json["updated_date"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "rental": rental,
//         "rental_id": rentalId,
//         "brand": brand,
//         "modal": modal,
//         "fuel_type": fuelType,
//         "seat_capacity": seatCapacity,
//         "vehicle_number": vehicleNumber,
//         "current_status": currentStatus,
//         "latitude": latitude,
//         "longitude": longitude,
//         "image_url": imageUrl,
//         "status": status,
//         "created_by": createdBy,
//         "created_date": createdDate.toIso8601String(),
//         "updated_by": updatedBy,
//         "updated_date": updatedDate?.toIso8601String(),
//       };
// }

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
  String? rental;
  int? rentalId;
  String? brand;
  String? modal;
  String? fuelType;
  int seatCapacity;
  String vehicleNumber;
  String? imageUrl;
  String? perKmPrice;
  String? km_5_price;
  String? km_10_price;
  String? km_20_price;
  String? rc_number;
  String? insurance_number;
  String? join_charge;
  String? service_charge;
  int? status;
  int? createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  CarDetails({
    required this.id,
    this.rental,
    this.rentalId,
    required this.brand,
    required this.modal,
    required this.fuelType,
    required this.seatCapacity,
    required this.vehicleNumber,
    required this.imageUrl,
    this.perKmPrice,
    this.km_5_price,
    this.km_10_price,
    this.km_20_price,
    this.rc_number,
    this.insurance_number,
    this.join_charge,
    this.service_charge,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    this.updatedBy,
    this.updatedDate,
  });

  factory CarDetails.fromJson(Map<String, dynamic> json) => CarDetails(
        id: json["id"],
        rental: json["rental"],
        rentalId: json["rental_id"],
        brand: json["brand"],
        modal: json["modal"],
        fuelType: json["fuel_type"],
        seatCapacity: json["seat_capacity"],
        vehicleNumber: json["vehicle_number"],
        imageUrl: json["image_url"],
        perKmPrice: json["per_km_price"],
        km_5_price: json["km_5_price"],
        km_10_price: json["km_10_price"],
        km_20_price: json["km_20_price"],
        rc_number: json["rc_number"],
        insurance_number: json["insurance_number"],
        join_charge: json["join_charge"],
        service_charge: json["service_charge"],
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
        "rental": rental,
        "rental_id": rentalId,
        "brand": brand,
        "modal": modal,
        "fuel_type": fuelType,
        "seat_capacity": seatCapacity,
        "vehicle_number": vehicleNumber,
        "image_url": imageUrl,
        "per_km_price": perKmPrice,
        "km_5_price": km_5_price,
        "km_10_price": km_10_price,
        "km_20_price": km_20_price,
        "rc_number": rc_number,
        "insurance_number": insurance_number,
        "join_charge": join_charge,
        "service_charge": service_charge,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
      };
}
