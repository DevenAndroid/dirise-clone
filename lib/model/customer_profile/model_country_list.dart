import 'dart:convert';

class ModelCountryList {
  bool? status;
  dynamic message;
  List<Country>? country;

  ModelCountryList({this.status, this.message, this.country});

  ModelCountryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(Country.fromJson(v));
      });
    }
  }

  ModelCountryList.fromString(String value){
    Map<String, dynamic> json = jsonDecode(value);
    status = json['status'];
    message = json['message'];
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (country != null) {
      data['country'] = country!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  dynamic id;
  dynamic sortname;
  dynamic name;
  dynamic countryCode;
  dynamic url;
  dynamic flagImg;
  dynamic icon;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  Country(
      {this.id,
      this.sortname,
      this.name,
      this.countryCode,
      this.url,
      this.flagImg,
      this.icon,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sortname = json['sortname'];
    name = json['name'];
    countryCode = json['country_code'];
    url = json['url'];
    flagImg = json['flag_img'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['sortname'] = sortname;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['url'] = url;
    data['flag_img'] = flagImg;
    data['icon'] = icon;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
