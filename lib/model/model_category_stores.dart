import 'package:dirise/model/product_model/model_product_element.dart';
import 'package:dirise/model/vendor_models/model_vendor_orders.dart';

class ModelCategoryStores {
  bool? status;
  dynamic message;
  User? user;
  dynamic categoryName;
  dynamic totalPage;
  SocialLinks? socialLinks;
  List<ProductElement>? product = [];
  List<PromotionData>? promotionData = [];
  dynamic vendorCategory;
  ModelCategoryStores(
      {this.status, this.message, this.user, this.categoryName, this.promotionData, this.totalPage, this.product,this.socialLinks,this.vendorCategory});

  ModelCategoryStores.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : User(data:  []);
    categoryName = json['category_name'];
    totalPage = json['total_page'];
    if (json['product'] != null) {
      product = <ProductElement>[];
      json['product'].forEach((v) {
        product!.add(ProductElement.fromJson(v));
      });
    }
    promotionData ??= [];
    if (json['goldData'] != null) {
      promotionData!.add(PromotionData.fromJson(json['goldData']));
    }
    if (json['silverData'] != null) {
      promotionData!.add(PromotionData.fromJson(json['silverData']));
    }
    if (json['bronzeData'] != null) {
      promotionData!.add(PromotionData.fromJson(json['bronzeData']));
    }
    socialLinks = json['social_links'] != null
        ? SocialLinks.fromJson(json['social_links'])
        : null;
    vendorCategory = json['vendor_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['category_name'] = categoryName;
    data['total_page'] = totalPage;
    data['vendor_category'] = vendorCategory;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    if (socialLinks != null) {
      data['social_links'] = socialLinks!.toJson();
    }
    return data;
  }
}

class User {
  dynamic currentPage;
  dynamic day;
  dynamic start;
  dynamic end;
  dynamic storeBannerDesccription;
  dynamic status;
  List<VendorStoreData>? data = [];
  List<Links>? links;
  List<VendorAvailability>? vendorAvailability;
  User({
    this.currentPage,
    this.data,
    this.links,
    this.vendorAvailability,
    this.status,
    this.day,this.start,this.end

  });

  User.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    day = json['day'] ?? "";
    start = json['start'] ?? "";
    storeBannerDesccription = json['store_banner_desccription'] ?? "";
    end = json['end'] ?? "";
    status = json['status'] ?? '';
    if (json['data'] != null) {
      data = <VendorStoreData>[];
      json['data'].forEach((v) {
        data!.add(VendorStoreData.fromJson(v));
      });
    } else {
      data = [];
    }
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    if (json['vendor_availability'] != null) {
      vendorAvailability = <VendorAvailability>[];
      json['vendor_availability'].forEach((v) {
        vendorAvailability!.add(VendorAvailability.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    data['day'] = day;
    data['start'] = start;
    data['end'] = end;
    data['status'] = status;
    data['store_banner_desccription'] = storeBannerDesccription;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    if (vendorAvailability != null) {
      data['vendor_availability'] =
          vendorAvailability!.map((v) => v.toJson()).toList();
    }
    return data;

  }
}

class VendorAvailability {
  dynamic id;
  dynamic userId;
  dynamic weekDay;
  dynamic startTime;
  dynamic endTime;
  dynamic status;
  dynamic createdAt;
  dynamic updatedAt;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['week_day'] = weekDay;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class VendorStoreData {
  dynamic id;
  dynamic storeLogo;
  dynamic storeImage;
  dynamic storeLogoApp;
  dynamic storeName;
  dynamic email;
  dynamic storePhone;
  dynamic description;
  dynamic day;
  dynamic start;
  dynamic status;
  dynamic end;
  dynamic startBreakTime;
  dynamic endBreakTime;

  VendorStoreData({this.id, this.storeLogo, this.storeImage,this.status, this.storeName, this.email, this.storePhone, this.description,this.day,this.start,this.end,this.storeLogoApp,
  this.endBreakTime,this.startBreakTime});

  VendorStoreData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeLogo = json['store_logo'] ?? "";
    storeImage = json['store_image'] ?? "";
    storeName = json['store_name'] ?? "Store Id: $id";
    email = json['email'] ?? "";
    storePhone = json['store_phone'] ?? "";
    description = json['description'] ?? "";
    day = json['day'] ?? "";
    startBreakTime = json['start_break_time'] ?? "";
    endBreakTime = json['end_break_time'] ?? "";
    start = json['start'] ?? "";
    end = json['end'] ?? "";
    storeLogoApp = json['store_logo_app'] ?? "";
    status = json['status'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_logo'] = storeLogo;
    data['store_image'] = storeImage;
    data['store_name'] = storeName;
    data['email'] = email;
    data['start_break_time'] = startBreakTime;
    data['end_break_time'] = endBreakTime;
    data['store_phone'] = storePhone;
    data['description'] = description;
    data['day'] = day;
    data['start'] = start;
    data['store_logo_app'] = storeLogoApp;
    data['status'] = status;
    data['end'] = end;
    return data;
  }
}

class SocialLinks {
  dynamic instagram;
  dynamic facebook;
  dynamic youtube;
  dynamic twitter;
  dynamic pinterest;
  dynamic linkedin;
  dynamic snapchat;
  dynamic tiktok;
  dynamic threads;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['instagram'] = instagram;
    data['facebook'] = facebook;
    data['youtube'] = youtube;
    data['twitter'] = twitter;
    data['pinterest'] = pinterest;
    data['linkedin'] = linkedin;
    data['snapchat'] = snapchat;
    data['tiktok'] = tiktok;
    data['threads'] = threads;
    return data;
  }
}

class Storemeta {
  dynamic firstName;
  dynamic lastName;
  dynamic storeId;
  dynamic profileImg;
  dynamic bannerImg;

  Storemeta({this.firstName, this.lastName, this.storeId, this.profileImg, this.bannerImg});

  Storemeta.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    storeId = json['store_id'];
    profileImg = json['profile_img'];
    bannerImg = json['banner_img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['store_id'] = storeId;
    data['profile_img'] = profileImg;
    data['banner_img'] = bannerImg;
    return data;
  }
}

class ServiceTimeSloat {
  dynamic timeSloat;
  dynamic timeSloatEnd;

  ServiceTimeSloat({this.timeSloat, this.timeSloatEnd});

  ServiceTimeSloat.fromJson(Map<String, dynamic> json) {
    timeSloat = json['time_sloat'];
    timeSloatEnd = json['time_sloat_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time_sloat'] = timeSloat;
    data['time_sloat_end'] = timeSloatEnd;
    return data;
  }
}

class ProductAvailability {
  dynamic qty;
  dynamic type;
  dynamic fromDate;
  dynamic toDate;

  ProductAvailability({this.qty, this.type, this.fromDate, this.toDate});

  ProductAvailability.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    type = json['type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qty'] = qty;
    data['type'] = type;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    return data;
  }
}

class PromotionData {
  dynamic promotionLevel;
  dynamic promotionType;
  dynamic productStoreId;
  dynamic banner;

  PromotionData({this.promotionLevel, this.promotionType, this.productStoreId, this.banner});

  PromotionData.fromJson(Map<String, dynamic> json) {
    promotionLevel = json['promotion_level'];
    promotionType = json['promotion_type'];
    productStoreId = json['product_store_id'];
    banner = json['banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['promotion_level'] = promotionLevel;
    data['promotion_type'] = promotionType;
    data['product_store_id'] = productStoreId;
    data['banner'] = banner;
    return data;
  }
}
