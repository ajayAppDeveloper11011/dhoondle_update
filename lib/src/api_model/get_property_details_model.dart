class GetPropertyDetailModel {
  String? status;
  String? message;
  PropertyDetails? propertyDetails;
  PostedBy? postedBy;
  List<PropertyRules>? propertyRules;
  List<PropertyFacility>? propertyFacility;
  List<PropertyImage>? propertyImage;

  GetPropertyDetailModel(
      {this.status,
        this.message,
        this.propertyDetails,
        this.postedBy,
        this.propertyRules,
        this.propertyFacility,
        this.propertyImage});

  GetPropertyDetailModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    propertyDetails = json['propertyDetails'] != null
        ? new PropertyDetails.fromJson(json['propertyDetails'])
        : null;
    postedBy = json['posted_by'] != null
        ? new PostedBy.fromJson(json['posted_by'])
        : null;
    if (json['propertyRules'] != null) {
      propertyRules = <PropertyRules>[];
      json['propertyRules'].forEach((v) {
        propertyRules!.add(new PropertyRules.fromJson(v));
      });
    }
    if (json['propertyFacility'] != null) {
      propertyFacility = <PropertyFacility>[];
      json['propertyFacility'].forEach((v) {
        propertyFacility!.add(new PropertyFacility.fromJson(v));
      });
    }
    if (json['propertyImage'] != null) {
      propertyImage = <PropertyImage>[];
      json['propertyImage'].forEach((v) {
        propertyImage!.add(new PropertyImage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.propertyDetails != null) {
      data['propertyDetails'] = this.propertyDetails!.toJson();
    }
    if (this.postedBy != null) {
      data['posted_by'] = this.postedBy!.toJson();
    }
    if (this.propertyRules != null) {
      data['propertyRules'] =
          this.propertyRules!.map((v) => v.toJson()).toList();
    }
    if (this.propertyFacility != null) {
      data['propertyFacility'] =
          this.propertyFacility!.map((v) => v.toJson()).toList();
    }
    if (this.propertyImage != null) {
      data['propertyImage'] =
          this.propertyImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PropertyDetails {
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

  PropertyDetails(
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

  PropertyDetails.fromJson(Map<String, dynamic> json) {
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

class PostedBy {
  String? name;
  String? address;
  String? mobile;
  String? email;

  PostedBy({this.name, this.address, this.mobile, this.email});

  PostedBy.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    address = json['address'];
    mobile = json['mobile'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['address'] = this.address;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    return data;
  }
}

class PropertyRules {
  String? id;
  String? rule;
  String? propertyId;
  String? timestamp;

  PropertyRules({this.id, this.rule, this.propertyId, this.timestamp});

  PropertyRules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rule = json['rule'];
    propertyId = json['property_id'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rule'] = this.rule;
    data['property_id'] = this.propertyId;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class PropertyFacility {
  String? id;
  String? pId;
  String? facility;
  String? timestamp;

  PropertyFacility({this.id, this.pId, this.facility, this.timestamp});

  PropertyFacility.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pId = json['p_id'];
    facility = json['facility'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['p_id'] = this.pId;
    data['facility'] = this.facility;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class PropertyImage {
  String? id;
  String? pId;
  String? image;
  String? timestamp;

  PropertyImage({this.id, this.pId, this.image, this.timestamp});

  PropertyImage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    pId = json['p_id'];
    image = json['image'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['p_id'] = this.pId;
    data['image'] = this.image;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
