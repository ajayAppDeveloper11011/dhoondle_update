import 'dart:convert';

class LogoutApiModel {
  String status;
  String message;

  LogoutApiModel({
    required this.status,
    required this.message,
  });

  factory LogoutApiModel.fromRawJson(String str) => LogoutApiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LogoutApiModel.fromJson(Map<String, dynamic> json) => LogoutApiModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
