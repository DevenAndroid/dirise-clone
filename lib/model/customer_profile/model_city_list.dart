class ModelCityList {
  bool? status;
  dynamic message;
  List<City>? city;

  ModelCityList({this.status, this.message, this.city});

  ModelCityList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['city'] != null) {
      city = <City>[];
      json['city'].forEach((v) {
        city!.add(City.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (city != null) {
      data['city'] = city!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class City {
  dynamic cityId;
  dynamic cityName;
  dynamic stateId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic arabCityName;
  City(
      {this.cityId,
        this.cityName,
        this.stateId,
        this.arabCityName,
        this.createdAt,
        this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    cityId = json['city_id'];
    cityName = json['city_name'];
    arabCityName = json['arab_city_name'];
    stateId = json['state_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['city_id'] = cityId;
    data['city_name'] = cityName;
    data['state_id'] = stateId;
    data['arab_city_name'] = arabCityName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
