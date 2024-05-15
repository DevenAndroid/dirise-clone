class GetShippingModel {
  bool? status;
  String? message;
  List<ShippingPolicy>? shippingPolicy;

  GetShippingModel({this.status, this.message, this.shippingPolicy});

  GetShippingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Shipping Policy'] != null) {
      shippingPolicy = <ShippingPolicy>[];
      json['Shipping Policy'].forEach((v) {
        shippingPolicy!.add(new ShippingPolicy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.shippingPolicy != null) {
      data['Shipping Policy'] =
          this.shippingPolicy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShippingPolicy {
  int? id;
  int? vendorId;
  String? title;
  int? days;
  String? description;
  Null? shippingCharges;
  int? priceLimit;

  ShippingPolicy(
      {this.id,
        this.vendorId,
        this.title,
        this.days,
        this.description,
        this.shippingCharges,
        this.priceLimit});

  ShippingPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    days = json['days'];
    description = json['description'];
    shippingCharges = json['shipping_charges'];
    priceLimit = json['price_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['title'] = this.title;
    data['days'] = this.days;
    data['description'] = this.description;
    data['shipping_charges'] = this.shippingCharges;
    data['price_limit'] = this.priceLimit;
    return data;
  }
}
