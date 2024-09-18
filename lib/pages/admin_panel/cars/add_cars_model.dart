import 'dart:convert';

CarAddModel carAddModelFromJson(String str) =>
    CarAddModel.fromJson(json.decode(str));

String carAddModelToJson(CarAddModel data) => json.encode(data.toJson());

class CarAddModel {
  String status;
  String code;
  String message;

  CarAddModel({
    required this.status,
    required this.code,
    required this.message,
  });

  factory CarAddModel.fromJson(Map<String, dynamic> json) => CarAddModel(
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
