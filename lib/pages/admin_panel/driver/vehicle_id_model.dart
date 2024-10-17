import 'dart:convert';

VehicleIdModel carNumberModelFromJson(String str) =>
    VehicleIdModel.fromJson(json.decode(str));

String carListDataToJson(VehicleIdModel data) => json.encode(data.toJson());

class VehicleIdModel {
  String status;
  List<VehicleDetails> list;
  String code;
  String message;

  VehicleIdModel({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory VehicleIdModel.fromJson(Map<String, dynamic> json) => VehicleIdModel(
        status: json["status"],
        list: List<VehicleDetails>.from(
            json["list"].map((x) => VehicleDetails.fromJson(x))),
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

class VehicleDetails {
  int id;
  String vehicleNumber;

  VehicleDetails({
    required this.id,
    required this.vehicleNumber,
  });

  factory VehicleDetails.fromJson(Map<String, dynamic> json) => VehicleDetails(
        id: json["id"],
        vehicleNumber: json["vehicle_number"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "vehicle_number": vehicleNumber,
      };
}
