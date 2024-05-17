class SponsorsDetailsModel {
  bool? status;
  dynamic message;
  List<Data>? data;

  SponsorsDetailsModel({this.status, this.message, this.data});

  SponsorsDetailsModel.fromJson(Map<String, dynamic> json) {
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
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? id;
  int? vendorId;
  dynamic sponsorType;
  dynamic sponsorName;
  dynamic sponsorLogo;

  Data(
      {this.id,
        this.vendorId,
        this.sponsorType,
        this.sponsorName,
        this.sponsorLogo});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    sponsorType = json['sponsor_type'];
    sponsorName = json['sponsor_name'];
    sponsorLogo = json['sponsor_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['sponsor_type'] = this.sponsorType;
    data['sponsor_name'] = this.sponsorName;
    data['sponsor_logo'] = this.sponsorLogo;
    return data;
  }
}
