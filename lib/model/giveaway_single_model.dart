class GiveAwaySingleModel {
  bool? status;
  dynamic message;
  SingleGiveawayProduct? singleGiveawayProduct;

  GiveAwaySingleModel({this.status, this.message, this.singleGiveawayProduct});

  GiveAwaySingleModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    singleGiveawayProduct = json['single_giveaway_product'] != null
        ? new SingleGiveawayProduct.fromJson(json['single_giveaway_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.singleGiveawayProduct != null) {
      data['single_giveaway_product'] = this.singleGiveawayProduct!.toJson();
    }
    return data;
  }
}

class SingleGiveawayProduct {
 dynamic id;
 dynamic vendorId;
 dynamic addressId;
  List<CatId>? catId;
 dynamic catId2;
  dynamic pname;
  dynamic productType;
  dynamic itemType;
 dynamic giveawayItemCondition;
  dynamic featuredImage;
  dynamic featureImageApp;
  dynamic featureImageWeb;
  List<String>? galleryImage;
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
 dynamic wishlistCount;
  Storemeta? storemeta;
 dynamic lowestDeliveryPrice;
  dynamic shippingDate;
  dynamic discountPrice;
  dynamic discountOff;
 dynamic shippingPolicy;

  SingleGiveawayProduct(
      {this.id,
        this.vendorId,
        this.addressId,
        this.catId,
        this.catId2,
        this.pname,
        this.productType,
        this.itemType,
        this.giveawayItemCondition,
        this.featuredImage,
        this.featureImageApp,
        this.featureImageWeb,
        this.galleryImage,
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
        this.wishlistCount,
        this.storemeta,
        this.lowestDeliveryPrice,
        this.shippingDate,
        this.discountPrice,
        this.discountOff,
        this.shippingPolicy});

  SingleGiveawayProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    addressId = json['address_id'];
    if (json['cat_id'] != null) {
      catId = <CatId>[];
      json['cat_id'].forEach((v) {
        catId!.add(new CatId.fromJson(v));
      });
    }
    catId2 = json['cat_id_2'];
    pname = json['pname'];
    productType = json['product_type'];
    itemType = json['item_type'];
    giveawayItemCondition = json['giveaway_item_condition'];
    featuredImage = json['featured_image'];
    featureImageApp = json['feature_image_app'];
    featureImageWeb = json['feature_image_web'];
    galleryImage = json['gallery_image'].cast<String>();
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
    wishlistCount = json['wishlist_count'];
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
    data['cat_id_2'] = this.catId2;
    data['pname'] = this.pname;
    data['product_type'] = this.productType;
    data['item_type'] = this.itemType;
    data['giveaway_item_condition'] = this.giveawayItemCondition;
    data['featured_image'] = this.featuredImage;
    data['feature_image_app'] = this.featureImageApp;
    data['feature_image_web'] = this.featureImageWeb;
    data['gallery_image'] = this.galleryImage;
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
    data['wishlist_count'] = this.wishlistCount;
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
  dynamic document2;
  dynamic bannerProfile;
  dynamic commercialLicense;
  dynamic storeCategory;
  bool? isVendor;

  Storemeta(
      {this.firstName,
        this.lastName,
        this.storeId,
        this.storeName,
        this.storeLocation,
        this.profileImg,
        this.bannerProfile,
        this.document2,
        this.commercialLicense,
        this.isVendor,
        this.storeCategory});

  Storemeta.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    storeId = json['store_id'];
    storeName = json['store_name'];
    storeLocation = json['store_location'];
    profileImg = json['profile_img'];
    bannerProfile = json['banner_profile'];
    document2 = json['document_2'];
    commercialLicense = json['commercial_license'];
    storeCategory = json['store_category'];
    isVendor = json['is_vendor'];
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
    data['is_vendor'] = this.isVendor;

    return data;
  }
}
