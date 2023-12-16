class GetRoommatesModel {
  bool? status;
  String? message;
  List<RoommatesData>? data;
  int? statusCode;

  GetRoommatesModel({this.status, this.message, this.data, this.statusCode});

  GetRoommatesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <RoommatesData>[];
      json['data'].forEach((v) {
        data!.add(new RoommatesData.fromJson(v));
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

class RoommatesData {
  String? rmId;
  String? userId;
  String? localAddress;
  String? contactNo;
  String? whatsappNo;
  String? cityAddress;
  String? city;
  String? address;
  String? profession;
  String? professionDescription;
  String? photos;
  String? liveIn;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? name;

  RoommatesData(
      {this.rmId,
        this.userId,
        this.localAddress,
        this.contactNo,
        this.whatsappNo,
        this.cityAddress,
        this.city,
        this.address,
        this.profession,
        this.professionDescription,
        this.photos,
        this.liveIn,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.name});

  RoommatesData.fromJson(Map<String, dynamic> json) {
    rmId = json['rm_id'];
    userId = json['user_id'];
    localAddress = json['local_address'];
    contactNo = json['contact_no'];
    whatsappNo = json['whatsapp_no'];
    cityAddress = json['city_address'];
    city = json['city'];
    address = json['address'];
    profession = json['profession'];
    professionDescription = json['profession_description'];
    photos = json['photos'];
    liveIn = json['live_in'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rm_id'] = this.rmId;
    data['user_id'] = this.userId;
    data['local_address'] = this.localAddress;
    data['contact_no'] = this.contactNo;
    data['whatsapp_no'] = this.whatsappNo;
    data['city_address'] = this.cityAddress;
    data['city'] = this.city;
    data['address'] = this.address;
    data['profession'] = this.profession;
    data['profession_description'] = this.professionDescription;
    data['photos'] = this.photos;
    data['live_in'] = this.liveIn;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['name'] = this.name;
    return data;
  }
}
