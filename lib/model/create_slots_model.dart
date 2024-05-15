class CreateSlotsModel {
  bool? status;
  String? message;
  List<Data>? data;

  CreateSlotsModel({this.status, this.message, this.data});

  CreateSlotsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? productId;
  int? weekDay;
  int? productAvailabilityId;
  int? vendorId;
  String? timeSloat;
  String? timeSloatEnd;

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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = productId;
    data['week_day'] = weekDay;
    data['product_availability_id'] = productAvailabilityId;
    data['vendor_id'] = vendorId;
    data['time_sloat'] = timeSloat;
    data['time_sloat_end'] = timeSloatEnd;
    return data;
  }
}
