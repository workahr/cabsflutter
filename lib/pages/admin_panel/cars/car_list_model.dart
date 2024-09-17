// To parse this JSON data, do
//
//     final expenseListModel = expenseListModelFromJson(jsonString);

import 'dart:convert';

CarListModel carListModelFromJson(String str) =>
    CarListModel.fromJson(json.decode(str));

String carListModelToJson(CarListModel data) => json.encode(data.toJson());

class CarListModel {
  String status;
  List<CarListData> list;
  String code;
  String message;

  CarListModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory CarListModel.fromJson(Map<String, dynamic> json) => CarListModel(
        status: json["status"],
        list: List<CarListData>.from(
            json["list"].map((x) => CarListData.fromJson(x))),
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

class CarListData {
  int carId;
  int userId;
  int expCategoryId;
  String? cartype;
  String? imageUrl;
  String? carname;
  String? vechicalno;
  String? seats;
  int status;
  // int createdBy;
  // DateTime createdDate;
  // int? updatedBy;
  // DateTime? updatedDate;
  // String categoryName;

  CarListData({
    required this.carId,
    required this.userId,
    required this.expCategoryId,
    required this.cartype,
    required this.imageUrl,
    required this.carname,
    required this.vechicalno,
    required this.seats,
    required this.status,
    // required this.createdBy,
    // required this.createdDate,
    // this.updatedBy,
    // this.updatedDate,
    // required this.categoryName,
  });

  factory CarListData.fromJson(Map<String, dynamic> json) => CarListData(
        carId: json["car_id"],
        userId: json["user_id"],
        expCategoryId: json["exp_category_id"],
        cartype: json["cartype"],
        imageUrl: json["imageUrl"],
        carname: json["carname"],
        vechicalno: json["vechicalno"],
        seats: json["seats"],
        status: json["status"],
        // createdBy: json["created_by"],
        // createdDate: DateTime.parse(json["created_date"]),
        // updatedBy: json["updated_by"],
        // updatedDate: json["updated_date"] == null
        //     ? null
        //     : DateTime.parse(json["updated_date"]),
        // categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "car_id": carId,
        "user_id": userId,
        "exp_category_id": expCategoryId,
        "cartype": cartype,
        "imageUrl": imageUrl,
        "carname": carname,
        "vechicalno": vechicalno,
        "seats": seats,
        "status": status,
        // "created_by": createdBy,
        // "created_date": createdDate.toIso8601String(),
        // "updated_by": updatedBy,
        // "updated_date": updatedDate?.toIso8601String(),
        // "category_name": categoryName,
      };
}
