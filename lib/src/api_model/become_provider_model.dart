import 'dart:convert';

class BecomeProviderModel {
  String status;
  String message;

  BecomeProviderModel({
    required this.status,
    required this.message,
  });

  factory BecomeProviderModel.fromRawJson(String str) => BecomeProviderModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory BecomeProviderModel.fromJson(Map<String, dynamic> json) => BecomeProviderModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
