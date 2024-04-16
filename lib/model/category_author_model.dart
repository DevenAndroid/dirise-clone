import 'product_model/model_product_element.dart';

class CategoryAuthorsModel {
  bool? status;
  String? message;
  List<User>? user;
  String? categoryName;
  List<ProductElement>? product;

  CategoryAuthorsModel({this.status, this.message, this.user, this.categoryName, this.product});

  CategoryAuthorsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['user'] != null) {
      user = <User>[];
      json['user'].forEach((v) {
        user!.add(User.fromJson(v));
      });
    }
    categoryName = json['category_name'];
    if (json['product'] != null) {
      product = <ProductElement>[];
      json['product'].forEach((v) {
        product!.add(ProductElement.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.map((v) => v.toJson()).toList();
    }
    data['category_name'] = categoryName;
    if (product != null) {
      data['product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  int? id;
  String? storeLogo;
  String? storeImage;
  String? storeName;
  String? email;
  int? storePhone;
  String? description;

  User({this.id, this.storeLogo, this.storeImage, this.storeName, this.email, this.storePhone, this.description});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeLogo = json['store_logo'];
    storeImage = json['store_image'];
    storeName = json['store_name'];
    email = json['email'];
    storePhone = json['store_phone'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['store_logo'] = storeLogo;
    data['store_image'] = storeImage;
    data['store_name'] = storeName;
    data['email'] = email;
    data['store_phone'] = storePhone;
    data['description'] = description;
    return data;
  }
}

class Storemeta {
  String? firstName;
  String? lastName;
  int? storeId;
  String? profileImg;
  String? bannerImg;

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
