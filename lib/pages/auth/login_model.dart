// // To parse this JSON data, do
// //
// //     final loginOtpModel = loginOtpModelFromJson(jsonString);

// import 'dart:convert';

// LoginOtpModel loginOtpModelFromJson(String str) =>
//     LoginOtpModel.fromJson(json.decode(str));

// String loginOtpModelToJson(LoginOtpModel data) => json.encode(data.toJson());

// class LoginOtpModel {
//   String code;
//   String status;
//   int? userId;
//   String roleName;
//   int? otp;
//   String authToken;
//   String message;

//   LoginOtpModel({
//     required this.code,
//     required this.status,
//     this.userId,
//     required this.roleName,
//     this.otp,
//     required this.authToken,
//     required this.message,
//   });

//   factory LoginOtpModel.fromJson(Map<String, dynamic> json) => LoginOtpModel(
//         code: json["code"],
//         status: json["status"],
//         userId: json["user_id"] == null ? "null" : json["user_id"],
//         roleName: json["role_name"] == null ? "null" : json["role_name"],
//         otp: json["otp"],
//         authToken: json["auth_token"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "code": code,
//         "status": status,
//         "user_id": userId,
//         "role_name": roleName,
//         "otp": otp,
//         "auth_token": authToken,
//         "message": message,
//       };
// }

// To parse this JSON data, do
//
//     final loginOtpModel = loginOtpModelFromJson(jsonString);

import 'dart:convert';

LoginOtpModel loginOtpModelFromJson(String str) =>
    LoginOtpModel.fromJson(json.decode(str));

String loginOtpModelToJson(LoginOtpModel data) => json.encode(data.toJson());

class LoginOtpModel {
  String status;
  String code;
  int? otp;
  String message;
  String? authToken;

  LoginOtpModel(
      {required this.status,
      required this.code,
      this.otp,
      required this.message,
      this.authToken});

  factory LoginOtpModel.fromJson(Map<String, dynamic> json) => LoginOtpModel(
      status: json["status"],
      code: json["code"],
      otp: json["otp"],
      message: json["message"],
      authToken: json["auth_token"]);

  Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "otp": otp,
        "message": message,
        "auth_token": authToken
      };
}
