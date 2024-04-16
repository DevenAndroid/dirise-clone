class ModelSingleCategoryList {
  bool? status;
  dynamic message;
  List<Data>? data;
  List<VendorSubCategory>? vendorSubCategory = [];
  VendorSubCategory? selectedVendorSubCategory;

  ModelSingleCategoryList({this.status, this.message, this.data});

  ModelSingleCategoryList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    } if (json['vendor_sub_category'] != null) {
      vendorSubCategory = <VendorSubCategory>[];
      json['vendor_sub_category'].forEach((v) {
        vendorSubCategory!.add(VendorSubCategory.fromJson(v));
      });
    }
    vendorSubCategory ??= [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (vendorSubCategory != null) {
      data['vendor_sub_category'] =
          vendorSubCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic vendorId;
  dynamic parentId;
  dynamic vendorCategory;
  dynamic level;
  dynamic commision;
  dynamic categoryImage;
  dynamic categoryImageBanner;
  dynamic discription;
  dynamic arabDescription;
  dynamic status;
  dynamic title;
  dynamic arabTitle;
  dynamic slug;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic count;
  ChildCategory? selectedCategory;
  List<ChildCategory>? childCategory;

  Data(
      {this.id,
        this.vendorId,
        this.parentId,
        this.vendorCategory,
        this.level,
        this.commision,
        this.categoryImage,
        this.categoryImageBanner,
        this.discription,
        this.arabDescription,
        this.status,
        this.title,
        this.arabTitle,
        this.slug,
        this.createdAt,
        this.updatedAt,
        this.count,
        this.childCategory});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    parentId = json['parent_id'];
    vendorCategory = json['vendor_category'];
    level = json['level'];
    commision = json['commision'];
    categoryImage = json['category_image'];
    categoryImageBanner = json['category_image_banner'];
    discription = json['discription'];
    arabDescription = json['arab_description'];
    status = json['status'];
    title = json['title'];
    arabTitle = json['arab_title'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    data['vendor_id'] = vendorId;
    data['parent_id'] = parentId;
    data['vendor_category'] = vendorCategory;
    data['level'] = level;
    data['commision'] = commision;
    data['category_image'] = categoryImage;
    data['category_image_banner'] = categoryImageBanner;
    data['discription'] = discription;
    data['arab_description'] = arabDescription;
    data['status'] = status;
    data['title'] = title;
    data['arab_title'] = arabTitle;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
  dynamic title;
  dynamic slug;
  dynamic categoryImage;
  dynamic parentId;

  ChildCategory(
      {this.id,
        this.title,
        this.slug,
        this.categoryImage,
        this.parentId,});

  ChildCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    categoryImage = json['category_image'];
    parentId = json['parent_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['slug'] = slug;
    data['category_image'] = categoryImage;
    data['parent_id'] = parentId;
    return data;
  }
}
class VendorSubCategory {
  int? id;
  String? name;
  int? parentId;
  String? description;
  List<SubChildCategory>? childCategory = [];
  SubChildCategory? selectedSubChildCategory;

  VendorSubCategory(
      {this.id,
        this.name,
        this.parentId,
        this.description,
        this.childCategory});

  VendorSubCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    description = json['description'];
    try {
      if (json['child_category'] != null) {
        childCategory = <SubChildCategory>[];
        json['child_category'].forEach((v) {
          childCategory!.add(SubChildCategory.fromJson(v));
        });
      }
    } catch(e){
      childCategory ??= [];
    }
    childCategory ??= [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent_id'] = parentId;
    data['description'] = description;
    if (childCategory != null) {
      data['child_category'] =
          childCategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SubChildCategory {
  int? id;
  String? name;
  int? parentId;
  String? description;

  SubChildCategory({this.id, this.name, this.parentId, this.description});

  SubChildCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['parent_id'] = parentId;
    data['description'] = description;
    return data;
  }
}
