import 'dart:convert';

class GetPropertyCategoryModel {
  String status;
  String message;
  List<CategoryList> categoryList;

  GetPropertyCategoryModel({
    required this.status,
    required this.message,
    required this.categoryList,
  });

  factory GetPropertyCategoryModel.fromRawJson(String str) => GetPropertyCategoryModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPropertyCategoryModel.fromJson(Map<String, dynamic> json) => GetPropertyCategoryModel(
    status: json["status"],
    message: json["message"],
    categoryList: List<CategoryList>.from(json["categoryList"].map((x) => CategoryList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "categoryList": List<dynamic>.from(categoryList.map((x) => x.toJson())),
  };
}

class CategoryList {
  String categoryId;
  String category;
  DateTime timestamp;

  CategoryList({
    required this.categoryId,
    required this.category,
    required this.timestamp,
  });

  factory CategoryList.fromRawJson(String str) => CategoryList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CategoryList.fromJson(Map<String, dynamic> json) => CategoryList(
    categoryId: json["category_id"],
    category: json["category"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "category_id": categoryId,
    "category": category,
    "timestamp": timestamp.toIso8601String(),
  };
}
