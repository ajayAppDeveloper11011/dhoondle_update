class MarkActiveInactiveModel {
  String? status;
  String? message;
  String? isActive;

  MarkActiveInactiveModel({this.status, this.message, this.isActive});

  MarkActiveInactiveModel.fromJson(Map<String, dynamic> json) {
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
