class GetFeaturedStoreModel {
  bool? status;
  dynamic message;
  List<Data>? data;

  GetFeaturedStoreModel({this.status, this.message, this.data});

  GetFeaturedStoreModel.fromJson(Map<String, dynamic> json) {
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
  User? user;
  SocialLoginKeys? socialLoginKeys;

  Data({this.user, this.socialLoginKeys});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    socialLoginKeys = json['social_login_keys'] != null
        ? new SocialLoginKeys.fromJson(json['social_login_keys'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.socialLoginKeys != null) {
      data['social_login_keys'] = this.socialLoginKeys!.toJson();
    }
    return data;
  }
}

class User {
  dynamic id;
  dynamic storeLogo;
  dynamic storeImage;
  dynamic bannerProfile;
  dynamic storeName;
  dynamic email;
  dynamic storePhone;
  dynamic storeLogoApp;
  dynamic storeLogoWeb;
  dynamic bannerProfileApp;
  dynamic bannerProfileWeb;
  dynamic description;

  User(
      {this.id,
        this.storeLogo,
        this.storeImage,
        this.bannerProfile,
        this.storeName,
        this.email,
        this.storePhone,
        this.storeLogoApp,
        this.storeLogoWeb,
        this.bannerProfileApp,
        this.bannerProfileWeb,
        this.description});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeLogo = json['store_logo'];
    storeImage = json['store_image'];
    bannerProfile = json['banner_profile'];
    storeName = json['store_name'];
    email = json['email'];
    storePhone = json['store_phone'];
    storeLogoApp = json['store_logo_app'];
    storeLogoWeb = json['store_logo_web'];
    bannerProfileApp = json['banner_profile_app'];
    bannerProfileWeb = json['banner_profile_web'];
    description = json['description'];
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
    data['store_logo_app'] = this.storeLogoApp;
    data['store_logo_web'] = this.storeLogoWeb;
    data['banner_profile_app'] = this.bannerProfileApp;
    data['banner_profile_web'] = this.bannerProfileWeb;
    data['description'] = this.description;
    return data;
  }
}

class SocialLoginKeys {
  dynamic instagram;
  dynamic facebook;
  dynamic youtube;
  dynamic twitter;
  dynamic pinterest;
  dynamic linkedin;
  dynamic snapchat;
  dynamic tiktok;
  dynamic threads;

  SocialLoginKeys(
      {this.instagram,
        this.facebook,
        this.youtube,
        this.twitter,
        this.pinterest,
        this.linkedin,
        this.snapchat,
        this.tiktok,
        this.threads});

  SocialLoginKeys.fromJson(Map<String, dynamic> json) {
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
