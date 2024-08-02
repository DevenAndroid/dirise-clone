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
  dynamic returnPolicyDesc;
  dynamic shortDescription;
  dynamic longDescription;
  dynamic isComplete;
  dynamic virtualProductFile;
  dynamic views;
  dynamic rating;
  bool? alreadyReview;
  bool? inWishlist;
  Storemeta? storemeta;
  VendorInformation? vendorInformation;
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
        this.vendorInformation,
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
    returnPolicyDesc = json['return_policy_desc'];
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
    vendorInformation = json['vendor_information'] != null
        ? new VendorInformation.fromJson(json['vendor_information'])
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
    data['return_policy_desc'] = this.returnPolicyDesc;
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
    if (this.vendorInformation != null) {
      data['vendor_information'] = this.vendorInformation!.toJson();
    }
    data['discount_price'] = this.discountPrice;
    data['discount_off'] = this.discountOff;
    data['address'] = this.address;
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
  dynamic document2;
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
        this.document2,
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
    document2 = json['document_2'];
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
    data['document_2'] = this.document2;
    data['store_category'] = this.storeCategory;
    return data;
  }
}

class VendorInformation {
  dynamic storeId;
  dynamic storeName;
  dynamic storeEmail;
  dynamic storePhone;
  dynamic storeLogo;
  dynamic storeImage;
  dynamic storeLogoApp;
  dynamic storeLogoWeb;
  dynamic bannerProfile;
  dynamic bannerProfileApp;
  dynamic bannerProfileWeb;

  VendorInformation(
      {this.storeId,
        this.storeName,
        this.storeEmail,
        this.storePhone,
        this.storeLogo,
        this.storeImage,
        this.storeLogoApp,
        this.storeLogoWeb,
        this.bannerProfile,
        this.bannerProfileApp,
        this.bannerProfileWeb});

  VendorInformation.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeEmail = json['store_email'];
    storePhone = json['store_phone'];
    storeLogo = json['store_logo'];
    storeImage = json['store_image'];
    storeLogoApp = json['store_logo_app'];
    storeLogoWeb = json['store_logo_web'];
    bannerProfile = json['banner_profile'];
    bannerProfileApp = json['banner_profile_app'];
    bannerProfileWeb = json['banner_profile_web'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['store_id'] = this.storeId;
    data['store_name'] = this.storeName;
    data['store_email'] = this.storeEmail;
    data['store_phone'] = this.storePhone;
    data['store_logo'] = this.storeLogo;
    data['store_image'] = this.storeImage;
    data['store_logo_app'] = this.storeLogoApp;
    data['store_logo_web'] = this.storeLogoWeb;
    data['banner_profile'] = this.bannerProfile;
    data['banner_profile_app'] = this.bannerProfileApp;
    data['banner_profile_web'] = this.bannerProfileWeb;
    return data;
  }
}
