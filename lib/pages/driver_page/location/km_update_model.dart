// To parse this JSON data, do
//
//     final kmupdateModel = kmupdateModelFromJson(jsonString);

import 'dart:convert';

KmupdateModel kmupdateModelFromJson(String str) =>
    KmupdateModel.fromJson(json.decode(str));

String kmupdateModelToJson(KmupdateModel data) => json.encode(data.toJson());

class KmupdateModel {
  String code;
  String status;
  String message;
  String kmupdateModelMessage;

  KmupdateModel({
    required this.code,
    required this.status,
    required this.message,
    required this.kmupdateModelMessage,
  });

  factory KmupdateModel.fromJson(Map<String, dynamic> json) => KmupdateModel(
        code: json["code"],
        status: json["status"],
        message: json["Message"],
        kmupdateModelMessage: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "Message": message,
        "message": kmupdateModelMessage,
      };
}
