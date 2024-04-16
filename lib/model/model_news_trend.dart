class ModelNewsTrends {
  bool? status;
  dynamic message;
  List<Data>? data;

  ModelNewsTrends({this.status, this.message, this.data});

  ModelNewsTrends.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic userId;
  dynamic title;
  dynamic discription;
  dynamic file;
  dynamic fileType;
  dynamic thumbnail;
  dynamic createdAt;
  dynamic updatedAt;
  UserId? userIds;
  bool isOpen = false;

  Data(
      {this.id,
        this.userId,
        this.title,
        this.discription,
        this.file,
        this.fileType,
        this.thumbnail,
        this.createdAt,
        this.updatedAt,
        this.userIds});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    discription = json['discription'];
    file = json['file'];
    fileType = json['file_type'];
    thumbnail = json['thumbnail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userIds = json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['discription'] = this.discription;
    data['file'] = this.file;
    data['file_type'] = this.fileType;
    data['thumbnail'] = this.thumbnail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.userId != null) {
      data['userId'] = this.userIds!.toJson();
    }
    return data;
  }
}

class UserId {
  dynamic profileImage;
  dynamic email;
  dynamic name;

  UserId({this.profileImage, this.email, this.name});

  UserId.fromJson(Map<String, dynamic> json) {
    profileImage = json['profile_image'];
    email = json['email'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profile_image'] = this.profileImage;
    data['email'] = this.email;
    data['name'] = this.name;
    return data;
  }
}
