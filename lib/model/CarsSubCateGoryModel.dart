class CarsSubCateGoryModel {
  bool? status;
  String? message;
  Data? data;

  CarsSubCateGoryModel({this.status, this.message, this.data});

  CarsSubCateGoryModel.fromJson(Map<String, dynamic> json) {
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
  int? parentId;
  int? vendorCategory;
  String? title;
  String? slug;
  Null? categoryImage;
  Null? categoryImageBanner;
  List<SubCategories>? subCategories;

  Data(
      {this.id,
        this.parentId,
        this.vendorCategory,
        this.title,
        this.slug,
        this.categoryImage,
        this.categoryImageBanner,
        this.subCategories});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    vendorCategory = json['vendor_category'];
    title = json['title'];
    slug = json['slug'];
    categoryImage = json['category_image'];
    categoryImageBanner = json['category_image_banner'];
    if (json['sub_categories'] != null) {
      subCategories = <SubCategories>[];
      json['sub_categories'].forEach((v) {
        subCategories!.add(new SubCategories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['parent_id'] = this.parentId;
    data['vendor_category'] = this.vendorCategory;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['category_image'] = this.categoryImage;
    data['category_image_banner'] = this.categoryImageBanner;
    if (this.subCategories != null) {
      data['sub_categories'] =
          this.subCategories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubCategories {
  int? id;
  String? title;
  String? slug;
  String? categoryImage;
  String? categoryImageBanner;

  SubCategories(
      {this.id,
        this.title,
        this.slug,
        this.categoryImage,
        this.categoryImageBanner});

  SubCategories.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    categoryImage = json['category_image'];
    categoryImageBanner = json['category_image_banner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['category_image'] = this.categoryImage;
    data['category_image_banner'] = this.categoryImageBanner;
    return data;
  }
}
