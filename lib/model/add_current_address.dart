class AddCorrentAddressModel {
  bool? status;
  dynamic message;
  Data? data;

  AddCorrentAddressModel({this.status, this.message, this.data});

  AddCorrentAddressModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic city;
  dynamic state;
  dynamic zipCode;
  dynamic country;
  dynamic countryId;

  Data({this.city, this.state, this.zipCode, this.country, this.countryId});

  Data.fromJson(Map<String, dynamic> json) {
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    country = json['country'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['country'] = this.country;
    data['country_id'] = this.countryId;
    return data;
  }
}
