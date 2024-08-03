class ReleatedProductModel {
  bool? status;
  dynamic message;
  dynamic banner;
  RelatedProduct? relatedProduct;

  ReleatedProductModel(
      {this.status, this.message, this.banner, this.relatedProduct});

  ReleatedProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    banner = json['banner'];
    relatedProduct = json['related_product'] != null
        ? new RelatedProduct.fromJson(json['related_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['banner'] = this.banner;
    if (this.relatedProduct != null) {
      data['related_product'] = this.relatedProduct!.toJson();
    }
    return data;
  }
}

class RelatedProduct {
  List<Product>? product;

  RelatedProduct({this.product});

  RelatedProduct.fromJson(Map<String, dynamic> json) {
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  dynamic id;
  dynamic vendorId;
  dynamic addressId;
  dynamic pname;
  dynamic giveawayItemCondition;
  dynamic productType;
  dynamic itemType;
  dynamic pPrice;
  dynamic shortDescription;
  dynamic longDescription;
  dynamic featuredImage;
  List<String>? galleryImage;
  dynamic inStock;
  dynamic stockAlert;
  dynamic deliverySize;
  dynamic serialNumber;
  dynamic productNumber;
  dynamic productCode;
  dynamic promotionCode;
  dynamic packageDetail;
  dynamic virtualProductFile;
  bool? addToCart;
  bool? showcaseProduct;
  bool? inCart;
  bool? inWishlist;
  dynamic rating;
  // List<Null>? attributes;
  // List<Null>? variants;
  dynamic shippingDate;
  dynamic lowestDeliveryPrice;
  dynamic originalPPrice;
  dynamic discountPrice;
  dynamic discountOff;
  dynamic shippingPolicy;

  Product(
      {this.id,
        this.vendorId,
        this.addressId,
        this.pname,
        this.giveawayItemCondition,
        this.productType,
        this.itemType,
        this.pPrice,
        this.shortDescription,
        this.longDescription,
        this.featuredImage,
        this.galleryImage,
        this.inStock,
        this.stockAlert,
        this.deliverySize,
        this.serialNumber,
        this.productNumber,
        this.productCode,
        this.promotionCode,
        this.packageDetail,
        this.virtualProductFile,
        this.addToCart,
        this.showcaseProduct,
        this.inCart,
        this.inWishlist,
        this.rating,
        // this.attributes,
        // this.variants,
        this.shippingDate,
        this.lowestDeliveryPrice,
        this.originalPPrice,
        this.discountPrice,
        this.discountOff,
        this.shippingPolicy});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    addressId = json['address_id'];
    pname = json['pname'];
    giveawayItemCondition = json['giveaway_item_condition'];
    productType = json['product_type'];
    itemType = json['item_type'];
    pPrice = json['p_price'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    featuredImage = json['featured_image'];
    galleryImage = json['gallery_image'].cast<String>();
    inStock = json['in_stock'];
    stockAlert = json['stock_alert'];
    deliverySize = json['delivery_size'];
    serialNumber = json['serial_number'];
    productNumber = json['product_number'];
    productCode = json['product_code'];
    promotionCode = json['promotion_code'];
    packageDetail = json['package_detail'];
    virtualProductFile = json['virtual_product_file'];
    addToCart = json['add_to_cart'];
    showcaseProduct = json['showcase_product'];
    inCart = json['in_cart'];
    inWishlist = json['in_wishlist'];
    rating = json['rating'];
    // if (json['attributes'] != null) {
    //   attributes = <Null>[];
    //   json['attributes'].forEach((v) {
    //     attributes!.add(new Null.fromJson(v));
    //   });
    // }
    // if (json['variants'] != null) {
    //   variants = <Null>[];
    //   json['variants'].forEach((v) {
    //     variants!.add(new Null.fromJson(v));
    //   });
    // }
    shippingDate = json['shipping_date'];
    lowestDeliveryPrice = json['lowestDeliveryPrice'];
    originalPPrice = json['original_p_price'];
    discountPrice = json['discount_price'];
    discountOff = json['discount_off'];
    shippingPolicy = json['shipping_policy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['address_id'] = this.addressId;
    data['pname'] = this.pname;
    data['giveaway_item_condition'] = this.giveawayItemCondition;
    data['product_type'] = this.productType;
    data['item_type'] = this.itemType;
    data['p_price'] = this.pPrice;
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['featured_image'] = this.featuredImage;
    data['gallery_image'] = this.galleryImage;
    data['in_stock'] = this.inStock;
    data['stock_alert'] = this.stockAlert;
    data['delivery_size'] = this.deliverySize;
    data['serial_number'] = this.serialNumber;
    data['product_number'] = this.productNumber;
    data['product_code'] = this.productCode;
    data['promotion_code'] = this.promotionCode;
    data['package_detail'] = this.packageDetail;
    data['virtual_product_file'] = this.virtualProductFile;
    data['add_to_cart'] = this.addToCart;
    data['showcase_product'] = this.showcaseProduct;
    data['in_cart'] = this.inCart;
    data['in_wishlist'] = this.inWishlist;
    data['rating'] = this.rating;
    // if (this.attributes != null) {
    //   data['attributes'] = this.attributes!.map((v) => v.toJson()).toList();
    // }
    // if (this.variants != null) {
    //   data['variants'] = this.variants!.map((v) => v.toJson()).toList();
    // }
    data['shipping_date'] = this.shippingDate;
    data['lowestDeliveryPrice'] = this.lowestDeliveryPrice;
    data['original_p_price'] = this.originalPPrice;
    data['discount_price'] = this.discountPrice;
    data['discount_off'] = this.discountOff;
    data['shipping_policy'] = this.shippingPolicy;
    return data;
  }
}
