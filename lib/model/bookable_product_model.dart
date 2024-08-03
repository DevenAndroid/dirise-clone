class BookableProductModel {
  bool? status;
  dynamic message;
  BookingProduct? bookingProduct;

  BookableProductModel({this.status, this.message, this.bookingProduct});

  BookableProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    bookingProduct = json['booking_product'] != null
        ? new BookingProduct.fromJson(json['booking_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (bookingProduct != null) {
      data['booking_product'] = bookingProduct!.toJson();
    }
    return data;
  }
}

class BookingProduct {
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
  dynamic returnPolicyDesc;
  dynamic shortDescription;
  dynamic longDescription;
  dynamic isComplete;
  dynamic virtualProductFile;
  dynamic views;
  dynamic rating;
  bool? alreadyReview;
  bool? inWishlist;
  List<ServiceTimeSloat>? serviceTimeSloat;
  ProductAvailability? productAvailability;
  Storemeta? storemeta;
  dynamic lowestDeliveryPrice;
  dynamic shippingDate;
  dynamic discountPrice;
  dynamic discountOff;
  dynamic shippingPolicy;

  BookingProduct(
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
        this.vendorInformation,
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
        this.serviceTimeSloat,
        this.productAvailability,
        this.storemeta,
        this.lowestDeliveryPrice,
        this.shippingDate,
        this.discountPrice,
        this.discountOff,
        this.shippingPolicy});

  BookingProduct.fromJson(Map<String, dynamic> json) {
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
    vendorInformation = json['vendor_information'] != null
        ? new VendorInformation.fromJson(json['vendor_information'])
        : null;
    inStock = json['in_stock'];
    if (json['serviceTimeSloat'] != null) {
      serviceTimeSloat = <ServiceTimeSloat>[];
      json['serviceTimeSloat'].forEach((v) {
        serviceTimeSloat!.add(new ServiceTimeSloat.fromJson(v));
      });
    }
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
    // if (json['serviceTimeSloat'] != null) {
    //   serviceTimeSloat = <Null>[];
    //   json['serviceTimeSloat'].forEach((v) {
    //     serviceTimeSloat!.add(new Null.fromJson(v));
    //   });
    // }
    productAvailability = json['productAvailability'] != null
        ? new ProductAvailability.fromJson(json['productAvailability'])
        : null;
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
    if (serviceTimeSloat != null) {
      data['serviceTimeSloat'] =
          serviceTimeSloat!.map((v) => v.toJson()).toList();
    }
    data['featured_image'] = featuredImage;
    if (vendorInformation != null) {
      data['vendor_information'] = vendorInformation!.toJson();
    }
    data['feature_image_app'] = featureImageApp;
    data['feature_image_web'] = featureImageWeb;
    data['gallery_image'] = galleryImage;
    data['serial_number'] = serialNumber;
    data['product_number'] = productNumber;
    data['product_code'] = productCode;
    data['promotion_code'] = promotionCode;
    data['in_stock'] = inStock;
    data['p_price'] = pPrice;
    data['return_policy_desc'] = returnPolicyDesc;
    data['short_description'] = shortDescription;
    data['long_description'] = longDescription;
    data['is_complete'] = isComplete;
    data['virtual_product_file'] = virtualProductFile;
    data['views'] = views;
    data['rating'] = rating;
    data['already_review'] = alreadyReview;
    data['in_wishlist'] = inWishlist;
    // if (this.serviceTimeSloat != null) {
    //   data['serviceTimeSloat'] =
    //       this.serviceTimeSloat!.map((v) => v.toJson()).toList();
    // }
    if (productAvailability != null) {
      data['productAvailability'] = productAvailability!.toJson();
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
class ServiceTimeSloat {
  dynamic id;
  dynamic sloatDate;
  dynamic timeSloat;
  dynamic timeSloatEnd;

  ServiceTimeSloat(
      {this.id, this.sloatDate, this.timeSloat, this.timeSloatEnd});

  ServiceTimeSloat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sloatDate = json['sloat_date'];
    timeSloat = json['time_sloat'];
    timeSloatEnd = json['time_sloat_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['sloat_date'] = sloatDate;
    data['time_sloat'] = timeSloat;
    data['time_sloat_end'] = timeSloatEnd;
    return data;
  }
}

class ProductAvailability {
  dynamic qty;
  dynamic type;
  dynamic fromDate;
  dynamic toDate;

  ProductAvailability({this.qty, this.type, this.fromDate, this.toDate});

  ProductAvailability.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    type = json['type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = qty;
    data['type'] = type;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
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
class Storemeta {
  dynamic firstName;
  dynamic lastName;
  dynamic storeId;
  dynamic storeName;
  dynamic storeLocation;
  dynamic profileImg;
  dynamic document2;
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
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['document_2'] = document2;
    data['store_location'] = storeLocation;
    data['profile_img'] = profileImg;
    data['banner_profile'] = bannerProfile;
    data['commercial_license'] = commercialLicense;
    data['store_category'] = storeCategory;
    return data;
  }
}
