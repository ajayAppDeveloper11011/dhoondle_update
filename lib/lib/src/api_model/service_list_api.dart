class ServiceListApiModel {
  String? status;
  String? message;
  List<ServiceList>? serviceList;

  ServiceListApiModel({this.status, this.message, this.serviceList});

  ServiceListApiModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['serviceList'] != null) {
      serviceList = <ServiceList>[];
      json['serviceList'].forEach((v) {
        serviceList!.add(new ServiceList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.serviceList != null) {
      data['serviceList'] = this.serviceList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceList {
  String? serviceId;
  String? services;
  String? timestamp;
  String? image;

  ServiceList({this.serviceId, this.services, this.timestamp, this.image});

  ServiceList.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
    services = json['services'];
    timestamp = json['timestamp'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    data['services'] = this.services;
    data['timestamp'] = this.timestamp;
    data['image'] = this.image;
    return data;
  }
}
