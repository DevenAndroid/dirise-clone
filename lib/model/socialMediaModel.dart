class SocialMediaModel {
  bool? status;
  String? message;
  SocialMedia? socialMedia;

  SocialMediaModel({this.status, this.message, this.socialMedia});

  SocialMediaModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    socialMedia = json['social_media'] != null
        ? new SocialMedia.fromJson(json['social_media'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.socialMedia != null) {
      data['social_media'] = this.socialMedia!.toJson();
    }
    return data;
  }
}

class SocialMedia {
  String? instagram;
  String? facebook;
  String? youtube;
  String? twitter;
  String? pinterest;
  String? linkedin;
  String? snapchat;
  String? tiktok;
  String? threads;

  SocialMedia(
      {this.instagram,
        this.facebook,
        this.youtube,
        this.twitter,
        this.pinterest,
        this.linkedin,
        this.snapchat,
        this.tiktok,
        this.threads});

  SocialMedia.fromJson(Map<String, dynamic> json) {
    instagram = json['instagram'];
    facebook = json['facebook'];
    youtube = json['youtube'];
    twitter = json['twitter'];
    pinterest = json['pinterest'];
    linkedin = json['linkedin'];
    snapchat = json['snapchat'];
    tiktok = json['tiktok'];
    threads = json['threads'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['youtube'] = this.youtube;
    data['twitter'] = this.twitter;
    data['pinterest'] = this.pinterest;
    data['linkedin'] = this.linkedin;
    data['snapchat'] = this.snapchat;
    data['tiktok'] = this.tiktok;
    data['threads'] = this.threads;
    return data;
  }
}
