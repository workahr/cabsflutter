import 'dart:convert';

CarNumberModel carNumberModelFromJson(String str) =>
    CarNumberModel.fromJson(json.decode(str));

String carListDataToJson(CarNumberModel data) => json.encode(data.toJson());

class CarNumberModel {
  String status;
  List<CarDetails> list;
  String code;
  String message;

  CarNumberModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory CarNumberModel.fromJson(Map<String, dynamic> json) => CarNumberModel(
        status: json["status"],
        list: List<CarDetails>.from(
            json["list"].map((x) => CarDetails.fromJson(x))),
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

class CarDetails {
  int id;
  String vehicleNumber;

  CarDetails({
    required this.id,
    required this.vehicleNumber,
  });

  factory CarDetails.fromJson(Map<String, dynamic> json) => CarDetails(
        id: json["id"],
        vehicleNumber: json["vehicle_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_number": vehicleNumber,
      };
}
