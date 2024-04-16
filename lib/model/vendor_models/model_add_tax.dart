class ModelAddTax {
  bool? status;
  String? message;
  List<Tax>? tax;

  ModelAddTax({this.status, this.message, this.tax});

  ModelAddTax.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Tax'] != null) {
      tax = <Tax>[];
      json['Tax'].forEach((v) {
        tax!.add(new Tax.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.tax != null) {
      data['Tax'] = this.tax!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tax {
  dynamic id;
  dynamic vendorId;
  dynamic title;
  dynamic taxAmount;
  dynamic createdAt;
  dynamic updatedAt;

  Tax(
      {this.id,
        this.vendorId,
        this.title,
        this.taxAmount,
        this.createdAt,
        this.updatedAt});

  Tax.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    taxAmount = json['tax_amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['title'] = this.title;
    data['tax_amount'] = this.taxAmount;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
