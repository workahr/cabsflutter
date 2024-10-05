// To parse this JSON data, do
//
//     final allbookingListData = allbookingListDataFromJson(jsonString);

import 'dart:convert';
// To parse this JSON data, do
//
//     final bookingHistroyListData = bookingHistroyListDataFromJson(jsonString);

import 'dart:convert';

BookingHistroyListData bookinghistroyListDataFromJson(String str) =>
    BookingHistroyListData.fromJson(json.decode(str));

String bookingHistroyListDataToJson(BookingHistroyListData data) =>
    json.encode(data.toJson());

class BookingHistroyListData {
  String status;
  List<BookingHistroy> list;
  String code;
  String message;

  BookingHistroyListData({
    required this.status,
    required this.list,
    required this.code,
    required this.message,
  });

  factory BookingHistroyListData.fromJson(Map<String, dynamic> json) =>
      BookingHistroyListData(
        status: json["status"],
        list: List<BookingHistroy>.from(
            json["list"].map((x) => BookingHistroy.fromJson(x))),
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

class BookingHistroy {
  int id;
  String? rental;
  int? rentalId;
  String? brand;
  String? modal;
  String? fuelType;
  int? seatCapacity;
  String? vehicleNumber;
  String? currentStatus;
  String? latitude;
  String? longitude;
  String? imageUrl;
  int? status;
  int createdBy;
  DateTime createdDate;
  int? updatedBy;
  DateTime? updatedDate;
  String? driverId;
  String? carId;
  String customerId;
  String? bookingOtp;
  String? bookingStatus;
  DateTime fromDatetime;
  DateTime toDatetime;
  String pickupLocation;
  String dropLocation;
  String? totalDistance;
  String? bookingCharges;
  String? cancelReason;

  BookingHistroy({
    required this.id,
    this.rental,
    this.rentalId,
    this.brand,
    this.modal,
    this.fuelType,
    this.seatCapacity,
    this.vehicleNumber,
    this.currentStatus,
    this.latitude,
    this.longitude,
    this.imageUrl,
    required this.status,
    required this.createdBy,
    required this.createdDate,
    this.updatedBy,
    this.updatedDate,
    this.driverId,
    this.carId,
    required this.customerId,
    required this.bookingOtp,
    this.bookingStatus,
    required this.fromDatetime,
    required this.toDatetime,
    required this.pickupLocation,
    required this.dropLocation,
    this.totalDistance,
    this.bookingCharges,
    this.cancelReason,
  });

  factory BookingHistroy.fromJson(Map<String, dynamic> json) => BookingHistroy(
        id: json["id"],
        rental: json["rental"],
        rentalId: json["rental_id"],
        brand: json["brand"],
        modal: json["modal"],
        fuelType: json["fuel_type"],
        seatCapacity: json["seat_capacity"],
        vehicleNumber: json["vehicle_number"],
        currentStatus: json["current_status"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        imageUrl: json["image_url"],
        status: json["status"],
        createdBy: json["created_by"],
        createdDate: DateTime.parse(json["created_date"]),
        updatedBy: json["updated_by"],
        updatedDate: json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
        driverId: json["driver_id"],
        carId: json["car_id"],
        customerId: json["customer_id"],
        bookingOtp: json["booking_otp"],
        bookingStatus: json["booking_status"],
        fromDatetime: DateTime.parse(json["from_datetime"]),
        toDatetime: DateTime.parse(json["to_datetime"]),
        pickupLocation: json["pickup_location"],
        dropLocation: json["drop_location"],
        totalDistance: json["total_distance"],
        bookingCharges: json["booking_charges"],
        cancelReason: json["cancel_reason"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rental": rental,
        "rental_id": rentalId,
        "brand": brand,
        "modal": modal,
        "fuel_type": fuelType,
        "seat_capacity": seatCapacity,
        "vehicle_number": vehicleNumber,
        "current_status": currentStatus,
        "latitude": latitude,
        "longitude": longitude,
        "image_url": imageUrl,
        "status": status,
        "created_by": createdBy,
        "created_date": createdDate.toIso8601String(),
        "updated_by": updatedBy,
        "updated_date": updatedDate?.toIso8601String(),
        "driver_id": driverId,
        "car_id": carId,
        "customer_id": customerId,
        "booking_otp": bookingOtp,
        "booking_status": bookingStatus,
        "from_datetime": fromDatetime.toIso8601String(),
        "to_datetime": toDatetime.toIso8601String(),
        "pickup_location": pickupLocation,
        "drop_location": dropLocation,
        "total_distance": totalDistance,
        "booking_charges": bookingCharges,
        "cancel_reason": cancelReason,
      };
}

// enum BookingStatus { COMPLETED, DRIVER_ASSIGNED, NEW, PENDING }

// final bookingStatusValues = EnumValues({
//   "COMPLETED": BookingStatus.COMPLETED,
//   "DRIVER ASSIGNED": BookingStatus.DRIVER_ASSIGNED,
//   "NEW": BookingStatus.NEW,
//   "PENDING": BookingStatus.PENDING
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }






// // To parse this JSON data, do
// //
// //     final allbookingListData = allbookingListDataFromJson(jsonString);

// import 'dart:convert';

// Booking_Histroy_ListData bookinghistroyListDataFromJson(String str) =>
//     Booking_Histroy_ListData.fromJson(json.decode(str));

// String bookinghistroyListDataToJson(Booking_Histroy_ListData data) =>
//     json.encode(data.toJson());

// class Booking_Histroy_ListData {
//   String status;
//   List<BookingHistroy> list;
//   String code;
//   String message;

//   Booking_Histroy_ListData({
//     required this.status,
//     required this.list,
//     required this.code,
//     required this.message,
//   });

//   factory Booking_Histroy_ListData.fromJson(Map<String, dynamic> json) =>
//       Booking_Histroy_ListData(
//         status: json["status"],
//         list: List<BookingHistroy>.from(
//             json["list"].map((x) => BookingHistroy.fromJson(x))),
//         code: json["code"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "list": List<dynamic>.from(list.map((x) => x.toJson())),
//         "code": code,
//         "message": message,
//       };
// }

// class BookingHistroy {
//   int id;
//   String? brand;
//   String? modal;
//   String? fuelType;
//   int? seatCapacity;
//   String? vehicleNumber;
//   String? currentStatus;
//   dynamic latitude;
//   dynamic longitude;
//   dynamic imageUrl;
//   String status;
//   int createdBy;
//   DateTime createdDate;
//   int? updatedBy;
//   DateTime? updatedDate;
//   String driverId;
//   String carId;
//   String customerId;
//   dynamic bookingOtp;
//   BookingStatus bookingStatus;
//   DateTime fromDatetime;
//   DateTime toDatetime;
//   String pickupLocation;
//   String dropLocation;
//   dynamic totalDistance;
//   dynamic bookingCharges;
//   String? cancelReason;

//   BookingHistroy({
//     required this.id,
//     required this.brand,
//     required this.modal,
//     required this.fuelType,
//     required this.seatCapacity,
//     required this.vehicleNumber,
//     required this.currentStatus,
//     required this.latitude,
//     required this.longitude,
//     required this.imageUrl,
//     required this.status,
//     required this.createdBy,
//     required this.createdDate,
//     this.updatedBy,
//     this.updatedDate,
//     required this.driverId,
//     required this.carId,
//     required this.customerId,
//     required this.bookingOtp,
//     required this.bookingStatus,
//     required this.fromDatetime,
//     required this.toDatetime,
//     required this.pickupLocation,
//     required this.dropLocation,
//     required this.totalDistance,
//     required this.bookingCharges,
//     required this.cancelReason,
//   });

//   factory BookingHistroy.fromJson(Map<String, dynamic> json) => BookingHistroy(
//         id: json["id"],
//         brand: json["brand"],
//         modal: json["modal"],
//         fuelType: json["fuel_type"],
//         seatCapacity: json["seat_capacity"],
//         vehicleNumber: json["vehicle_number"],
//         currentStatus: json["current_status"],
//         latitude: json["latitude"],
//         longitude: json["longitude"],
//         imageUrl: json["image_url"],
//         status: json["status"],
//         createdBy: json["created_by"],
//         createdDate: DateTime.parse(json["created_date"]),
//         updatedBy: json["updated_by"],
//         updatedDate: json["updated_date"] == null
//             ? null
//             : DateTime.parse(json["updated_date"]),
//         driverId: json["driver_id"],
//         carId: json["car_id"],
//         customerId: json["customer_id"],
//         bookingOtp: json["booking_otp"],
//         bookingStatus: bookingStatusValues.map[json["booking_status"]]!,
//         fromDatetime: DateTime.parse(json["from_datetime"]),
//         toDatetime: DateTime.parse(json["to_datetime"]),
//         pickupLocation: json["pickup_location"],
//         dropLocation: json["drop_location"],
//         totalDistance: json["total_distance"],
//         bookingCharges: json["booking_charges"],
//         cancelReason: json["cancel_reason"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "brand": brand,
//         "modal": modal,
//         "fuel_type": fuelType,
//         "seat_capacity": seatCapacity,
//         "vehicle_number": vehicleNumber,
//         "current_status": currentStatus,
//         "latitude": latitude,
//         "longitude": longitude,
//         "image_url": imageUrl,
//         "status": status,
//         "created_by": createdBy,
//         "created_date": createdDate.toIso8601String(),
//         "updated_by": updatedBy,
//         "updated_date": updatedDate?.toIso8601String(),
//         "driver_id": driverId,
//         "car_id": carId,
//         "customer_id": customerId,
//         "booking_otp": bookingOtp,
//         "booking_status": bookingStatusValues.reverse[bookingStatus],
//         "from_datetime": fromDatetime.toIso8601String(),
//         "to_datetime": toDatetime.toIso8601String(),
//         "pickup_location": pickupLocation,
//         "drop_location": dropLocation,
//         "total_distance": totalDistance,
//         "booking_charges": bookingCharges,
//         "cancel_reason": cancelReason,
//       };
// }

// enum BookingStatus { COMPLETED, NEW, CANCELLED, PENDING }

// final bookingStatusValues = EnumValues({
//   "COMPLETED": BookingStatus.COMPLETED,
//   "NEW": BookingStatus.NEW,
//   "PENDING": BookingStatus.PENDING
// });

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
