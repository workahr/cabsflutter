// To parse this JSON data, do
//
//     final kilometercalculationModel = kilometercalculationModelFromJson(jsonString);

import 'dart:convert';

KilometercalculationModel kilometercalculationModelFromJson(String str) =>
    KilometercalculationModel.fromJson(json.decode(str));

String kilometercalculationModelToJson(KilometercalculationModel data) =>
    json.encode(data.toJson());

class KilometercalculationModel {
  String status;
  String code;
  String distance;
  String duration;
  String message;

  KilometercalculationModel({
    required this.status,
    required this.code,
    required this.distance,
    required this.duration,
    required this.message,
  });

  factory KilometercalculationModel.fromJson(Map<String, dynamic> json) =>
      KilometercalculationModel(
        status: json["status"],
        code: json["code"],
        distance: json["distance"],
        duration: json["duration"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "distance": distance,
        "duration": duration,
        "message": message,
      };
}
