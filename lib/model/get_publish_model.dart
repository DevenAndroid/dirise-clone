class GetPublishPostModel {
  bool? status;
 dynamic message;
  List<Data>? data;

  GetPublishPostModel({this.status, this.message, this.data});

  GetPublishPostModel.fromJson(Map<String, dynamic> json) {
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
  dynamic userIds;
 dynamic title;
 dynamic discription;
 dynamic file;
 dynamic fileType;
 dynamic thumbnail;
 dynamic createdAt;
 dynamic updatedAt;
  UserId? userId;
  dynamic likeCount;
  bool? isLike;
  bool isOpen = false;
  bool? myAccount;

  Data(
      {this.id,
        this.userIds,
        this.title,
        this.discription,
        this.file,
        this.fileType,
        this.thumbnail,
        this.createdAt,
        this.updatedAt,
        this.userId,
        this.myAccount,
        this.likeCount,
        this.isLike});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userIds = json['user_id'];
    title = json['title'];
    discription = json['discription'];
    file = json['file'];
    fileType = json['file_type'];
    thumbnail = json['thumbnail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userId = json['userId'] != null ? new UserId.fromJson(json['userId']) : null;
    likeCount = json['like_count'];
    isLike = json['is_like'];
    myAccount = json['my_account'];
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
      data['userId'] = this.userId!.toJson();
    }
    data['like_count'] = this.likeCount;
    data['is_like'] = this.isLike;
    data['my_account'] = this.myAccount;
    return data;
  }
}

class UserId {
  dynamic name;
  dynamic profileImage;
  dynamic email;

  UserId({this.name, this.profileImage, this.email});

  UserId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImage = json['profile_image'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['profile_image'] = this.profileImage;
    data['email'] = this.email;
    return data;
  }
}
