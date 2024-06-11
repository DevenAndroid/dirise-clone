class GetPublishPostModel {
  bool? status;
 dynamic message;
  AllNews? allNews;

  GetPublishPostModel({this.status, this.message, this.allNews});

  GetPublishPostModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    allNews = json['all_news'] != null
        ? new AllNews.fromJson(json['all_news'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.allNews != null) {
      data['all_news'] = this.allNews!.toJson();
    }
    return data;
  }
}

class AllNews {
 dynamic currentPage;
  List<Data>? data;
 dynamic firstPageUrl;
 dynamic from;
 dynamic lastPage;
 dynamic lastPageUrl;
  List<Links>? links;
 dynamic nextPageUrl;
 dynamic path;
 dynamic perPage;
 dynamic prevPageUrl;
 dynamic to;
 dynamic total;

  AllNews(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  AllNews.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
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
  UserDetails? userDetails;
 dynamic likeCount;
  bool? isLike;
  bool isOpen = false;
  bool? myAccount;

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
        this.userDetails,
        this.likeCount,
        this.isLike,
        this.myAccount});

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

class Links {
 dynamic url;
 dynamic label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
