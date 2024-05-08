class SubCategoryModel {
  bool? status;
  String? message;
  List<SubProductData>? data;

  SubCategoryModel({this.status, this.message, this.data});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SubProductData>[];
      json['data'].forEach((v) {
        data!.add(new SubProductData.fromJson(v));
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

class SubProductData {
  dynamic id;
  dynamic title;
  dynamic  parentId;
  dynamic discription;
  bool selected = false;
  dynamic status;
  dynamic slug;
  dynamic  arabTitle;
  dynamic  arabDescription;
  dynamic categoryImage;

  SubProductData(
      {this.id,
        this.title,
        this.parentId,
        this.discription,
        this.status,
        this.slug,
        this.arabTitle,
        this.arabDescription,
        this.categoryImage});

  SubProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    parentId = json['parent_id'];
    discription = json['discription'];
    status = json['status'];
    slug = json['slug'];
    arabTitle = json['arab_title'];
    arabDescription = json['arab_description'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['parent_id'] = this.parentId;
    data['discription'] = this.discription;
    data['status'] = this.status;
    data['slug'] = this.slug;
    data['arab_title'] = this.arabTitle;
    data['arab_description'] = this.arabDescription;
    data['category_image'] = this.categoryImage;
    return data;
  }
}