class ReviewAndPublishResponseModel {
  bool? status;
 dynamic message;
  ProductDetails? productDetails;

  ReviewAndPublishResponseModel(
      {this.status, this.message, this.productDetails});

  ReviewAndPublishResponseModel.fromJson(Map<String, dynamic> json) {
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
  Address? address;
  Product? product;
  InternaionalShipping? internaionalShipping;

  ProductDetails({this.address, this.product, this.internaionalShipping});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    address =
    json['address'] != null ? new Address.fromJson(json['address']) : null;
    product =
    json['product'] != null ? new Product.fromJson(json['product']) : null;
    internaionalShipping = json['internaionalShipping'] != null
        ? new InternaionalShipping.fromJson(json['internaionalShipping'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.internaionalShipping != null) {
      data['internaionalShipping'] = this.internaionalShipping!.toJson();
    }
    return data;
  }
}

class Address {
  dynamic userId;
  dynamic address;
  dynamic city;
  dynamic state;
  dynamic zipCode;
  dynamic town;
  dynamic instruction;
 dynamic updatedAt;
 dynamic createdAt;
  dynamic id;

  Address(
      {this.userId,
        this.address,
        this.city,
        this.state,
        this.zipCode,
        this.town,
        this.instruction,
        this.updatedAt,
        this.createdAt,
        this.id});

  Address.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    address = json['address'];
    city = json['city'];
    state = json['state'];
    zipCode = json['zip_code'];
    town = json['town'];
    instruction = json['instruction'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['address'] = this.address;
    data['city'] = this.city;
    data['state'] = this.state;
    data['zip_code'] = this.zipCode;
    data['town'] = this.town;
    data['instruction'] = this.instruction;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class Product {
  dynamic vendorId;
 dynamic addressId;
  dynamic pname;
  dynamic productType;
 dynamic itemType;
 dynamic virtualProductType;
  dynamic skuId;
  dynamic catId;
  dynamic catId2;
  dynamic pPrice;
  dynamic sPrice;
  dynamic returnDays;
 dynamic returnPolicyDesc;
  dynamic shortDescription;
  dynamic longDescription;
  dynamic inStock;
  dynamic weight;
  dynamic weightUnit;
 dynamic time;
  dynamic timePeriod;
  dynamic isPublish;
 dynamic brandSlug;
 dynamic taxApply;
 dynamic taxType;
  dynamic stockAlert;
 dynamic keyword;
  dynamic bookingProductType;
  dynamic deliverySize;
  dynamic serialNumber;
  dynamic productNumber;
  dynamic metaTitle;
  dynamic metaDescription;
 dynamic jobseekingOrOffering;
 dynamic jobType;
 dynamic jobModel;
 dynamic linkdinUrl;
 dynamic experience;
 dynamic salary;
 dynamic jobHours;
  dynamic uploadCv;
 dynamic jobCat;
 dynamic describeJobRole;
 dynamic updatedAt;
 dynamic createdAt;
  dynamic id;

  Product(
      {this.vendorId,
        this.addressId,
        this.pname,
        this.productType,
        this.itemType,
        this.virtualProductType,
        this.skuId,
        this.catId,
        this.catId2,
        this.pPrice,
        this.sPrice,
        this.returnDays,
        this.returnPolicyDesc,
        this.shortDescription,
        this.longDescription,
        this.inStock,
        this.weight,
        this.weightUnit,
        this.time,
        this.timePeriod,
        this.isPublish,
        this.brandSlug,
        this.taxApply,
        this.taxType,
        this.stockAlert,
        this.keyword,
        this.bookingProductType,
        this.deliverySize,
        this.serialNumber,
        this.productNumber,
        this.metaTitle,
        this.metaDescription,
        this.jobseekingOrOffering,
        this.jobType,
        this.jobModel,
        this.linkdinUrl,
        this.experience,
        this.salary,
        this.jobHours,
        this.uploadCv,
        this.jobCat,
        this.describeJobRole,
        this.updatedAt,
        this.createdAt,
        this.id});

  Product.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    addressId = json['address_id'];
    pname = json['pname'];
    productType = json['product_type'];
    itemType = json['item_type'];
    virtualProductType = json['virtual_product_type'];
    skuId = json['sku_id'];
    catId = json['cat_id'];
    catId2 = json['cat_id_2'];
    pPrice = json['p_price'];
    sPrice = json['s_price'];
    returnDays = json['return_days'];
    returnPolicyDesc = json['return_policy_desc'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    inStock = json['in_stock'];
    weight = json['weight'];
    weightUnit = json['weight_unit'];
    time = json['time'];
    timePeriod = json['time_period'];
    isPublish = json['is_publish'];
    brandSlug = json['brand_slug'];
    taxApply = json['tax_apply'];
    taxType = json['tax_type'];
    stockAlert = json['stock_alert'];
    keyword = json['keyword'];
    bookingProductType = json['booking_product_type'];
    deliverySize = json['delivery_size'];
    serialNumber = json['serial_number'];
    productNumber = json['product_number'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    jobseekingOrOffering = json['jobseeking_or_offering'];
    jobType = json['job_type'];
    jobModel = json['job_model'];
    linkdinUrl = json['linkdin_url'];
    experience = json['experience'];
    salary = json['salary'];
    jobHours = json['job_hours'];
    uploadCv = json['upload_cv'];
    jobCat = json['job_cat'];
    describeJobRole = json['describe_job_role'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['address_id'] = this.addressId;
    data['pname'] = this.pname;
    data['product_type'] = this.productType;
    data['item_type'] = this.itemType;
    data['virtual_product_type'] = this.virtualProductType;
    data['sku_id'] = this.skuId;
    data['cat_id'] = this.catId;
    data['cat_id_2'] = this.catId2;
    data['p_price'] = this.pPrice;
    data['s_price'] = this.sPrice;
    data['return_days'] = this.returnDays;
    data['return_policy_desc'] = this.returnPolicyDesc;
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['in_stock'] = this.inStock;
    data['weight'] = this.weight;
    data['weight_unit'] = this.weightUnit;
    data['time'] = this.time;
    data['time_period'] = this.timePeriod;
    data['is_publish'] = this.isPublish;
    data['brand_slug'] = this.brandSlug;
    data['tax_apply'] = this.taxApply;
    data['tax_type'] = this.taxType;
    data['stock_alert'] = this.stockAlert;
    data['keyword'] = this.keyword;
    data['booking_product_type'] = this.bookingProductType;
    data['delivery_size'] = this.deliverySize;
    data['serial_number'] = this.serialNumber;
    data['product_number'] = this.productNumber;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['jobseeking_or_offering'] = this.jobseekingOrOffering;
    data['job_type'] = this.jobType;
    data['job_model'] = this.jobModel;
    data['linkdin_url'] = this.linkdinUrl;
    data['experience'] = this.experience;
    data['salary'] = this.salary;
    data['job_hours'] = this.jobHours;
    data['upload_cv'] = this.uploadCv;
    data['job_cat'] = this.jobCat;
    data['describe_job_role'] = this.describeJobRole;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}

class InternaionalShipping {
  dynamic productId;
  dynamic weight;
  dynamic weightUnit;
  dynamic material;
  dynamic typeOfPackages;
  dynamic description;
  dynamic boxDimension;
  dynamic numberOfPackage;
  dynamic units;
 dynamic updatedAt;
 dynamic createdAt;
  dynamic id;

  InternaionalShipping(
      {this.productId,
        this.weight,
        this.weightUnit,
        this.material,
        this.typeOfPackages,
        this.description,
        this.boxDimension,
        this.numberOfPackage,
        this.units,
        this.updatedAt,
        this.createdAt,
        this.id});

  InternaionalShipping.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    weight = json['weight'];
    weightUnit = json['weight_unit'];
    material = json['material'];
    typeOfPackages = json['type_of_packages'];
    description = json['description'];
    boxDimension = json['box_dimension'];
    numberOfPackage = json['number_of_package'];
    units = json['units'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['weight'] = this.weight;
    data['weight_unit'] = this.weightUnit;
    data['material'] = this.material;
    data['type_of_packages'] = this.typeOfPackages;
    data['description'] = this.description;
    data['box_dimension'] = this.boxDimension;
    data['number_of_package'] = this.numberOfPackage;
    data['units'] = this.units;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
