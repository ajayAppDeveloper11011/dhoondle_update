import 'dart:convert';

class GetPropertyList {
  String status;
  String message;
  List<PropertyList> propertyList;

  GetPropertyList({
    required this.status,
    required this.message,
    required this.propertyList,
  });

  factory GetPropertyList.fromRawJson(String str) => GetPropertyList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GetPropertyList.fromJson(Map<String, dynamic> json) => GetPropertyList(
    status: json["status"],
    message: json["message"],
    propertyList: List<PropertyList>.from(json["propertyList"].map((x) => PropertyList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "propertyList": List<dynamic>.from(propertyList.map((x) => x.toJson())),
  };
}

class PropertyList {
  String propertyId;
  String name;
  String address;
  String latitude;
  String longitude;
  DateTime timestamp;
  String price;
  String postedBy;
  String userId;
  String image;
  String category;
  String providerImage;
  String isActive;
  String roomtype;
  String city;
  String description;
  String mobile;
  Rules? rules;

  PropertyList({
    required this.propertyId,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    required this.price,
    required this.postedBy,
    required this.userId,
    required this.image,
    required this.category,
    required this.providerImage,
    required this.isActive,
    required this.roomtype,
    required this.city,
    required this.description,
    required this.mobile,
    required this.rules,
  });

  factory PropertyList.fromRawJson(String str) => PropertyList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PropertyList.fromJson(Map<String, dynamic> json) => PropertyList(
    propertyId: json["property_id"],
    name: json["name"],
    address: json["address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    timestamp: DateTime.parse(json["timestamp"]),
    price: json["price"],
    postedBy: json["posted_by"],
    userId: json["user_id"],
    image: json["image"],
    category: json["category"],
    providerImage: json["provider_image"],
    isActive: json["isActive"],
    roomtype: json["roomtype"],
    city: json["city"],
    description: json["description"],
    mobile: json["mobile"],
    rules: json["rules"] == null ? null : Rules.fromJson(json["rules"]),
  );

  Map<String, dynamic> toJson() => {
    "property_id": propertyId,
    "name": name,
    "address": address,
    "latitude": latitude,
    "longitude": longitude,
    "timestamp": timestamp.toIso8601String(),
    "price": price,
    "posted_by": postedBy,
    "user_id": userId,
    "image": image,
    "category": category,
    "provider_image": providerImage,
    "isActive": isActive,
    "roomtype": roomtype,
    "city": city,
    "description": description,
    "mobile": mobile,
    "rules": rules?.toJson(),
  };
}

class Rules {
  String id;
  String rule;
  String propertyId;
  DateTime timestamp;

  Rules({
    required this.id,
    required this.rule,
    required this.propertyId,
    required this.timestamp,
  });

  factory Rules.fromRawJson(String str) => Rules.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rules.fromJson(Map<String, dynamic> json) => Rules(
    id: json["id"],
    rule: json["rule"],
    propertyId: json["property_id"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rule": rule,
    "property_id": propertyId,
    "timestamp": timestamp.toIso8601String(),
  };
}
