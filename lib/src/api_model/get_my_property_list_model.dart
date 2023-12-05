class GetMyPropertyList {
  String? status;
  String? message;
  List<PropertyList>? propertyList;

  GetMyPropertyList({this.status, this.message, this.propertyList});

  GetMyPropertyList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['propertyList'] != null) {
      propertyList = <PropertyList>[];
      json['propertyList'].forEach((v) {
        propertyList!.add(new PropertyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.propertyList != null) {
      data['propertyList'] = this.propertyList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PropertyList {
  String? propertyId;
  String? name;
  String? address;
  String? latitude;
  String? longitude;
  String? timestamp;
  String? price;
  String? postedBy;
  String? userId;
  String? image;
  String? category;
  String? providerImage;
  String? isActive;
  String? roomtype;
  String? city;
  String? description;
  String? mobile;

  PropertyList(
      {this.propertyId,
        this.name,
        this.address,
        this.latitude,
        this.longitude,
        this.timestamp,
        this.price,
        this.postedBy,
        this.userId,
        this.image,
        this.category,
        this.providerImage,
        this.isActive,
        this.roomtype,
        this.city,
        this.description,
        this.mobile});

  PropertyList.fromJson(Map<String, dynamic> json) {
    propertyId = json['property_id'];
    name = json['name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    timestamp = json['timestamp'];
    price = json['price'];
    postedBy = json['posted_by'];
    userId = json['user_id'];
    image = json['image'];
    category = json['category'];
    providerImage = json['provider_image'];
    isActive = json['isActive'];
    roomtype = json['roomtype'];
    city = json['city'];
    description = json['description'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property_id'] = this.propertyId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['timestamp'] = this.timestamp;
    data['price'] = this.price;
    data['posted_by'] = this.postedBy;
    data['user_id'] = this.userId;
    data['image'] = this.image;
    data['category'] = this.category;
    data['provider_image'] = this.providerImage;
    data['isActive'] = this.isActive;
    data['roomtype'] = this.roomtype;
    data['city'] = this.city;
    data['description'] = this.description;
    data['mobile'] = this.mobile;
    return data;
  }
}
