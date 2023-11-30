import 'dart:convert';

class ProfileApiModel {
  String status;
  String message;
  Data data;

  ProfileApiModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ProfileApiModel.fromRawJson(String str) => ProfileApiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) => ProfileApiModel(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String userId;
  String name;
  String mobile;
  String email;
  String address;
  String otp;
  String image;
  String deviceToken;
  String latitude;
  String longitude;

  Data({
    required this.userId,
    required this.name,
    required this.mobile,
    required this.email,
    required this.address,
    required this.otp,
    required this.image,
    required this.deviceToken,
    required this.latitude,
    required this.longitude,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    name: json["name"],
    mobile: json["mobile"],
    email: json["email"],
    address: json["address"],
    otp: json["otp"],
    image: json["image"],
    deviceToken: json["device_token"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "name": name,
    "mobile": mobile,
    "email": email,
    "address": address,
    "otp": otp,
    "image": image,
    "device_token": deviceToken,
    "latitude": latitude,
    "longitude": longitude,
  };
}
