class DateRangeInTravelModel {
  bool? status;
  String? message;
  ProductDetails? productDetails;

  DateRangeInTravelModel({this.status, this.message, this.productDetails});

  DateRangeInTravelModel.fromJson(Map<String, dynamic> json) {
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
  ProductAvailabilityId? productAvailabilityId;

  ProductDetails({this.product, this.productAvailabilityId});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    productAvailabilityId = json['product_availability_id'] != null
        ? new ProductAvailabilityId.fromJson(json['product_availability_id'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.productAvailabilityId != null) {
      data['product_availability_id'] = this.productAvailabilityId!.toJson();
    }
    return data;
  }
}

class Product {
  dynamic vendorId;
  dynamic productType;
  dynamic sPrice;
  dynamic shortDescription;
  dynamic longDescription;
  dynamic inStock;
  dynamic taxApply;
  dynamic bookingProductType;
  dynamic serialNumber;
  dynamic productNumber;
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic bookableProductLocation;
  dynamic hostName;
  dynamic programName;
  dynamic programGoal;
  dynamic programDesc;
  dynamic eligibleMinAge;
  dynamic eligibleMaxAge;
  dynamic eligibleGender;
  dynamic spot;
  dynamic startLocation;
  dynamic endLocation;
  dynamic timingExtraNotes;
  dynamic pickupPolicyId;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic id;
  dynamic  discountPrice;

  Product(
      {this.vendorId,
        this.productType,
        this.sPrice,
        this.shortDescription,
        this.longDescription,
        this.inStock,
        this.taxApply,
        this.bookingProductType,
        this.serialNumber,
        this.productNumber,
        this.metaTitle,
        this.metaDescription,
        this.bookableProductLocation,
        this.hostName,
        this.programName,
        this.programGoal,
        this.programDesc,
        this.eligibleMinAge,
        this.eligibleMaxAge,
        this.eligibleGender,
        this.spot,
        this.startLocation,
        this.endLocation,
        this.timingExtraNotes,
        this.pickupPolicyId,
        this.updatedAt,
        this.createdAt,
        this.id,
        this.discountPrice});

  Product.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    productType = json['product_type'];
    sPrice = json['s_price'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    inStock = json['in_stock'];
    taxApply = json['tax_apply'];
    bookingProductType = json['booking_product_type'];
    serialNumber = json['serial_number'];
    productNumber = json['product_number'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    bookableProductLocation = json['bookable_product_location'];
    hostName = json['host_name'];
    programName = json['program_name'];
    programGoal = json['program_goal'];
    programDesc = json['program_desc'];
    eligibleMinAge = json['eligible_min_age'];
    eligibleMaxAge = json['eligible_max_age'];
    eligibleGender = json['eligible_gender'];
    spot = json['spot'];
    startLocation = json['start_location'];
    endLocation = json['end_location'];
    timingExtraNotes = json['timing_extra_notes'];
    pickupPolicyId = json['pickup_policy_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
    discountPrice = json['discount_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['product_type'] = this.productType;
    data['s_price'] = this.sPrice;
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['in_stock'] = this.inStock;
    data['tax_apply'] = this.taxApply;
    data['booking_product_type'] = this.bookingProductType;
    data['serial_number'] = this.serialNumber;
    data['product_number'] = this.productNumber;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['bookable_product_location'] = this.bookableProductLocation;
    data['host_name'] = this.hostName;
    data['program_name'] = this.programName;
    data['program_goal'] = this.programGoal;
    data['program_desc'] = this.programDesc;
    data['eligible_min_age'] = this.eligibleMinAge;
    data['eligible_max_age'] = this.eligibleMaxAge;
    data['eligible_gender'] = this.eligibleGender;
    data['spot'] = this.spot;
    data['start_location'] = this.startLocation;
    data['end_location'] = this.endLocation;
    data['timing_extra_notes'] = this.timingExtraNotes;
    data['pickup_policy_id'] = this.pickupPolicyId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    data['discount_price'] = this.discountPrice;
    return data;
  }
}

class ProductAvailabilityId {
  int? productId;
  int? vendorId;
  String? qty;
  String? type;
  String? fromDate;
  String? toDate;
  String? updatedAt;
  String? createdAt;
  int? id;

  ProductAvailabilityId(
      {this.productId,
        this.vendorId,
        this.qty,
        this.type,
        this.fromDate,
        this.toDate,
        this.updatedAt,
        this.createdAt,
        this.id});

  ProductAvailabilityId.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    qty = json['qty'];
    type = json['type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['vendor_id'] = this.vendorId;
    data['qty'] = this.qty;
    data['type'] = this.type;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
