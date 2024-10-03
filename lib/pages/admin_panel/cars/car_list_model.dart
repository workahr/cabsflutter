import 'dart:convert';

CarListData carListDataFromJson(String str) =>
    CarListData.fromJson(json.decode(str));

String carListDataToJson(CarListData data) => json.encode(data.toJson());

class CarListData {
  String status;
  List<ListElement> list;
  String code;
  String message;

  CarListData({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory CarListData.fromJson(Map<String, dynamic> json) => CarListData(
        status: json["status"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
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

class ListElement {
  int id;
  String brand;
  String modal;
  String fuelType;
  int seatCapacity;
  String vehicleNumber;
  String? imageUrl;
  String status;
  String createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;

  ListElement({
    required this.id,
    required this.brand,
    required this.modal,
    required this.fuelType,
    required this.seatCapacity,
    required this.vehicleNumber,
    this.imageUrl,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    required this.updatedBy,
    this.updatedDate,
  });

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
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
        updatedBy: json["updated_by"] == null ? "" : json["updated_by"],
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
