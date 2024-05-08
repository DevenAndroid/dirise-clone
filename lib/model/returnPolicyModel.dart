class ReturnPolicyModel {
  bool? status;
  String? message;
  List<ReturnPolicy>? returnPolicy = [];

  ReturnPolicyModel({this.status, this.message, this.returnPolicy});

  ReturnPolicyModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['return_policy'] != null) {
      returnPolicy = <ReturnPolicy>[];
      json['return_policy'].forEach((v) {
        returnPolicy!.add(new ReturnPolicy.fromJson(v));
      });
    }
    else {
      returnPolicy = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.returnPolicy != null) {
      data['return_policy'] =
          this.returnPolicy!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReturnPolicy {
  dynamic id;
  dynamic   userId;
  dynamic title;
  dynamic days;
  dynamic policyDiscreption;
  String? returnShippingFees;
  bool? noReturn;
  dynamic unit;
  bool? isDefault;

  ReturnPolicy(
      {this.id,
        this.userId,
        this.title,
        this.days,
        this.policyDiscreption,
        this.returnShippingFees,
        this.noReturn,
        this.unit,
        this.isDefault});

  ReturnPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    days = json['days'];
    policyDiscreption = json['policy_discreption'];
    returnShippingFees = json['return_shipping_fees'];
    noReturn = json['no_return'];
    unit = json['unit'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['days'] = this.days;
    data['policy_discreption'] = this.policyDiscreption;
    data['return_shipping_fees'] = this.returnShippingFees;
    data['no_return'] = this.noReturn;
    data['unit'] = this.unit;
    data['is_default'] = this.isDefault;
    return data;
  }
}
