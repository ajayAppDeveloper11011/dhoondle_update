class EditProfileModel {
  String? status;
  String? message;
  Data? data;

  EditProfileModel({this.status, this.message, this.data});

  EditProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? userId;
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

  Data(
      {this.userId,
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

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    address = json['address'];
    otp = json['otp'];
    image = json['image'];
    deviceToken = json['device_token'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
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
