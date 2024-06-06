import 'package:dirise/model/product_model/model_product_element.dart';

class ModelFilterByPrice {
  bool? status;
  dynamic message;
  List<ProductElement>? product;

  ModelFilterByPrice({this.status, this.message, this.product});

  ModelFilterByPrice.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['product'] != null) {
      product = <ProductElement>[];
      json['product'].forEach((v) { product!.add(new ProductElement.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  dynamic id;
  dynamic vendorId;
  dynamic catId;
 dynamic catId2;
 dynamic catId3;
  dynamic brandSlug;
  dynamic slug;
  dynamic pname;
 dynamic prodectImage;
 dynamic prodectName;
 dynamic prodectSku;
 dynamic views;
 dynamic code;
 dynamic bookingProductType;
 dynamic prodectPrice;
 dynamic prodectMinQty;
 dynamic prodectMixQty;
 dynamic prodectDescription;
  dynamic image;
 dynamic arabPname;
  dynamic productType;
  dynamic virtualProductType;
  dynamic skuId;
  dynamic pPrice;
  dynamic sPrice;
  dynamic commission;
  dynamic bestSaller;
  dynamic featured;
  dynamic taxApply;
  dynamic taxType;
  dynamic shortDescription;
 dynamic arabShortDescription;
  dynamic longDescription;
 dynamic arabLongDescription;
  dynamic featuredImage;
  List<String>? galleryImage;
  dynamic virtualProductFile;
  dynamic virtualProductFileType;
  dynamic virtualProductFileLanguage;
  dynamic featureImageApp;
  dynamic featureImageWeb;
  dynamic inStock;
  dynamic weight;
  dynamic weightUnit;
  dynamic time;
  dynamic timePeriod;
  dynamic stockAlert;
  dynamic keyword;
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
  dynamic createdAt;
  dynamic updatedAt;
  dynamic topHunderd;
  dynamic limitedTimeDeal;
 dynamic returnDays;
  dynamic isPublish;
  dynamic inOffer;
  dynamic forAuction;
  dynamic returnPolicyDesc;
  bool? addToCart;
  bool? inCart;
  bool? inWishlist;
  dynamic currencySign;
  dynamic currencyCode;
  Storemeta? storemeta;
  bool? allowBid;
  dynamic nextBidPrice;
  List<Attributes>? attributes;
  List<Variants>? variants;

  Product({this.id, this.vendorId, this.catId, this.catId2, this.catId3, this.brandSlug, this.slug, this.pname, this.prodectImage, this.prodectName, this.prodectSku, this.views, this.code, this.bookingProductType, this.prodectPrice, this.prodectMinQty, this.prodectMixQty, this.prodectDescription, this.image, this.arabPname, this.productType, this.virtualProductType, this.skuId, this.pPrice, this.sPrice, this.commission,this.bestSaller, this.featured, this.taxApply, this.taxType, this.shortDescription, this.arabShortDescription, this.longDescription, this.arabLongDescription, this.featuredImage, this.galleryImage, this.virtualProductFile, this.virtualProductFileType, this.virtualProductFileLanguage, this.featureImageApp, this.featureImageWeb, this.inStock, this.weight, this.weightUnit, this.time, this.timePeriod, this.stockAlert, this.keyword, this.shippingType, this.shippingCharge, this.avgRating, this.metaTitle, this.metaKeyword, this.metaDescription, this.parentId, this.serviceStartTime, this.serviceEndTime, this.serviceDuration, this.createdAt, this.updatedAt, this.topHunderd, this.limitedTimeDeal, this.returnDays, this.isPublish, this.inOffer, this.forAuction, this.returnPolicyDesc, this.addToCart, this.inCart, this.inWishlist, this.currencySign, this.currencyCode, this.storemeta, this.allowBid, this.nextBidPrice, this.attributes, this.variants});

Product.fromJson(Map<String, dynamic> json) {
id = json['id'];
vendorId = json['vendor_id'];
catId = json['cat_id'];
catId2 = json['cat_id_2'];
catId3 = json['cat_id_3'];
brandSlug = json['brand_slug'];
slug = json['slug'];
pname = json['pname'];
prodectImage = json['prodect_image'];
prodectName = json['prodect_name'];
prodectSku = json['prodect_sku'];
views = json['views'];
code = json['code'];
bookingProductType = json['booking_product_type'];
prodectPrice = json['prodect_price'];
prodectMinQty = json['prodect_min_qty'];
prodectMixQty = json['prodect_mix_qty'];
prodectDescription = json['prodect_description'];
image = json['image'];
arabPname = json['arab_pname'];
productType = json['product_type'];
virtualProductType = json['virtual_product_type'];
skuId = json['sku_id'];
pPrice = json['p_price'];
sPrice = json['s_price'];
commission = json['commission'];
bestSaller = json['best_saller'];
featured = json['featured'];
taxApply = json['tax_apply'];
taxType = json['tax_type'];
shortDescription = json['short_description'];
arabShortDescription = json['arab_short_description'];
longDescription = json['long_description'];
arabLongDescription = json['arab_long_description'];
featuredImage = json['featured_image'];
galleryImage = json['gallery_image'].cast<String>();
virtualProductFile = json['virtual_product_file'];
virtualProductFileType = json['virtual_product_file_type'];
virtualProductFileLanguage = json['virtual_product_file_language'];
featureImageApp = json['feature_image_app'];
featureImageWeb = json['feature_image_web'];
inStock = json['in_stock'];
weight = json['weight'];
weightUnit = json['weight_unit'];
time = json['time'];
timePeriod = json['time_period'];
stockAlert = json['stock_alert'];
keyword = json['keyword'];
shippingType = json['shipping_type'];
shippingCharge = json['shipping_charge'];
avgRating = json['avg_rating'];
metaTitle = json['meta_title'];
metaKeyword = json['meta_keyword'];
metaDescription = json['meta_description'];
parentId = json['parent_id'];
serviceStartTime = json['service_start_time'];
serviceEndTime = json['service_end_time'];
serviceDuration = json['service_duration'];
createdAt = json['created_at'];
updatedAt = json['updated_at'];
topHunderd = json['top_hunderd'];
limitedTimeDeal = json['limited_time_deal'];
returnDays = json['return_days'];
isPublish = json['is_publish'];
inOffer = json['in_offer'];
forAuction = json['for_auction'];
returnPolicyDesc = json['return_policy_desc'];
addToCart = json['add_to_cart'];
inCart = json['in_cart'];
inWishlist = json['in_wishlist'];
currencySign = json['currency_sign'];
currencyCode = json['currency_code'];
storemeta = json['storemeta'] != null ? new Storemeta.fromJson(json['storemeta']) : null;
allowBid = json['allow_bid'];
nextBidPrice = json['next_bid_price'];
if (json['attributes'] != null) {
attributes = <Attributes>[];
json['attributes'].forEach((v) { attributes!.add(new Attributes.fromJson(v)); });
}
if (json['variants'] != null) {
variants = <Variants>[];
json['variants'].forEach((v) { variants!.add(new Variants.fromJson(v)); });
}
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['vendor_id'] = this.vendorId;
data['cat_id'] = this.catId;
data['cat_id_2'] = this.catId2;
data['cat_id_3'] = this.catId3;
data['brand_slug'] = this.brandSlug;
data['slug'] = this.slug;
data['pname'] = this.pname;
data['prodect_image'] = this.prodectImage;
data['prodect_name'] = this.prodectName;
data['prodect_sku'] = this.prodectSku;
data['views'] = this.views;
data['code'] = this.code;
data['booking_product_type'] = this.bookingProductType;
data['prodect_price'] = this.prodectPrice;
data['prodect_min_qty'] = this.prodectMinQty;
data['prodect_mix_qty'] = this.prodectMixQty;
data['prodect_description'] = this.prodectDescription;
data['image'] = this.image;
data['arab_pname'] = this.arabPname;
data['product_type'] = this.productType;
data['virtual_product_type'] = this.virtualProductType;
data['sku_id'] = this.skuId;
data['p_price'] = this.pPrice;
data['s_price'] = this.sPrice;
data['commission'] = this.commission;
data['best_saller'] = this.bestSaller;
data['featured'] = this.featured;
data['tax_apply'] = this.taxApply;
data['tax_type'] = this.taxType;
data['short_description'] = this.shortDescription;
data['arab_short_description'] = this.arabShortDescription;
data['long_description'] = this.longDescription;
data['arab_long_description'] = this.arabLongDescription;
data['featured_image'] = this.featuredImage;
data['gallery_image'] = this.galleryImage;
data['virtual_product_file'] = this.virtualProductFile;
data['virtual_product_file_type'] = this.virtualProductFileType;
data['virtual_product_file_language'] = this.virtualProductFileLanguage;
data['feature_image_app'] = this.featureImageApp;
data['feature_image_web'] = this.featureImageWeb;
data['in_stock'] = this.inStock;
data['weight'] = this.weight;
data['weight_unit'] = this.weightUnit;
data['time'] = this.time;
data['time_period'] = this.timePeriod;
data['stock_alert'] = this.stockAlert;
data['keyword'] = this.keyword;
data['shipping_type'] = this.shippingType;
data['shipping_charge'] = this.shippingCharge;
data['avg_rating'] = this.avgRating;
data['meta_title'] = this.metaTitle;
data['meta_keyword'] = this.metaKeyword;
data['meta_description'] = this.metaDescription;
data['parent_id'] = this.parentId;
data['service_start_time'] = this.serviceStartTime;
data['service_end_time'] = this.serviceEndTime;
data['service_duration'] = this.serviceDuration;
data['created_at'] = this.createdAt;
data['updated_at'] = this.updatedAt;
data['top_hunderd'] = this.topHunderd;
data['limited_time_deal'] = this.limitedTimeDeal;
data['return_days'] = this.returnDays;
data['is_publish'] = this.isPublish;
data['in_offer'] = this.inOffer;
data['for_auction'] = this.forAuction;
data['return_policy_desc'] = this.returnPolicyDesc;
data['add_to_cart'] = this.addToCart;
data['in_cart'] = this.inCart;
data['in_wishlist'] = this.inWishlist;
data['currency_sign'] = this.currencySign;
data['currency_code'] = this.currencyCode;
if (this.storemeta != null) {
data['storemeta'] = this.storemeta!.toJson();
}
data['allow_bid'] = this.allowBid;
data['next_bid_price'] = this.nextBidPrice;
if (this.attributes != null) {
data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
}
if (this.variants != null) {
data['variants'] = this.variants!.map((v) => v.toJson()).toList();
}
return data;
}
}

class Storemeta {
dynamic firstName;
dynamic lastName;
dynamic storeId;
dynamic profileImg;
dynamic bannerImg;

Storemeta({this.firstName, this.lastName, this.storeId, this.profileImg, this.bannerImg});

Storemeta.fromJson(Map<String, dynamic> json) {
firstName = json['first_name'];
lastName = json['last_name'];
storeId = json['store_id'];
profileImg = json['profile_img'];
bannerImg = json['banner_img'];
}

Map<String, dynamic> toJson() {
final Map<String, dynamic> data = new Map<String, dynamic>();
data['first_name'] = this.firstName;
data['last_name'] = this.lastName;
data['store_id'] = this.storeId;
data['profile_img'] = this.profileImg;
data['banner_img'] = this.bannerImg;
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
data['id'] = this.id;
data['name'] = this.name;
data['values'] = this.values;
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
final Map<String, dynamic> data = new Map<String, dynamic>();
data['id'] = this.id;
data['comb'] = this.comb;
data['price'] = this.price;
data['image'] = this.image;
return data;
}
}
