class AboutUsmodel {
  bool? status;
  dynamic message;
  Data? data;

  AboutUsmodel({this.status, this.message, this.data});

  AboutUsmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic title;
  dynamic arabTitle;
  dynamic content;
  dynamic arabContent;
  dynamic metatitle;
  dynamic metaDetails;
  dynamic metaKeyword;

  Data(
      {this.id,
      this.title,
      this.arabTitle,
      this.content,
      this.arabContent,
      this.metatitle,
      this.metaDetails,
      this.metaKeyword});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    arabTitle = json['arab_title'];
    content = json['content'];
    arabContent = json['arab_content'];
    metatitle = json['metatitle'];
    metaDetails = json['meta_details'];
    metaKeyword = json['meta_keyword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['arab_title'] = arabTitle;
    data['content'] = content;
    data['arab_content'] = arabContent;
    data['metatitle'] = metatitle;
    data['meta_details'] = metaDetails;
    data['meta_keyword'] = metaKeyword;
    return data;
  }
}
