class ActiveInactivePropertyModel {
  String? status;
  String? message;
  String? isActive;

  ActiveInactivePropertyModel({this.status, this.message, this.isActive});

  ActiveInactivePropertyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['isActive'] = this.isActive;
    return data;
  }
}
