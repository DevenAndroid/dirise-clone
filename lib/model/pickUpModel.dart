class PickUpPolicyModel {
  bool? status;
  String? message;
  List<PickupPolicy>? pickupPolicy;

  PickUpPolicyModel({this.status, this.message, this.pickupPolicy});

  PickUpPolicyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Pickup Policy'] != null) {
      pickupPolicy = <PickupPolicy>[];
      json['Pickup Policy'].forEach((v) {
        pickupPolicy!.add(new PickupPolicy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.pickupPolicy != null) {
      data['Pickup Policy'] =
          this.pickupPolicy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PickupPolicy {
  dynamic id;
  dynamic vendorId;
  dynamic title;
  dynamic description;
  dynamic pickOption;
  dynamic handlingDays;
  dynamic vendor_will_pay;

  PickupPolicy(
      {this.id,
        this.vendorId,
        this.title,
        this.description,
        this.pickOption,
        this.vendor_will_pay,
        this.handlingDays});

  PickupPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    description = json['description'];
    vendor_will_pay = json['vendor_will_pay'];
    pickOption = json['pick_option'];
    handlingDays = json['handling_days'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['pick_option'] = this.pickOption;
    data['handling_days'] = this.handlingDays;
    return data;
  }
}
