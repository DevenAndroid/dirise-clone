class SinglePolicy {
  bool? status;
  String? message;
  SingleShippingPolicy? singleShippingPolicy;

  SinglePolicy({this.status, this.message, this.singleShippingPolicy});

  SinglePolicy.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    singleShippingPolicy = json['Single_shipping_policy'] != null
        ? new SingleShippingPolicy.fromJson(json['Single_shipping_policy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.singleShippingPolicy != null) {
      data['Single_shipping_policy'] = this.singleShippingPolicy!.toJson();
    }
    return data;
  }
}

class SingleShippingPolicy {
  dynamic id;
  dynamic vendorId;
  dynamic title;
  dynamic days;
  dynamic description;
  dynamic shippingType;
  dynamic aboveShipping;
  dynamic shippingZone;
  dynamic range1Min;
  dynamic range1Max;
  dynamic range1Percent;
  dynamic range2Min;
  dynamic range2Max;
  dynamic range2Percent;
  dynamic priceLimit;

  SingleShippingPolicy(
      {this.id,
        this.vendorId,
        this.title,
        this.days,
        this.description,
        this.shippingType,
        this.aboveShipping,
        this.shippingZone,
        this.range1Min,
        this.range1Max,
        this.range1Percent,
        this.range2Min,
        this.range2Max,
        this.range2Percent,
        this.priceLimit});

  SingleShippingPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    days = json['days'];
    description = json['description'];
    shippingType = json['shipping_type'];
    aboveShipping = json['above_shipping'];
    shippingZone = json['shipping_zone'];
    range1Min = json['range1_min'];
    range1Max = json['range1_max'];
    range1Percent = json['range1_percent'];
    range2Min = json['range2_min'];
    range2Max = json['range2_max'];
    range2Percent = json['range2_percent'];
    priceLimit = json['price_limit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['title'] = this.title;
    data['days'] = this.days;
    data['description'] = this.description;
    data['shipping_type'] = this.shippingType;
    data['above_shipping'] = this.aboveShipping;
    data['shipping_zone'] = this.shippingZone;
    data['range1_min'] = this.range1Min;
    data['range1_max'] = this.range1Max;
    data['range1_percent'] = this.range1Percent;
    data['range2_min'] = this.range2Min;
    data['range2_max'] = this.range2Max;
    data['range2_percent'] = this.range2Percent;
    data['price_limit'] = this.priceLimit;
    return data;
  }
}
