class GetPublishPostModel {
  dynamic status;
  dynamic message;
  List<AllNews>? allNews;

  GetPublishPostModel({this.status, this.message, this.allNews});

  GetPublishPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['all_news'] != null) {
      allNews = <AllNews>[];
      json['all_news'].forEach((v) {
        allNews!.add(new AllNews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.allNews != null) {
      data['all_news'] = this.allNews!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AllNews {
  dynamic id;
  dynamic userId;
  dynamic title;
  dynamic discription;
  dynamic file;
  dynamic fileType;
  dynamic thumbnail;
  dynamic createdAt;
  dynamic updatedAt;
  UserDetails? userDetails;
  dynamic likeCount;
  dynamic isLike;
  dynamic myAccount;
  bool isOpen = false;

  AllNews(
      {this.id,
        this.userId,
        this.title,
        this.discription,
        this.file,
        this.fileType,
        this.thumbnail,
        this.createdAt,
        this.updatedAt,
        this.userDetails,
        this.likeCount,
        this.isLike,
        this.myAccount});

  AllNews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    discription = json['discription'];
    file = json['file'];
    fileType = json['file_type'];
    thumbnail = json['thumbnail'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    userDetails = json['user_details'] != null
        ? new UserDetails.fromJson(json['user_details'])
        : null;
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
    if (this.userDetails != null) {
      data['user_details'] = this.userDetails!.toJson();
    }
    data['like_count'] = this.likeCount;
    data['is_like'] = this.isLike;
    data['my_account'] = this.myAccount;
    return data;
  }
}

class UserDetails {
  dynamic profileImage;
  dynamic email;
  dynamic name;

  UserDetails({this.profileImage, this.email, this.name});

  UserDetails.fromJson(Map<String, dynamic> json) {
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
