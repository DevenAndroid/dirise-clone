import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ModelUserAddressList {
  bool? status;
  dynamic message;
  Address? address;

  ModelUserAddressList({this.status, this.message, this.address});

  ModelUserAddressList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (address != null) {
      data['address'] = address!.toJson();
    }
    return data;
  }
}

class Address {
  List<AddressData>? billing;
  List<AddressData>? shipping;

  Address({this.billing, this.shipping});

  Address.fromJson(Map<String, dynamic> json) {
    if (json['billing'] != null) {
      billing = <AddressData>[];
      json['billing'].forEach((v) {
        billing!.add(AddressData.fromJson(v));
      });
    } else {
      billing = [];
    }
    if (json['shipping'] != null) {
      shipping = <AddressData>[];
      json['shipping'].forEach((v) {
        shipping!.add(AddressData.fromJson(v));
      });
    } else {
      shipping = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (billing != null) {
      data['billing'] = billing!.map((v) => v.toJson()).toList();
    }
    if (shipping != null) {
      data['shipping'] = shipping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressData {
  dynamic id;
  dynamic userId;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic companyName;
  dynamic orderId;
  dynamic phone;
  dynamic alternatePhone;
  dynamic addressType;
  dynamic type;
  dynamic isDefault;
  dynamic address;
  dynamic address2;
  dynamic city;
  dynamic country;
  dynamic stateId;
  dynamic cityId;
  dynamic state;
  dynamic zipCode;
  dynamic landmark;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic countryId;
  dynamic phoneCountryCode;
  dynamic town;

  AddressData(
      {this.id,
      this.userId,
      this.firstName,
      this.lastName,
      this.email,
      this.companyName,
      this.countryId,
      this.orderId,
      this.phone,
      this.alternatePhone,
      this.addressType,
      this.type,
      this.isDefault,
      this.address,
      this.address2,
      this.city,
      this.country,
      this.state,
      this.zipCode,
      this.landmark,
      this.createdAt,
      this.cityId,
      this.stateId,
      this.phoneCountryCode,
        this.town,
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

  AddressData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    companyName = json['company_name'];
    orderId = json['order_id'];
    phone = json['phone'];
    alternatePhone = json['alternate_phone'];
    addressType = json['address_type'];
    type = json['type'];
    isDefault = json['is_default'];
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    zipCode = json['zip_code'];
    landmark = json['landmark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    countryId = json['country_id'];
    town = json['town'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    phoneCountryCode = json['phone_country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['company_name'] = companyName;
    data['order_id'] = orderId;
    data['phone'] = phone;
    data['alternate_phone'] = alternatePhone;
    data['address_type'] = addressType;
    data['type'] = type;
    data['is_default'] = isDefault;
    data['address'] = address;
    data['address2'] = address2;
    data['city'] = city;
    data['country'] = country;
    data['state'] = state;
    data['zip_code'] = zipCode;
    data['landmark'] = landmark;
    data['created_at'] = createdAt;
    data['town'] = createdAt;
    data['updated_at'] = updatedAt;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    data['phone_country_code'] = phoneCountryCode ;

    return data;
  }
}
