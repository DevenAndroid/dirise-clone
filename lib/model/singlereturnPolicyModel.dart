class SingleReturnPolicy {
  bool? status;
  String? message;
  Data? data;

  SingleReturnPolicy({this.status, this.message, this.data});

  SingleReturnPolicy.fromJson(Map<String, dynamic> json) {
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
  int? id;
  int? userId;
  String? title;
  String? days;
  String? policyDiscreption;
  String? returnShippingFees;
  bool? noReturn;
  String? unit;
  bool? isDefault;

  Data(
      {this.id,
        this.userId,
        this.title,
        this.days,
        this.policyDiscreption,
        this.returnShippingFees,
        this.noReturn,
        this.unit,
        this.isDefault});

  Data.fromJson(Map<String, dynamic> json) {
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
