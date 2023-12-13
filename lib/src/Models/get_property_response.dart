class GetPropertyModel {
  bool? status;
  String? message;
  List<PropertyData>? data;
  int? statusCode;

  GetPropertyModel({this.status, this.message, this.data, this.statusCode});

  GetPropertyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PropertyData>[];
      json['data'].forEach((v) {
        data!.add(new PropertyData.fromJson(v));
      });
    }
    statusCode = json['statusCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['statusCode'] = this.statusCode;
    return data;
  }
}

class PropertyData {
  String? id;
  String? userId;
  String? localAddress;
  String? city;
  String? propertyType;
  String? bathCount;
  String? parkingAvailable;
  String? furnished;
  String? widthSqft;
  String? price;
  String? description;
  String? otherFacilities;
  String? propertyImage;
  String? createdAt;
  String? updatedAt;
  String? name;
  String? mobile;
  String? email;
  String? address;
  String? otp;
  String? image;
  String? deviceToken;
  String? latitude;
  String? longitude;
  String? isVerified;

  PropertyData(
      {this.id,
        this.userId,
        this.localAddress,
        this.city,
        this.propertyType,
        this.bathCount,
        this.parkingAvailable,
        this.furnished,
        this.widthSqft,
        this.price,
        this.description,
        this.otherFacilities,
        this.propertyImage,
        this.createdAt,
        this.updatedAt,
        this.name,
        this.mobile,
        this.email,
        this.address,
        this.otp,
        this.image,
        this.deviceToken,
        this.latitude,
        this.longitude,
        this.isVerified});

  PropertyData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    localAddress = json['local_address']??'';
    city = json['city']??'';
    propertyType = json['property_type']??'';
    bathCount = json['bath_count']??'';
    parkingAvailable = json['parking_available']??'';
    furnished = json['furnished']??'';
    widthSqft = json['width_sqft']??'';
    price = json['price']??'';
    description = json['description']??'';
    otherFacilities = json['other_facilities']??'';
    propertyImage = json['property_image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address']??'';
    otp = json['otp'];
    image = json['image'];
    deviceToken = json['device_token'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['local_address'] = this.localAddress;
    data['city'] = this.city;
    data['property_type'] = this.propertyType;
    data['bath_count'] = this.bathCount;
    data['parking_available'] = this.parkingAvailable;
    data['furnished'] = this.furnished;
    data['width_sqft'] = this.widthSqft;
    data['price'] = this.price;
    data['description'] = this.description;
    data['other_facilities'] = this.otherFacilities;
    data['property_image'] = this.propertyImage;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['address'] = this.address;
    data['otp'] = this.otp;
    data['image'] = this.image;
    data['device_token'] = this.deviceToken;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['isVerified'] = this.isVerified;
    return data;
  }
}
