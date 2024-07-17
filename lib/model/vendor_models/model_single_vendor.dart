class ModelSingleVendor {
  bool? status;
  dynamic message;
  User? user;
  int? productCount;
  ModelSingleVendor({this.status, this.message, this.user,this.productCount});

  ModelSingleVendor.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    productCount = json['product_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['product_count'] = this.productCount;
    return data;
  }
}

class User {
  dynamic id;
  dynamic storeLogo;
  dynamic storeImage;
  dynamic storeName;
  dynamic storeUrl;
  dynamic email;
  dynamic storePhone;
  dynamic description;
  dynamic start;
  dynamic day;
  dynamic end;
  dynamic storeBannerDesccription;
  dynamic storeLogoApp;
  dynamic storeLogoWeb;
  dynamic bannerProfileApp;
  dynamic bannerProfileWeb;
  dynamic startBreakTime;
  dynamic endBreakTime;
  User(
      {this.id,
        this.storeLogo,
        this.storeImage,
        this.storeName,
        this.email,
        this.storePhone,
        this.storeUrl,
        this.day,
        this.start,
        this.end,
        this.storeBannerDesccription,
        this.description,
        this.bannerProfileApp,
        this.bannerProfileWeb,
        this.startBreakTime,
        this.endBreakTime,
        this.storeLogoApp,
        this.storeLogoWeb
      });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeLogo = json['store_logo'];
    storeImage = json['store_image'];
    storeName = json['store_name'];
    email = json['email'];
    storeUrl = json['store_url'];
    storePhone = json['store_phone'];
    description = json['description'];
    storeBannerDesccription = json['store_banner_desccription'];
    day = json['day'];
    start = json['start'];
    end = json['end'];
    startBreakTime = json['start_break_time'] ?? "";
    endBreakTime = json['end_break_time'] ?? "";
    storeLogoApp = json['store_logo_app'] ?? "";
    storeLogoWeb = json['store_logo_web'] ?? "";
    bannerProfileApp = json['banner_profile_app'];
    bannerProfileWeb = json['banner_profile_web'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_logo'] = storeLogo;
    data['store_image'] = storeImage;
    data['store_name'] = storeName;
    data['email'] = email;
    data['store_url'] = this.storeUrl;
    data['start_break_time'] = startBreakTime;
    data['end_break_time'] = endBreakTime;
    data['store_phone'] = storePhone;
    data['store_banner_desccription'] = this.storeBannerDesccription;
    data['day'] = this.day;
    data['store_logo_app'] = storeLogoApp;
    data['store_logo_web'] = storeLogoWeb;
    data['banner_profile_app'] = bannerProfileApp;
    data['banner_profile_web'] = bannerProfileWeb;
    data['start'] = this.start;
    data['end'] = this.end;
    data['description'] = description;
    return data;
  }
}
