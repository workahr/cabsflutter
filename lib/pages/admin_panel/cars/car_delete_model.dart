import 'dart:convert';

CarDeleteModel carDeleteModelFromJson(String str) =>
    CarDeleteModel.fromJson(json.decode(str));

String carDeleteModelToJson(CarDeleteModel data) => json.encode(data.toJson());

class CarDeleteModel {
  String status;
  String code;
  String message;

  CarDeleteModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory CarDeleteModel.fromJson(Map<String, dynamic> json) => CarDeleteModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "message": message,
      };
}
