import 'package:dirise/utils/helper.dart';

class ProductElement {
  dynamic id;
  dynamic vendorId;
  dynamic catId;
  dynamic catId2;
  dynamic catId3;
  dynamic brandSlug;
  dynamic slug;
  dynamic pName;
  dynamic addToCart;
  dynamic arabPname;
  dynamic productType;
  dynamic virtualProductType;
  dynamic skuId;
  dynamic virtualProductFile;
  dynamic virtualProductFileType;
  dynamic pPrice;
  dynamic sPrice;
  dynamic commission;
  dynamic productNew;
  dynamic bestSaller;
  dynamic featured;
  dynamic taxApply;
  dynamic taxType;
  dynamic shortDescription;
  dynamic arabShortDescription;
  dynamic longDescription;
  dynamic arabLongDescription;
  dynamic featuredImage;
  List<String>? galleryImage = [];
  dynamic inStock;
  dynamic stockAlert;
  dynamic shippingType;
  dynamic shippingCharge;
  dynamic avgRating;
  dynamic metaTitle;
  dynamic metaKeyword;
  dynamic metaDescription;
  dynamic parentId;
  dynamic serviceStartTime;
  dynamic serviceEndTime;
  dynamic serviceDuration;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic topHunderd;
  dynamic returnDays;
  dynamic isPublish;
  dynamic inOffer;
  dynamic forAuction;
  dynamic returnPolicyDesc;
  dynamic discountPercentage;
  bool? inCart;
  bool? inWishlist;
  dynamic startDate;
  dynamic endDate;
  dynamic startTime;
  dynamic endTime;
  dynamic minBidPrice;
  dynamic stepPrice;
  dynamic currentBid;
  dynamic featureImageApp;
  dynamic beforePurchase;
  dynamic alreadyReview;
  bool? isShipping;
  bool? localShipping;
  List<ServiceTimeSloat>? serviceTimeSloat;
  ProductAvailability? productAvailability;
  // List<Attributes>? attributes;
  List<Variants>? variants;
  dynamic bidStatus;

  ProductElement({
    this.id,
    this.vendorId,
    this.catId,
    this.alreadyReview,
    this.catId2,
    this.catId3,
    this.brandSlug,
    this.isShipping,
    this.localShipping,
    this.slug,
    this.pName,
    this.addToCart,
    this.arabPname,
    this.productType,
    this.virtualProductType,
    this.skuId,
    this.virtualProductFile,
    this.virtualProductFileType,
    this.pPrice,
    this.sPrice,
    this.commission,
    this.productNew,
    this.bestSaller,
    this.featured,
    this.taxApply,
    this.beforePurchase,
    this.taxType,
    this.shortDescription,
    this.arabShortDescription,
    this.longDescription,
    this.arabLongDescription,
    this.featuredImage,
    this.galleryImage,
    this.inStock,
    this.stockAlert,
    this.shippingType,
    this.shippingCharge,
    this.avgRating,
    this.metaTitle,
    this.metaKeyword,
    this.metaDescription,
    this.parentId,
    this.serviceStartTime,
    this.serviceEndTime,
    this.serviceDuration,
    this.createdAt,
    this.updatedAt,
    this.topHunderd,
    this.returnDays,
    this.featureImageApp,
    this.isPublish,
    this.inOffer,
    this.forAuction,
    this.returnPolicyDesc,
    this.discountPercentage,
    this.inCart,
    this.inWishlist,
    this.startDate,
    this.endDate,
    this.startTime,
    this.endTime,
    this.minBidPrice,
    this.stepPrice,
    this.currentBid,
    // this.attributes,
    this.serviceTimeSloat,
    this.productAvailability,
    this.variants,
    this.bidStatus,
  });

  ProductElement.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    vendorId = json["vendor_id"];
    catId = json["cat_id"];
    catId2 = json["cat_id_2"];
    catId3 = json["cat_id_3"];
    brandSlug = json["brand_slug"];
    slug = json["slug"];
    pName = json["pname"];
    addToCart = json["add_to_cart"];
    addToCart = json["add_to_cart"];
    arabPname = json["arab_pname"];
    featureImageApp = json['feature_image_app'];
    virtualProductFile = json['virtual_product_file'];
    virtualProductFileType = json['virtual_product_file_type'];
    productType = json["product_type"];
    virtualProductType = json["virtual_product_type"];
    skuId = json["sku_id"];
    pPrice = json["p_price"];
    sPrice = json["s_price"];
    commission = json["commission"];
    alreadyReview = json['already_review'];
    productNew = json["new"];
    bestSaller = json["best_saller"];
    featured = json["featured"];
    taxApply = json["tax_apply"];
    taxType = json["tax_type"];
    shortDescription = json["short_description"];
    arabShortDescription = json["arab_short_description"];
    longDescription = json["long_description"];
    arabLongDescription = json["arab_long_description"];
    isShipping = json['is_shipping'];
    featuredImage = json["featured_image"];
    beforePurchase = json['before_purchase'];
    localShipping = json['local_shipping'];
    try {
      galleryImage = json["gallery_image"] == null ? [] : List<String>.from(json["gallery_image"]!.map((x) => x));
    } catch(e){
      galleryImage = [];
    }
    inStock = json["in_stock"];
    stockAlert = json["stock_alert"];
    shippingType = json["shipping_type"];
    shippingCharge = json["shipping_charge"];
    avgRating = json["avg_rating"];
    metaTitle = json["meta_title"];
    metaKeyword = json["meta_keyword"];
    metaDescription = json["meta_description"];
    parentId = json["parent_id"];
    serviceStartTime = json["service_start_time"];
    serviceEndTime = json["service_end_time"];
    serviceDuration = json["service_duration"];
    createdAt = json["created_at"] == null ? null : DateTime.parse(json["created_at"]);
    updatedAt = json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]);
    topHunderd = json["top_hunderd"];
    returnDays = json["return_days"];
    isPublish = json["is_publish"];
    inOffer = json["in_offer"];
    forAuction = json["for_auction"];
    returnPolicyDesc = json["return_policy_desc"];
    inCart = json["in_cart"];
    inWishlist = json["in_wishlist"];
    startDate = json["start_date"];
    endDate = json["end_date"];
    startTime = json["start_time"];
    endTime = json["end_time"];
    minBidPrice = json["min_bid_price"];
    stepPrice = json["step_price"];
    currentBid = json["current_bid"];
    if (json['serviceTimeSloat'] != null) {
      serviceTimeSloat = <ServiceTimeSloat>[];
      json['serviceTimeSloat'].forEach((v) {
        serviceTimeSloat!.add(ServiceTimeSloat.fromJson(v));
      });
    }
    productAvailability =
    json['productAvailability'] != null ? ProductAvailability.fromJson(json['productAvailability']) : null;
    // if (json['attributes'] != null) {
    //   attributes = <Attributes>[];
    //   json['attributes'].forEach((v) {
    //     attributes!.add(Attributes.fromJson(v));
    //   });
    // }
    if (json['variants'] != null) {
      variants = <Variants>[];
      json['variants'].forEach((v) {
        variants!.add(Variants.fromJson(v));
      });
    } else {
      variants = [];
    }
    bidStatus = json["bid_status"];
    discountPercentage = json["discount_percentage"] ??
        ((((pPrice.toString().toNum - sPrice.toString().toNum) / pPrice.toString().toNum) * 100).toStringAsFixed(2));
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "vendor_id": vendorId,
    "virtual_product_type": virtualProductType,
    "cat_id": catId,
    "cat_id_2": catId2,
    "cat_id_3": catId3,
    "brand_slug": brandSlug,
    "slug": slug,
    "pname": pName,
    'is_shipping' : isShipping,
    'feature_image_app' : featureImageApp,
    if (serviceTimeSloat != null) 'serviceTimeSloat': serviceTimeSloat!.map((v) => v.toJson()).toList(),
    if (productAvailability != null) 'productAvailability': productAvailability!.toJson(),
    "add_to_cart": addToCart,
    "arab_pname": arabPname,
    'virtual_product_file' : virtualProductFile,
    'virtual_product_file_type' : virtualProductFileType,
    "product_type": productType,
    "sku_id": skuId,
    "p_price": pPrice,
    "s_price": sPrice,
    "commission": commission,
    'before_purchase' : beforePurchase,
    "new": productNew,
   'already_review': alreadyReview,
    "best_saller": bestSaller,
    "featured": featured,
    "tax_apply": taxApply,
    "tax_type": taxType,
    "short_description": shortDescription,
    "arab_short_description": arabShortDescription,
    "long_description": longDescription,
    "arab_long_description": arabLongDescription,
    "featured_image": featuredImage,
    "gallery_image": galleryImage == null ? [] : List<dynamic>.from(galleryImage!.map((x) => x)),
    "in_stock": inStock,
    "stock_alert": stockAlert,
    "shipping_type": shippingType,
    "shipping_charge": shippingCharge,
    "avg_rating": avgRating,
    "meta_title": metaTitle,
    "meta_keyword": metaKeyword,
    "meta_description": metaDescription,
    "parent_id": parentId,
    "service_start_time": serviceStartTime,
    "service_end_time": serviceEndTime,
    "service_duration": serviceDuration,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "top_hunderd": topHunderd,
    "return_days": returnDays,
    "is_publish": isPublish,
    "in_offer": inOffer,
    "for_auction": forAuction,
    "return_policy_desc": returnPolicyDesc,
    "discount_percentage": discountPercentage,
    "in_cart": inCart,
    "in_wishlist": inWishlist,
    "start_date": startDate,
    "end_date": endDate,
    "start_time": startTime,
    "end_time": endTime,
    "min_bid_price": minBidPrice,
    "step_price": stepPrice,
    "current_bid": currentBid,
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
    "bid_status": bidStatus,
    'local_shipping' : localShipping,
  };
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
    final Map<String, dynamic> data = <String, dynamic>{};
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
  dynamic image;

  Variants({this.id, this.comb, this.price, this.image});

  Variants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comb = json['comb'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['comb'] = comb;
    data['price'] = price;
    data['image'] = image;
    return data;
  }
}

class ServiceTimeSloat {
  String? timeSloat;
  String? timeSloatEnd;

  ServiceTimeSloat({this.timeSloat, this.timeSloatEnd});

  ServiceTimeSloat.fromJson(Map<String, dynamic> json) {
    timeSloat = json['time_sloat'];
    timeSloatEnd = json['time_sloat_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['time_sloat'] = timeSloat;
    data['time_sloat_end'] = timeSloatEnd;
    return data;
  }
}

class ProductAvailability {
  int? qty;
  String? type;
  String? fromDate;
  String? toDate;

  ProductAvailability({this.qty, this.type, this.fromDate, this.toDate});

  ProductAvailability.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    type = json['type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['qty'] = qty;
    data['type'] = type;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    return data;
  }
}