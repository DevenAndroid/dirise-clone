class AdvirtismentProductModel {
  bool? status;
  dynamic message;
  AdvertisingProduct? advertisingProduct;

  AdvirtismentProductModel(
      {this.status, this.message, this.advertisingProduct});

  AdvirtismentProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    advertisingProduct = json['advertising_product'] != null
        ? new AdvertisingProduct.fromJson(json['advertising_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.advertisingProduct != null) {
      data['advertising_product'] = this.advertisingProduct!.toJson();
    }
    return data;
  }
}

class AdvertisingProduct {
  dynamic id;
  dynamic vendorId;
  dynamic addressId;
  List<CatId>? catId;
  dynamic pname;
  dynamic productType;
  dynamic itemType;
  dynamic featuredImage;
  dynamic featureImageApp;
  dynamic featureImageWeb;
  List<String>? galleryImage;
  dynamic serialNumber;
  dynamic productNumber;
  dynamic productCode;
  dynamic promotionCode;
  dynamic inStock;
  dynamic pPrice;
  ReturnPolicyDesc? returnPolicyDesc;
  dynamic shortDescription;
  dynamic longDescription;
  dynamic isComplete;
  dynamic virtualProductFile;
  dynamic views;
  dynamic rating;
  bool? alreadyReview;
  bool? inWishlist;
  Storemeta? storemeta;
  dynamic discountPrice;
  dynamic discountOff;
  dynamic address;

  AdvertisingProduct(
      {this.id,
        this.vendorId,
        this.addressId,
        this.catId,
        this.pname,
        this.productType,
        this.itemType,
        this.featuredImage,
        this.featureImageApp,
        this.featureImageWeb,
        this.galleryImage,
        this.serialNumber,
        this.productNumber,
        this.productCode,
        this.promotionCode,
        this.inStock,
        this.pPrice,
        this.returnPolicyDesc,
        this.shortDescription,
        this.longDescription,
        this.isComplete,
        this.virtualProductFile,
        this.views,
        this.rating,
        this.alreadyReview,
        this.inWishlist,
        this.storemeta,
        this.discountPrice,
        this.discountOff,
        this.address});

  AdvertisingProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    addressId = json['address_id'];
    if (json['cat_id'] != null) {
      catId = <CatId>[];
      json['cat_id'].forEach((v) {
        catId!.add(new CatId.fromJson(v));
      });
    }
    pname = json['pname'];
    productType = json['product_type'];
    itemType = json['item_type'];
    featuredImage = json['featured_image'];
    featureImageApp = json['feature_image_app'];
    featureImageWeb = json['feature_image_web'];
    galleryImage = json['gallery_image'].cast<String>();
    serialNumber = json['serial_number'];
    productNumber = json['product_number'];
    productCode = json['product_code'];
    promotionCode = json['promotion_code'];
    inStock = json['in_stock'];
    pPrice = json['p_price'];
    returnPolicyDesc = json['return_policy_desc'] != null
        ? new ReturnPolicyDesc.fromJson(json['return_policy_desc'])
        : null;
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    isComplete = json['is_complete'];
    virtualProductFile = json['virtual_product_file'];
    views = json['views'];
    rating = json['rating'];
    alreadyReview = json['already_review'];
    inWishlist = json['in_wishlist'];
    storemeta = json['storemeta'] != null
        ? new Storemeta.fromJson(json['storemeta'])
        : null;
    discountPrice = json['discount_price'];
    discountOff = json['discount_off'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['address_id'] = this.addressId;
    if (this.catId != null) {
      data['cat_id'] = this.catId!.map((v) => v.toJson()).toList();
    } 
    data['pname'] = this.pname;
    data['product_type'] = this.productType;
    data['item_type'] = this.itemType;
    data['featured_image'] = this.featuredImage;
    data['feature_image_app'] = this.featureImageApp;
    data['feature_image_web'] = this.featureImageWeb;
    data['gallery_image'] = this.galleryImage;
    data['serial_number'] = this.serialNumber;
    data['product_number'] = this.productNumber;
    data['product_code'] = this.productCode;
    data['promotion_code'] = this.promotionCode;
    data['in_stock'] = this.inStock;
    data['p_price'] = this.pPrice;
    if (this.returnPolicyDesc != null) {
      data['return_policy_desc'] = this.returnPolicyDesc!.toJson();
    }
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['is_complete'] = this.isComplete;
    data['virtual_product_file'] = this.virtualProductFile;
    data['views'] = this.views;
    data['rating'] = this.rating;
    data['already_review'] = this.alreadyReview;
    data['in_wishlist'] = this.inWishlist;
    if (this.storemeta != null) {
      data['storemeta'] = this.storemeta!.toJson();
    }
    data['discount_price'] = this.discountPrice;
    data['discount_off'] = this.discountOff;
    data['address'] = this.address;
    return data;
  }
}

class ReturnPolicyDesc {
  dynamic id;
  dynamic userId;
  dynamic title;
  dynamic days;
  dynamic policyDiscreption;
  dynamic returnShippingFees;
  dynamic unit;
  dynamic noReturn;
  dynamic isDefault;
  dynamic createdAt;
  dynamic updatedAt;

  ReturnPolicyDesc(
      {this.id,
        this.userId,
        this.title,
        this.days,
        this.policyDiscreption,
        this.returnShippingFees,
        this.unit,
        this.noReturn,
        this.isDefault,
        this.createdAt,
        this.updatedAt});

  ReturnPolicyDesc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    days = json['days'];
    policyDiscreption = json['policy_discreption'];
    returnShippingFees = json['return_shipping_fees'];
    unit = json['unit'];
    noReturn = json['no_return'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['days'] = this.days;
    data['policy_discreption'] = this.policyDiscreption;
    data['return_shipping_fees'] = this.returnShippingFees;
    data['unit'] = this.unit;
    data['no_return'] = this.noReturn;
    data['is_default'] = this.isDefault;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Storemeta {
  dynamic firstName;
  dynamic lastName;
  dynamic storeId;
  dynamic document2;
  dynamic storeName;
  dynamic storeLocation;
  dynamic profileImg;
  dynamic bannerProfile;
  dynamic commercialLicense;
  dynamic storeCategory;

  Storemeta(
      {this.firstName,
        this.lastName,
        this.storeId,
        this.storeName,
        this.document2,
        this.storeLocation,
        this.profileImg,
        this.bannerProfile,
        this.commercialLicense,
        this.storeCategory});

  Storemeta.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    document2 = json['document_2'];
    storeLocation = json['store_location'];
    profileImg = json['profile_img'];
    bannerProfile = json['banner_profile'];
    commercialLicense = json['commercial_license'];
    storeCategory = json['store_category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['document_2'] = this.document2;
    data['store_location'] = this.storeLocation;
    data['profile_img'] = this.profileImg;
    data['banner_profile'] = this.bannerProfile;
    data['commercial_license'] = this.commercialLicense;
    data['store_category'] = this.storeCategory;
    return data;
  }
}
class CatId {
  dynamic id;
  dynamic title;

  CatId({this.id, this.title});

  CatId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}