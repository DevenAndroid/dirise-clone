class VirtualProductModel {
  bool? status;
  String? message;
  ProductDetails? productDetails;

  VirtualProductModel({this.status, this.message, this.productDetails});

  VirtualProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productDetails = json['product_details'] != null
        ? new ProductDetails.fromJson(json['product_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.productDetails != null) {
      data['product_details'] = this.productDetails!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  Product? product;

  ProductDetails({this.product});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    return data;
  }
}

class Product {
  dynamic vendorId;
  String? productType;
  String? virtualProductType;
  dynamic sPrice;
  String? shortDescription;
  String? longDescription;
  String? inStock;
  dynamic isPublish;
  String? taxApply;
  String? bookingProductType;
  String? serialNumber;
  String? productNumber;
  String? metaTitle;
  String? metaDescription;
  String? spot;
  String? updatedAt;
  String? createdAt;
  dynamic id;
  dynamic discountPrice;

  Product(
      {this.vendorId,
        this.productType,
        this.virtualProductType,
        this.sPrice,
        this.shortDescription,
        this.longDescription,
        this.inStock,
        this.isPublish,
        this.taxApply,
        this.bookingProductType,
        this.serialNumber,
        this.productNumber,
        this.metaTitle,
        this.metaDescription,
        this.spot,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.discountPrice});

  Product.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    productType = json['product_type'];
    virtualProductType = json['virtual_product_type'];
    sPrice = json['s_price'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    inStock = json['in_stock'];
    isPublish = json['is_publish'];
    taxApply = json['tax_apply'];
    bookingProductType = json['booking_product_type'];
    serialNumber = json['serial_number'];
    productNumber = json['product_number'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    spot = json['spot'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    discountPrice = json['discount_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['product_type'] = this.productType;
    data['virtual_product_type'] = this.virtualProductType;
    data['s_price'] = this.sPrice;
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['in_stock'] = this.inStock;
    data['is_publish'] = this.isPublish;
    data['tax_apply'] = this.taxApply;
    data['booking_product_type'] = this.bookingProductType;
    data['serial_number'] = this.serialNumber;
    data['product_number'] = this.productNumber;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['spot'] = this.spot;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['discount_price'] = this.discountPrice;
    return data;
  }
}
