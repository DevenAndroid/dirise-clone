class VendorEarningsModel {
  dynamic status;
  dynamic message;
  dynamic vendorEarnings;

  VendorEarningsModel({this.status, this.message, this.vendorEarnings});

  VendorEarningsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vendorEarnings = json['vendor_earnings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['vendor_earnings'] = this.vendorEarnings;
    return data;
  }
}
