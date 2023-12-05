// To parse this JSON data, do
//
//     final getMyServiceList = getMyServiceListFromJson(jsonString);

import 'dart:convert';

GetMyServiceList getMyServiceListFromJson(String str) => GetMyServiceList.fromJson(json.decode(str));

String getMyServiceListToJson(GetMyServiceList data) => json.encode(data.toJson());

class GetMyServiceList {
  String status;
  String message;
  List<ServiceList> serviceList;

  GetMyServiceList({
    required this.status,
    required this.message,
    required this.serviceList,
  });

  factory GetMyServiceList.fromJson(Map<String, dynamic> json) => GetMyServiceList(
    status: json["status"],
    message: json["message"],
    serviceList: List<ServiceList>.from(json["serviceList"].map((x) => ServiceList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "serviceList": List<dynamic>.from(serviceList.map((x) => x.toJson())),
  };
}

class ServiceList {
  String id;
  String userId;
  String service;
  String amount;
  DateTime timestamp;
  String number;
  String description;
  String address;
  String serviceId;
  String image;
  String isActive;
  String yearsOfExperience;

  ServiceList({
    required this.id,
    required this.userId,
    required this.service,
    required this.amount,
    required this.timestamp,
    required this.number,
    required this.description,
    required this.address,
    required this.serviceId,
    required this.image,
    required this.isActive,
    required this.yearsOfExperience,
  });

  factory ServiceList.fromJson(Map<String, dynamic> json) => ServiceList(
    id: json["id"],
    userId: json["user_id"],
    service: json["service"],
    amount: json["amount"],
    timestamp: DateTime.parse(json["timestamp"]),
    number: json["number"],
    description: json["description"],
    address: json["address"],
    serviceId: json["service_id"],
    image: json["image"],
    isActive: json["isActive"],
    yearsOfExperience: json["yearsOfExperience"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "service": service,
    "amount": amount,
    "timestamp": timestamp.toIso8601String(),
    "number": number,
    "description": description,
    "address": address,
    "service_id": serviceId,
    "image": image,
    "isActive": isActive,
    "yearsOfExperience": yearsOfExperience,
  };
}
