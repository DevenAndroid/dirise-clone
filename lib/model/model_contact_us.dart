class ContactUsModel {
  bool? status;
  dynamic message;
  Data? data;

  ContactUsModel({this.status, this.message, this.data});

  ContactUsModel.fromJson(Map<String, dynamic> json) {
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
  dynamic supportEmail;
  dynamic helpNumber;
  dynamic instagram;
  dynamic twitter;
  dynamic facebook;

  Data(
      {this.supportEmail,
        this.helpNumber,
        this.instagram,
        this.twitter,
        this.facebook});

  Data.fromJson(Map<String, dynamic> json) {
    supportEmail = json['support_email'];
    helpNumber = json['help_number'];
    instagram = json['instagram'];
    twitter = json['twitter'];
    facebook = json['facebook'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['support_email'] = this.supportEmail;
    data['help_number'] = this.helpNumber;
    data['instagram'] = this.instagram;
    data['twitter'] = this.twitter;
    data['facebook'] = this.facebook;
    return data;
  }
}
