// To parse this JSON data, do
//
//     final loginOtpModel = loginOtpModelFromJson(jsonString);

import 'dart:convert';

LoginOtpModel loginOtpModelFromJson(String str) => LoginOtpModel.fromJson(json.decode(str));

String loginOtpModelToJson(LoginOtpModel data) => json.encode(data.toJson());

class LoginOtpModel {
    String status;
    String code;
    int? otp;
    String message;
    String? authToken;

    LoginOtpModel({
        required this.status,
        required this.code,
         this.otp,
        required this.message,
        this.authToken
    });

    factory LoginOtpModel.fromJson(Map<String, dynamic> json) => LoginOtpModel(
        status: json["status"],
        code: json["code"],
        otp: json["otp"],
        message: json["message"],
        authToken: json["auth_token"]
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "code": code,
        "otp": otp,
        "message": message,
        "auth_token":authToken
    };
}
