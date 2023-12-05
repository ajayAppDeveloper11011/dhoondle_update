class AddPropertyImagesModel {
  String? status;
  String? message;
  String? image;

  AddPropertyImagesModel({this.status, this.message, this.image});

  AddPropertyImagesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['image'] = this.image;
    return data;
  }
}
