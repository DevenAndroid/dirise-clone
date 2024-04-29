import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class MyDefaultAddressModel {
  bool? status;
  dynamic message;
  DefaultAddress? defaultAddress;

  MyDefaultAddressModel({this.status, this.message, this.defaultAddress});



  MyDefaultAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['default_address'] != null && json['default_address'] is Map<String, dynamic>) {
      defaultAddress = DefaultAddress.fromJson(json['default_address']);
    } else {
      defaultAddress = null;
    }
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
  dynamic isDefault;
  dynamic address;
  dynamic address2;
  dynamic city;
  dynamic country;
  dynamic countryCode;
  dynamic state;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic title;
  dynamic zipCode;
  dynamic landmark;
  dynamic createdAt;
  dynamic updatedAt;

  DefaultAddress(
      {this.id,
        this.userId,
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
        this.countryCode,
        this.state,
        this.countryId,
        this.stateId,
        this.cityId,
        this.title,
        this.zipCode,
        this.landmark,
        this.createdAt,
        this.updatedAt});

  String get getCompleteAddressInFormat {
    List<String> gg = [];
    gg.add(("${getOutput(firstName)} ${getOutput(lastName)}").toString().trim());
    gg.add(getOutput(address));
    gg.add(getOutput(address2));
    gg.add(getOutput(landmark));
    gg.add(("${getOutput(city)} ${getOutput(zipCode)}").toString().trim());
    gg.add(getOutput(state));
    gg.add(getOutput(country));
    gg.removeWhere((element) => element.isEmpty);
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }

  String get getShortAddress {
    List<String> gg = [];
    gg.add(("${getOutput(firstName)} ${getOutput(lastName)}").toString().trim());
    gg.add(getOutput(address));
    // gg.add(getOutput(address2));
    // gg.add(getOutput(landmark));
    gg.add(("${getOutput(city)} ${getOutput(id)}").toString().trim());
    // gg.add(getOutput(state));
    // gg.add(getOutput(country));
    gg.removeWhere((element) => element.isEmpty);
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }
  String get getFirstName {
    List<String> gg = [];
    gg.add((getOutput(firstName)).toString().trim());
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }
  String get getLastName {
    List<String> gg = [];
    gg.add((getOutput(lastName)).toString().trim());
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }
  String get getEmail {
    List<String> gg = [];
    gg.add((getOutput(email)).toString().trim());
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }
  String get getPhone {
    List<String> gg = [];
    gg.add((getOutput(phone)).toString().trim());
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }
  String get getAlternate {
    List<String> gg = [];
    gg.add((getOutput(alternatePhone)).toString().trim());
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }
  String get getAddress {
    List<String> gg = [];
    gg.add((getOutput(address)).toString().trim());
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }
  String get getCountry {
    List<String> gg = [];
    gg.add((getOutput(country)).toString().trim());
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }
  String get getState {
    List<String> gg = [];
    gg.add((getOutput(state)).toString().trim());
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }
  String get getCity {
    List<String> gg = [];
    gg.add((getOutput(city)).toString().trim());
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }
  String get getZipCode {
    List<String> gg = [];
    gg.add((getOutput(zipCode)).toString().trim());
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }
  String get getCountryId {
    List<String> gg = [];
    gg.add((getOutput(countryId)).toString().trim());
    if (kDebugMode) {
      print(gg);
    }
    return gg.join(", ");
  }

  String getOutput(kk) {
    return (kk != null ? kk.toString() : "").toString().capitalizeFirst!;
  }

  DefaultAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
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
    countryCode = json['country_code'];
    state = json['state'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    title = json['title'];
    zipCode = json['zip_code'];
    landmark = json['landmark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
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
    data['country_code'] = this.countryCode;
    data['state'] = this.state;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['title'] = this.title;
    data['zip_code'] = this.zipCode;
    data['landmark'] = this.landmark;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
