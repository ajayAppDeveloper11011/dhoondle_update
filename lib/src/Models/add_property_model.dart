// To parse this JSON data, do
//
//     final addPropertyModel = addPropertyModelFromJson(jsonString);

import 'dart:convert';

AddPropertyModel addPropertyModelFromJson(String str) => AddPropertyModel.fromJson(json.decode(str));

String addPropertyModelToJson(AddPropertyModel data) => json.encode(data.toJson());

class AddPropertyModel {
  bool status;
  String message;
  int propertyId;
  int statusCode;

  AddPropertyModel({
    required this.status,
    required this.message,
    required this.propertyId,
    required this.statusCode,
  });

  factory AddPropertyModel.fromJson(Map<String, dynamic> json) => AddPropertyModel(
    status: json["status"],
    message: json["message"],
    propertyId: json["property_id"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "property_id": propertyId,
    "statusCode": statusCode,
  };
}
