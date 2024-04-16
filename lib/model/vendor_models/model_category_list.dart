class ModelCategoryList {
  bool? status;
  dynamic message;
  List<Data>? data;

  ModelCategoryList({this.status, this.message, this.data});

  ModelCategoryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic title;
  dynamic slug;
  dynamic categoryImage;
  dynamic categoryImageBanner;
  dynamic parentId;
  dynamic vendorCategory;
  dynamic arabDescription;
  dynamic arabTitle;
  dynamic count;
  List<ChildCategory>? childCategory;

  Data(
      {this.id,
        this.title,
        this.slug,
        this.categoryImage,
        this.categoryImageBanner,
        this.parentId,
        this.vendorCategory,
        this.arabDescription,
        this.arabTitle,
        this.count,
        this.childCategory});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    categoryImage = json['category_image'];
    categoryImageBanner = json['category_image_banner'];
    parentId = json['parent_id'];
    vendorCategory = json['vendor_category'];
    arabDescription = json['arab_description'];
    arabTitle = json['arab_title'];
    count = json['count'];
    if (json['child_category'] != null) {
      childCategory = <ChildCategory>[];
      json['child_category'].forEach((v) {
        childCategory!.add(ChildCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['category_image'] = categoryImage;
    data['category_image_banner'] = categoryImageBanner;
    data['parent_id'] = parentId;
    data['vendor_category'] = vendorCategory;
    data['arab_description'] = arabDescription;
    data['arab_title'] = arabTitle;
    data['count'] = count;
    if (childCategory != null) {
      data['child_category'] =
          childCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChildCategory {
  dynamic id;
  bool selected = false;
  dynamic title;
  dynamic slug;
  dynamic categoryImage;
  dynamic parentId;
  dynamic arabDescription;
  dynamic arabTitle;

  ChildCategory(
      {this.id,
        this.title,
        this.slug,
        this.categoryImage,
        this.parentId,
        this.arabDescription,
        this.arabTitle});

  ChildCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    categoryImage = json['category_image'];
    parentId = json['parent_id'];
    arabDescription = json['arab_description'];
    arabTitle = json['arab_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['category_image'] = categoryImage;
    data['parent_id'] = parentId;
    data['arab_description'] = arabDescription;
    data['arab_title'] = arabTitle;
    return data;
  }
}
