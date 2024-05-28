import 'dart:developer';

class CreateSlotsModel {
  dynamic status;
  dynamic message;
  List<Data>? data;

  CreateSlotsModel({this.status, this.message, this.data});

  CreateSlotsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      if (json['data'] is List) {
        data = <Data>[];
        json['data'].forEach((v) {
          data!.add(Data.fromJson(v));
        });
      } else {
        // Log or handle the case where 'data' is not a List
        log('Unexpected format for data field: ${json['data']}');
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic productId;
  dynamic weekDay;
  dynamic productAvailabilityId;
  dynamic vendorId;
  dynamic timeSloat;
  dynamic timeSloatEnd;

  Data(
      {this.productId,
        this.weekDay,
        this.productAvailabilityId,
        this.vendorId,
        this.timeSloat,
        this.timeSloatEnd});

  Data.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    weekDay = json['week_day'];
    productAvailabilityId = json['product_availability_id'];
    vendorId = json['vendor_id'];
    timeSloat = json['time_sloat'];
    timeSloatEnd = json['time_sloat_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['week_day'] = weekDay;
    data['product_availability_id'] = productAvailabilityId;
    data['vendor_id'] = vendorId;
    data['time_sloat'] = timeSloat;
    data['time_sloat_end'] = timeSloatEnd;
    return data;
  }
}
