class SocialMediaModel {
  bool? status;
  String? message;
  List<SocialMedia>? socialMedia;

  SocialMediaModel({this.status, this.message, this.socialMedia});

  SocialMediaModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['social_media'] != null) {
      socialMedia = <SocialMedia>[];
      json['social_media'].forEach((v) {
        socialMedia!.add(new SocialMedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SocialMedia {
  dynamic id;
  dynamic vendorId;
  dynamic name;
  dynamic value;

  SocialMedia({this.id, this.vendorId, this.name, this.value});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['name'] = this.name;
    data['value'] = this.value;
    return data;
  }
}