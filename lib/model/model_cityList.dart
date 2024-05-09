class ModelCityList {
  bool? status;
  String? message;
  List<City>? city;

  ModelCityList({this.status, this.message, this.city});

  ModelCityList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['city'] != null) {
      city = <City>[];
      json['city'].forEach((v) {
        city!.add(new City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.city != null) {
      data['city'] = this.city!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  int? cityId;
  String? cityName;
  String? arabCityName;
  int? stateId;

  City({this.cityId, this.cityName, this.arabCityName, this.stateId});

  City.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
    arabCityName = json['arab_city_name'];
    stateId = json['state_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_id'] = this.cityId;
    data['city_name'] = this.cityName;
    data['arab_city_name'] = this.arabCityName;
    data['state_id'] = this.stateId;
    return data;
  }
}
