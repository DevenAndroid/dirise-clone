class CreateNewsModel {
  bool? status;
  String? message;
  Data? data;

  CreateNewsModel({this.status, this.message, this.data});

  CreateNewsModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  String? title;
  String? discription;
  String? updatedAt;
  String? createdAt;
  int? id;
  String? fileType;

  Data(
      {this.userId,
        this.title,
        this.discription,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.fileType});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    title = json['title'];
    discription = json['discription'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    fileType = json['file_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['discription'] = this.discription;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['file_type'] = this.fileType;
    return data;
  }
}
