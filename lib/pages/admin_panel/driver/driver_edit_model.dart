// To parse this JSON data, do
//
//     final driverEditModel = driverEditModelFromJson(jsonString);

import 'dart:convert';

DriverEditModel driverEditModelFromJson(String str) =>
    DriverEditModel.fromJson(json.decode(str));

String driverEditModelToJson(DriverEditModel data) =>
    json.encode(data.toJson());

class DriverEditModel {
  String status;
  DriverDetails list;
  String code;
  String message;

  DriverEditModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory DriverEditModel.fromJson(Map<String, dynamic> json) =>
      DriverEditModel(
        status: json["status"],
        list: DriverDetails.fromJson(json["list"]),
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

class DriverDetails {
  int id;
  int userId;
  int vehicleId;
  String licenseNumber;
  DateTime licenseExpiry;
  String address;
  int status;
  int createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;
  String username;
  String password;
  String fullname;
  String email;
  String mobile;
  int role;
  String? regOtp;
  int active;

  DriverDetails({
    required this.id,
    required this.userId,
    required this.vehicleId,
    required this.licenseNumber,
    required this.licenseExpiry,
    required this.address,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    this.updatedBy,
    this.updatedDate,
    required this.username,
    required this.password,
    required this.fullname,
    required this.email,
    required this.mobile,
    required this.role,
    this.regOtp,
    required this.active,
  });

  factory DriverDetails.fromJson(Map<String, dynamic> json) => DriverDetails(
        id: json["id"],
        userId: json["user_id"],
        vehicleId: json["vehicle_id"],
        licenseNumber: json["license_number"],
        licenseExpiry: DateTime.parse(json["license_expiry"]),
        address: json["address"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
        username: json["username"],
        password: json["password"],
        fullname: json["fullname"],
        email: json["email"],
        mobile: json["mobile"],
        role: json["role"],
        regOtp: json["reg_otp"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "vehicle_id": vehicleId,
        "license_number": licenseNumber,
        "license_expiry":
            "${licenseExpiry.year.toString().padLeft(4, '0')}-${licenseExpiry.month.toString().padLeft(2, '0')}-${licenseExpiry.day.toString().padLeft(2, '0')}",
        "address": address,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
        "username": username,
        "password": password,
        "fullname": fullname,
        "email": email,
        "mobile": mobile,
        "role": role,
        "reg_otp": regOtp,
        "active": active,
      };
}
