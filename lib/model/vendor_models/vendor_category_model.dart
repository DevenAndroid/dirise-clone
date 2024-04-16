class ModelVendorCategory {
  bool? status;
  String? message;
  List<VendorCategoriesData>? usphone = [];

  ModelVendorCategory({this.status, this.message, this.usphone});

  ModelVendorCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      usphone = <VendorCategoriesData>[];
      json['data'].forEach((v) {
        usphone!.add(VendorCategoriesData.fromJson(v));
      });
    } else {
      usphone = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (usphone != null) {
      data['data'] = usphone!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VendorCategoriesData {
  int? id;
  String? name;
  String? status;
  String? description;
  String? profileImage;
  String? arabName;
  String? bannerProfile;
  String? createdAt;
  String? updatedAt;

  VendorCategoriesData(
      {this.id,
      this.name,
      this.status,
      this.description,
      this.arabName,
      this.profileImage,
      this.bannerProfile,
      this.createdAt,
      this.updatedAt});

  VendorCategoriesData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    description = json['description'];
    arabName = json['arab_name'];
    profileImage = json['profile_image'];
    bannerProfile = json['banner_profile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['description'] = description;
    data['arab_name'] = arabName;
    data['profile_image'] = profileImage;
    data['banner_profile'] = bannerProfile;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
