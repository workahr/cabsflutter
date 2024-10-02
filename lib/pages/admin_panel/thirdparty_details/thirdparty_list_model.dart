// To parse this JSON data, do
//
//     final thirdpartyListData = thirdpartyListDataFromJson(jsonString);

import 'dart:convert';

ThirdpartyListData thirdpartyListDataFromJson(String str) =>
    ThirdpartyListData.fromJson(json.decode(str));

String thirdpartyListDataToJson(ThirdpartyListData data) =>
    json.encode(data.toJson());

class ThirdpartyListData {
  String status;
  List<ThirdpartyList> list;
  String code;
  String message;

  ThirdpartyListData({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory ThirdpartyListData.fromJson(Map<String, dynamic> json) =>
      ThirdpartyListData(
        status: json["status"],
        list: List<ThirdpartyList>.from(
            json["list"].map((x) => ThirdpartyList.fromJson(x))),
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

class ThirdpartyList {
  int id;
  String ownerName;
  String ownerMobile;
  String ownerAddress;
  int status;
  int createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  ThirdpartyList({
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

  factory ThirdpartyList.fromJson(Map<String, dynamic> json) => ThirdpartyList(
        id: json["id"],
        ownerName: json["owner_name"],
        ownerMobile: json["owner_mobile"],
        ownerAddress: json["owner_address"],
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
        "owner_name": ownerName,
        "owner_mobile": ownerMobile,
        "owner_address": ownerAddress,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
      };
}
