class SimpleProductModel {
  bool? status;
  dynamic message;
  SimpleProduct? simpleProduct;

  SimpleProductModel({this.status, this.message, this.simpleProduct});

  SimpleProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    simpleProduct = json['simple_product'] != null
        ? new SimpleProduct.fromJson(json['simple_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.simpleProduct != null) {
      data['simple_product'] = this.simpleProduct!.toJson();
    }
    return data;
  }
}

class SimpleProduct {
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
  dynamic returnPolicyDesc;
  dynamic shortDescription;
  dynamic longDescription;
  dynamic isComplete;
  dynamic virtualProductFile;
  dynamic views;
  dynamic rating;
  bool? inWishlist;
  bool? alreadyReview;
  Storemeta? storemeta;
  dynamic lowestDeliveryPrice;
  dynamic shippingDate;
  dynamic discountPrice;
  dynamic discountOff;
  dynamic shippingPolicy;

  SimpleProduct(
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
        this.lowestDeliveryPrice,
        this.shippingDate,
        this.discountPrice,
        this.discountOff,
        this.shippingPolicy});

  SimpleProduct.fromJson(Map<String, dynamic> json) {
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
    inWishlist = json['in_wishlist'];
    promotionCode = json['promotion_code'];
    inStock = json['in_stock'];
    pPrice = json['p_price'];
    returnPolicyDesc = json['return_policy_desc'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    isComplete = json['is_complete'];
    virtualProductFile = json['virtual_product_file'];
    views = json['views'];
    rating = json['rating'];
    alreadyReview = json['already_review'];
    storemeta = json['storemeta'] != null
        ? new Storemeta.fromJson(json['storemeta'])
        : null;
    lowestDeliveryPrice = json['lowestDeliveryPrice'];
    shippingDate = json['shipping_date'];
    discountPrice = json['discount_price'];
    discountOff = json['discount_off'];
    shippingPolicy = json['shipping_policy'];
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
    data['in_wishlist'] = this.inWishlist;
    data['p_price'] = this.pPrice;
    data['return_policy_desc'] = this.returnPolicyDesc;
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['is_complete'] = this.isComplete;
    data['virtual_product_file'] = this.virtualProductFile;
    data['views'] = this.views;
    data['rating'] = this.rating;
    data['already_review'] = this.alreadyReview;
    if (this.storemeta != null) {
      data['storemeta'] = this.storemeta!.toJson();
    }
    data['lowestDeliveryPrice'] = this.lowestDeliveryPrice;
    data['shipping_date'] = this.shippingDate;
    data['discount_price'] = this.discountPrice;
    data['discount_off'] = this.discountOff;
    data['shipping_policy'] = this.shippingPolicy;
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

class Storemeta {
  dynamic firstName;
  dynamic lastName;
  dynamic storeId;
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
    data['store_location'] = this.storeLocation;
    data['profile_img'] = this.profileImg;
    data['banner_profile'] = this.bannerProfile;
    data['commercial_license'] = this.commercialLicense;
    data['store_category'] = this.storeCategory;
    return data;
  }
}
