class ModelCountryList {
  bool? status;
  String? message;
  List<Country>? country;

  ModelCountryList({this.status, this.message, this.country});

  ModelCountryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['country'] != null) {
      country = <Country>[];
      json['country'].forEach((v) {
        country!.add(new Country.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.country != null) {
      data['country'] = this.country!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Country {
  int? id;
  String? sortname;
  String? name;
  String? countryCode;
  String? countryZone;
  String? url;
  String? flagImg;
  String? icon;
  String? createdAt;
  String? updatedAt;
  Null? deletedAt;

  Country(
      {this.id,
        this.sortname,
        this.name,
        this.countryCode,
        this.countryZone,
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
    countryZone = json['country_zone'];
    url = json['url'];
    flagImg = json['flag_img'];
    icon = json['icon'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sortname'] = this.sortname;
    data['name'] = this.name;
    data['country_code'] = this.countryCode;
    data['country_zone'] = this.countryZone;
    data['url'] = this.url;
    data['flag_img'] = this.flagImg;
    data['icon'] = this.icon;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    return data;
  }
}
