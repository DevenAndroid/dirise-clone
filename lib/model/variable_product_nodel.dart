class VariableProductModel {
  bool? status;
  dynamic message;
  VariantProduct? variantProduct;

  VariableProductModel({this.status, this.message, this.variantProduct});

  VariableProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    variantProduct = json['variant_product'] != null
        ? new VariantProduct.fromJson(json['variant_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (variantProduct != null) {
      data['variant_product'] = variantProduct!.toJson();
    }
    return data;
  }
}

class VariantProduct {
  dynamic id;
  dynamic vendorId;
  dynamic addressId;
  List<CatId>? catId;
  VendorInformation? vendorInformation;
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
  dynamic shortDescription;
  dynamic longDescription;
  dynamic isComplete;
  dynamic virtualProductFile;
  dynamic views;
  dynamic rating;
  bool? alreadyReview;
  bool? inWishlist;
  List<Attributes>? attributes;
  List<Variants>? variants;
  Storemeta? storemeta;
  dynamic lowestDeliveryPrice;
  dynamic shippingDate;
  dynamic discountPrice;
  dynamic discountOff;
  dynamic shippingPolicy;

  VariantProduct(
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
        this.vendorInformation,
        // this.returnPolicyDesc,
        this.shortDescription,
        this.longDescription,
        this.isComplete,
        this.virtualProductFile,
        this.views,
        this.rating,
        this.alreadyReview,
        this.inWishlist,
        this.attributes,
        this.variants,
        this.storemeta,
        this.lowestDeliveryPrice,
        this.shippingDate,
        this.discountPrice,
        this.discountOff,
        this.shippingPolicy});

  VariantProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    addressId = json['address_id'];
    if (json['cat_id'] != null) {
      catId = <CatId>[];
      json['cat_id'].forEach((v) {
        catId!.add(new CatId.fromJson(v));
      });
    }
    vendorInformation = json['vendor_information'] != null
        ? new VendorInformation.fromJson(json['vendor_information'])
        : null;
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
    // returnPolicyDesc = json['return_policy_desc'] != null
    //     ? new ReturnPolicyDesc.fromJson(json['return_policy_desc'])
    //     : null;
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    isComplete = json['is_complete'];
    virtualProductFile = json['virtual_product_file'];
    views = json['views'];
    rating = json['rating'];
    alreadyReview = json['already_review'];
    inWishlist = json['in_wishlist'];
    if (json['attributes'] != null) {
      attributes = <Attributes>[];
      json['attributes'].forEach((v) {
        attributes!.add(new Attributes.fromJson(v));
      });
    }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(new Variants.fromJson(v));
      });
    }
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
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['address_id'] = addressId;
    if (catId != null) {
      data['cat_id'] = catId!.map((v) => v.toJson()).toList();
    }
    data['pname'] = pname;
    data['product_type'] = productType;
    data['item_type'] = itemType;
    data['featured_image'] = featuredImage;
    data['feature_image_app'] = featureImageApp;
    if (vendorInformation != null) {
      data['vendor_information'] = vendorInformation!.toJson();
    }
    data['feature_image_web'] = featureImageWeb;
    data['gallery_image'] = galleryImage;
    data['serial_number'] = serialNumber;
    data['product_number'] = productNumber;
    data['product_code'] = productCode;
    data['promotion_code'] = promotionCode;
    data['in_stock'] = inStock;
    data['p_price'] = pPrice;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['is_complete'] = isComplete;
    data['virtual_product_file'] = virtualProductFile;
    data['views'] = views;
    data['rating'] = rating;
    data['already_review'] = alreadyReview;
    data['in_wishlist'] = inWishlist;
    if (attributes != null) {
      data['attributes'] = attributes!.map((v) => v.toJson()).toList();
    }
    if (variants != null) {
      data['variants'] = variants!.map((v) => v.toJson()).toList();
    }
    if (storemeta != null) {
      data['storemeta'] = storemeta!.toJson();
    }
    data['lowestDeliveryPrice'] = lowestDeliveryPrice;
    data['shipping_date'] = shippingDate;
    data['discount_price'] = discountPrice;
    data['discount_off'] = discountOff;
    data['shipping_policy'] = shippingPolicy;
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
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['store_email'] = storeEmail;
    data['store_phone'] = storePhone;
    data['store_logo'] = storeLogo;
    data['store_image'] = storeImage;
    data['store_logo_app'] = storeLogoApp;
    data['store_logo_web'] = storeLogoWeb;
    data['banner_profile'] = bannerProfile;
    data['banner_profile_app'] = bannerProfileApp;
    data['banner_profile_web'] = bannerProfileWeb;
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
    data['id'] = id;
    data['title'] = title;
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
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['days'] = days;
    data['policy_discreption'] = policyDiscreption;
    data['return_shipping_fees'] = returnShippingFees;
    data['unit'] = unit;
    data['no_return'] = noReturn;
    data['is_default'] = isDefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Attributes {
  dynamic id;
  dynamic name;
  List<String>? values;

  Attributes({this.id, this.name, this.values});

  Attributes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    values = json['values'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['values'] = values;
    return data;
  }
}

class Variants {
  dynamic id;
  dynamic comb;
  dynamic price;
  dynamic variantStock;
  dynamic image;
  dynamic variantShortDescription;
  dynamic variantLongDescription;

  Variants({this.id, this.comb, this.price, this.image,this.variantShortDescription,
    this.variantStock,
    this.variantLongDescription});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comb = json['comb'];
    price = json['price'];
    variantStock = json['variant_stock'];
    image = json['image'];
    variantShortDescription = json['variant_short_description'];
    variantLongDescription = json['variant_long_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['comb'] = comb;
    data['price'] = price;
    data['image'] = image;
    data['variant_stock'] = variantStock;
    data['variant_short_description'] = variantShortDescription;
    data['variant_long_description'] = variantLongDescription;
    return data;
  }
}

class Storemeta {
  dynamic firstName;
  dynamic lastName;
  dynamic storeId;
  dynamic document2;
  dynamic storeName;
  dynamic verifyBatch;
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
        this.verifyBatch,
        this.document2,
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
    verifyBatch = json['verify_batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['document_2'] = this.document2;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['store_location'] = storeLocation;
    data['profile_img'] = profileImg;
    data['banner_profile'] = bannerProfile;
    data['commercial_license'] = commercialLicense;
    data['store_category'] = storeCategory;
    data['verify_batch'] = verifyBatch;
    return data;
  }
}
