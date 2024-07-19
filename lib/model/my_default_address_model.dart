import 'package:flutter/foundation.dart';
import 'package:get/get_utils/get_utils.dart';

class MyDefaultAddressModel {
  bool? status;
  dynamic message;
  DefaultAddress? defaultAddress;

  MyDefaultAddressModel({this.status, this.message, this.defaultAddress});

  MyDefaultAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    defaultAddress = json['default_address'] != null
        ? new DefaultAddress.fromJson(json['default_address'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.defaultAddress != null) {
      data['default_address'] = this.defaultAddress!.toJson();
    }
    return data;
  }
}

class DefaultAddress {
  dynamic id;
  dynamic userId;
  dynamic isProduct;
  dynamic isLogin;
  dynamic giveawayId;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic companyName;
  dynamic orderId;
  dynamic phone;
  dynamic phoneCountryCode;
  dynamic alternatePhone;
  dynamic alterPhoneCountryCode;
  dynamic addressType;
  dynamic type;
  bool? isDefault;
  dynamic address;
  dynamic address2;
  dynamic city;
  dynamic country;
  dynamic state;
  dynamic town;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic title;
  dynamic zipCode;
  dynamic instruction;
  dynamic landmark;
  dynamic createdAt;
  dynamic updatedAt;

  DefaultAddress(
      {this.id,
        this.userId,
        this.isProduct,
        this.isLogin,
        this.giveawayId,
        this.firstName,
        this.lastName,
        this.email,
        this.companyName,
        this.orderId,
        this.phone,
        this.phoneCountryCode,
        this.alternatePhone,
        this.alterPhoneCountryCode,
        this.addressType,
        this.type,
        this.isDefault,
        this.address,
        this.address2,
        this.city,
        this.country,
        this.state,
        this.town,
        this.countryId,
        this.stateId,
        this.cityId,
        this.title,
        this.zipCode,
        this.instruction,
        this.landmark,
        this.createdAt,
        this.updatedAt});

  DefaultAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    isProduct = json['is_product'];
    isLogin = json['is_login'];
    giveawayId = json['giveaway_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    companyName = json['company_name'];
    orderId = json['order_id'];
    phone = json['phone'];
    phoneCountryCode = json['phone_country_code'];
    alternatePhone = json['alternate_phone'];
    alterPhoneCountryCode = json['alter_phone_country_code'];
    addressType = json['address_type'];
    type = json['type'];
    isDefault = json['is_default'];
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    town = json['town'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    title = json['title'];
    zipCode = json['zip_code'];
    instruction = json['instruction'];
    landmark = json['landmark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['is_product'] = this.isProduct;
    data['is_login'] = this.isLogin;
    data['giveaway_id'] = this.giveawayId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['company_name'] = this.companyName;
    data['order_id'] = this.orderId;
    data['phone'] = this.phone;
    data['phone_country_code'] = this.phoneCountryCode;
    data['alternate_phone'] = this.alternatePhone;
    data['alter_phone_country_code'] = this.alterPhoneCountryCode;
    data['address_type'] = this.addressType;
    data['type'] = this.type;
    data['is_default'] = this.isDefault;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['town'] = this.town;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['title'] = this.title;
    data['zip_code'] = this.zipCode;
    data['instruction'] = this.instruction;
    data['landmark'] = this.landmark;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
