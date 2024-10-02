// To parse this JSON data, do
//
//     final thirdpartyEditModel = thirdpartyEditModelFromJson(jsonString);

import 'dart:convert';

ThirdpartyEditModel thirdpartyEditModelFromJson(String str) =>
    ThirdpartyEditModel.fromJson(json.decode(str));

String thirdpartyEditModelToJson(ThirdpartyEditModel data) =>
    json.encode(data.toJson());

class ThirdpartyEditModel {
  String status;
  ThirdpartyDetails list;
  String code;
  String message;

  ThirdpartyEditModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory ThirdpartyEditModel.fromJson(Map<String, dynamic> json) =>
      ThirdpartyEditModel(
        status: json["status"],
        list: ThirdpartyDetails.fromJson(json["list"]),
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

class ThirdpartyDetails {
  int id;
  String ownerName;
  String ownerMobile;
  String ownerAddress;
  int status;
  int createdBy;
  DateTime createdDate;
  dynamic updatedBy;
  dynamic updatedDate;

  ThirdpartyDetails({
    required this.id,
    required this.ownerName,
    required this.ownerMobile,
    required this.ownerAddress,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    required this.updatedDate,
  });

  factory ThirdpartyDetails.fromJson(Map<String, dynamic> json) =>
      ThirdpartyDetails(
        id: json["id"],
        ownerName: json["owner_name"],
        ownerMobile: json["owner_mobile"],
        ownerAddress: json["owner_address"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "owner_name": ownerName,
        "owner_mobile": ownerMobile,
        "owner_address": ownerAddress,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate,
      };
}
