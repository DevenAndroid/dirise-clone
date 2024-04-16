import 'product_model/model_product_element.dart';

class ModelSingleProduct {
  bool? status;
  dynamic message;
  ProductElement? product;

  ModelSingleProduct({
    this.status,
    this.message,
    this.product
  });

  ModelSingleProduct.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    product =
    json['product'] != null &&
        json['product'].toString() != "[]" &&
        json['product'].toString().isNotEmpty ?
    ProductElement.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

class Storemeta {
  dynamic firstName;
  dynamic lastName;
  dynamic storeId;
  dynamic profileImg;
  dynamic bannerImg;

  Storemeta(
      {this.firstName,
        this.lastName,
        this.storeId,
        this.profileImg,
        this.bannerImg});

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

// class ServiceTimeSloat {
//   dynamic id;
//   dynamic timeSloat;
//   dynamic timeSloatEnd;
//
//   ServiceTimeSloat({this.id, this.timeSloat, this.timeSloatEnd});
//
//   ServiceTimeSloat.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     timeSloat = json['time_sloat'];
//     timeSloatEnd = json['time_sloat_end'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['time_sloat'] = timeSloat;
//     data['time_sloat_end'] = timeSloatEnd;
//     return data;
//   }
// }
//
// class ProductAvailability {
//   dynamic qty;
//   dynamic type;
//   dynamic fromDate;
//   dynamic toDate;
//
//   ProductAvailability({this.qty, this.type, this.fromDate, this.toDate});
//
//   ProductAvailability.fromJson(Map<String, dynamic> json) {
//     qty = json['qty'];
//     type = json['type'];
//     fromDate = json['from_date'];
//     toDate = json['to_date'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['qty'] = qty;
//     data['type'] = type;
//     data['from_date'] = fromDate;
//     data['to_date'] = toDate;
//     return data;
//   }
// }