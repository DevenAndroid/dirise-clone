class SocialLinksModel {
  bool? status;
  String? message;
  User? user;
  SocialLinks? socialLinks;
  int? productCount;

  SocialLinksModel(
      {this.status,
        this.message,
        this.user,
        this.socialLinks,
        this.productCount});

  SocialLinksModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    socialLinks = json['social_links'] != null
        ? new SocialLinks.fromJson(json['social_links'])
        : null;
    productCount = json['product_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.socialLinks != null) {
      data['social_links'] = this.socialLinks!.toJson();
    }
    data['product_count'] = this.productCount;
    return data;
  }
}

class User {
  int? id;
  String? storeLogo;
  String? storeImage;
  String? bannerProfile;
  String? storeName;
  String? email;
  int? storePhone;
  Null? description;
  List<VendorAvailability>? vendorAvailability;

  User(
      {this.id,
        this.storeLogo,
        this.storeImage,
        this.bannerProfile,
        this.storeName,
        this.email,
        this.storePhone,
        this.description,
        this.vendorAvailability});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeLogo = json['store_logo'];
    storeImage = json['store_image'];
    bannerProfile = json['banner_profile'];
    storeName = json['store_name'];
    email = json['email'];
    storePhone = json['store_phone'];
    description = json['description'];
    if (json['vendor_availability'] != null) {
      vendorAvailability = <VendorAvailability>[];
      json['vendor_availability'].forEach((v) {
        vendorAvailability!.add(new VendorAvailability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['store_logo'] = this.storeLogo;
    data['store_image'] = this.storeImage;
    data['banner_profile'] = this.bannerProfile;
    data['store_name'] = this.storeName;
    data['email'] = this.email;
    data['store_phone'] = this.storePhone;
    data['description'] = this.description;
    if (this.vendorAvailability != null) {
      data['vendor_availability'] =
          this.vendorAvailability!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VendorAvailability {
  int? id;
  int? userId;
  int? weekDay;
  String? startTime;
  String? endTime;
  int? status;
  String? createdAt;
  String? updatedAt;

  VendorAvailability(
      {this.id,
        this.userId,
        this.weekDay,
        this.startTime,
        this.endTime,
        this.status,
        this.createdAt,
        this.updatedAt});

  VendorAvailability.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    weekDay = json['week_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['week_day'] = this.weekDay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class SocialLinks {
  String? instagram;
  String? facebook;
  String? youtube;
  String? twitter;
  String? pinterest;
  String? linkedin;
  String? snapchat;
  String? tiktok;
  String? threads;

  SocialLinks(
      {this.instagram,
        this.facebook,
        this.youtube,
        this.twitter,
        this.pinterest,
        this.linkedin,
        this.snapchat,
        this.tiktok,
        this.threads});

  SocialLinks.fromJson(Map<String, dynamic> json) {
    instagram = json['instagram'];
    facebook = json['facebook'];
    youtube = json['youtube'];
    twitter = json['twitter'];
    pinterest = json['pinterest'];
    linkedin = json['linkedin'];
    snapchat = json['snapchat'];
    tiktok = json['tiktok'];
    threads = json['threads'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['youtube'] = this.youtube;
    data['twitter'] = this.twitter;
    data['pinterest'] = this.pinterest;
    data['linkedin'] = this.linkedin;
    data['snapchat'] = this.snapchat;
    data['tiktok'] = this.tiktok;
    data['threads'] = this.threads;
    return data;
  }
}
