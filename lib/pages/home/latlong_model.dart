// To parse this JSON data, do
//
//     final latLong = latLongFromJson(jsonString);

import 'dart:convert';

LatLong latLongFromJson(String str) => LatLong.fromJson(json.decode(str));

String latLongToJson(LatLong data) => json.encode(data.toJson());

class LatLong {
    double latitude;
    double longitude;

    LatLong({
        required this.latitude,
        required this.longitude,
    });

    factory LatLong.fromJson(Map<String, dynamic> json) => LatLong(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"],
    );

    Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
    };
}
