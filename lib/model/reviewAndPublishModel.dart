class ReviewAndPublishModel {
  bool? status;
  String? message;
  ProductDetails? productDetails;

  ReviewAndPublishModel({this.status, this.message, this.productDetails});

  ReviewAndPublishModel.fromJson(Map<String, dynamic> json) {
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
  Address? address;
  ProductDimentions? productDimentions;

  ProductDetails({this.product, this.address, this.productDimentions});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    if (json['product_dimentions'] != null) {
      if (json['product_dimentions'] is List) {
        // Handle list case
        // You can either iterate through the list and create ProductDimentions objects
        // Or handle it according to your data structure
      } else {
        productDimentions = ProductDimentions.fromJson(json['product_dimentions']);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.product != null) {
      data['product'] = this.product!.toJson();
    }
    if (this.address != null) {
      data['address'] = this.address!.toJson();
    }
    if (this.productDimentions != null) {
      data['product_dimentions'] = this.productDimentions!.toJson();
    }
    return data;
  }
}

class Product {
  dynamic addressId;
  dynamic catId;
  dynamic catId2;
  dynamic  brandSlug;
  dynamic   slug;
  dynamic   pname;
  dynamic  skuId;
  dynamic  prodectSku;
  dynamic  bookingProductType;
  dynamic  pPrice;
  dynamic  sPrice;
  dynamic   productType;
  dynamic   itemType;
  dynamic   virtualProductType;
  dynamic   shortDescription;
  dynamic   longDescription;
  dynamic   featuredImage;
  List<String>? galleryImage;
  List<String>? galleryTempData;
  dynamic    virtualProductFile;
  dynamic   virtualProductFileType;
  dynamic   virtualProductFileLanguage;
  dynamic  inStock;
  dynamic stockAlert;
  dynamic taxApply;
  dynamic  taxType;
  dynamic weight;
  dynamic weightUnit;
  dynamic metaTitle;
  dynamic metaDescription;
  dynamic deliverySize;
  dynamic serialNumber;
  dynamic productNumber;
  dynamic time;
  dynamic timePeriod;
  List<dynamic>? serviceTimeSloat;
  dynamic productAvailability;
  dynamic returnDays;
  List<dynamic>? variantData;

  Product(
      {this.addressId,
        this.catId,
        this.catId2,
        this.brandSlug,
        this.slug,
        this.pname,
        this.skuId,
        this.prodectSku,
        this.bookingProductType,
        this.pPrice,
        this.sPrice,
        this.productType,
        this.itemType,
        this.virtualProductType,
        this.shortDescription,
        this.longDescription,
        this.featuredImage,
        this.galleryImage,
        this.galleryTempData,
        this.virtualProductFile,
        this.virtualProductFileType,
        this.virtualProductFileLanguage,
        this.inStock,
        this.stockAlert,
        this.taxApply,
        this.taxType,
        this.weight,
        this.weightUnit,
        this.metaTitle,
        this.metaDescription,
        this.deliverySize,
        this.serialNumber,
        this.productNumber,
        this.time,
        this.timePeriod,
        this.serviceTimeSloat,
        this.productAvailability,
        this.returnDays,
        this.variantData});

  Product.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    catId = json['cat_id'];
    catId2 = json['cat_id_2'];
    brandSlug = json['brand_slug'];
    slug = json['slug'];
    pname = json['pname'];
    skuId = json['sku_id'];
    prodectSku = json['prodect_sku'];
    bookingProductType = json['booking_product_type'];
    pPrice = json['p_price'];
    sPrice = json['s_price'];
    productType = json['product_type'];
    itemType = json['item_type'];
    virtualProductType = json['virtual_product_type'];
    shortDescription = json['short_description'];
    longDescription = json['long_description'];
    featuredImage = json['featured_image'];
    galleryImage = json['gallery_image'] != null ? List<String>.from(json['gallery_image']) : null;
    galleryTempData = json['galleryTempData'] != null ? List<String>.from(json['galleryTempData']) : null;
    virtualProductFile = json['virtual_product_file'];
    virtualProductFileType = json['virtual_product_file_type'];
    virtualProductFileLanguage = json['virtual_product_file_language'];
    inStock = json['in_stock'];
    stockAlert = json['stock_alert'];
    taxApply = json['tax_apply'];
    taxType = json['tax_type'];
    weight = json['weight'];
    weightUnit = json['weight_unit'];
    metaTitle = json['meta_title'];
    metaDescription = json['meta_description'];
    deliverySize = json['delivery_size'];
    serialNumber = json['serial_number'];
    productNumber = json['product_number'];
    time = json['time'];
    timePeriod = json['time_period'];
    serviceTimeSloat = json['serviceTimeSloat'] != null ? List<dynamic>.from(json['serviceTimeSloat']) : null;
    productAvailability = json['productAvailability'];
    returnDays = json['return_days'];
    variantData = json['variant_data'] != null ? List<dynamic>.from(json['variant_data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address_id'] = this.addressId;
    data['cat_id'] = this.catId;
    data['cat_id_2'] = this.catId2;
    data['brand_slug'] = this.brandSlug;
    data['slug'] = this.slug;
    data['pname'] = this.pname;
    data['sku_id'] = this.skuId;
    data['prodect_sku'] = this.prodectSku;
    data['booking_product_type'] = this.bookingProductType;
    data['p_price'] = this.pPrice;
    data['s_price'] = this.sPrice;
    data['product_type'] = this.productType;
    data['item_type'] = this.itemType;
    data['virtual_product_type'] = this.virtualProductType;
    data['short_description'] = this.shortDescription;
    data['long_description'] = this.longDescription;
    data['featured_image'] = this.featuredImage;
    data['gallery_image'] = this.galleryImage;
    data['galleryTempData'] = this.galleryTempData;
    data['virtual_product_file'] = this.virtualProductFile;
    data['virtual_product_file_type'] = this.virtualProductFileType;
    data['virtual_product_file_language'] = this.virtualProductFileLanguage;
    data['in_stock'] = this.inStock;
    data['stock_alert'] = this.stockAlert;
    data['tax_apply'] = this.taxApply;
    data['tax_type'] = this.taxType;
    data['weight'] = this.weight;
    data['weight_unit'] = this.weightUnit;
    data['meta_title'] = this.metaTitle;
    data['meta_description'] = this.metaDescription;
    data['delivery_size'] = this.deliverySize;
    data['serial_number'] = this.serialNumber;
    data['product_number'] = this.productNumber;
    data['time'] = this.time;
    data['time_period'] = this.timePeriod;
    if (this.serviceTimeSloat != null) {
      data['serviceTimeSloat'] =
          this.serviceTimeSloat!.map((v) => v.toJson()).toList();
    }
    data['productAvailability'] = this.productAvailability;
    data['return_days'] = this.returnDays;
    if (this.variantData != null) {
      data['variant_data'] = this.variantData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  int? id;
  int? userId;
  String? isLogin;
  Null? giveawayId;
  Null? firstName;
  Null? lastName;
  Null? email;
  Null? companyName;
  Null? orderId;
  Null? phone;
  Null? phoneCountryCode;
  Null? alternatePhone;
  Null? alterPhoneCountryCode;
  String? addressType;
  String? type;
  bool? isDefault;
  String? address;
  Null? address2;
  String? city;
  Null? country;
  String? state;
  String? town;
  Null? countryId;
  Null? stateId;
  Null? cityId;
  Null? title;
  String? zipCode;
  String? instruction;
  Null? landmark;
  String? createdAt;
  String? updatedAt;

  Address(
      {this.id,
        this.userId,
        this.isLogin,
        this.giveawayId,
        this.firstName,
        this.lastName,
        this.email,
        this.companyName,
        this.orderId,
        this.phone,
        this.phoneCountryCode,
        this.alternatePhone,
        this.alterPhoneCountryCode,
        this.addressType,
        this.type,
        this.isDefault,
        this.address,
        this.address2,
        this.city,
        this.country,
        this.state,
        this.town,
        this.countryId,
        this.stateId,
        this.cityId,
        this.title,
        this.zipCode,
        this.instruction,
        this.landmark,
        this.createdAt,
        this.updatedAt});

  Address.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    isLogin = json['is_login'];
    giveawayId = json['giveaway_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    companyName = json['company_name'];
    orderId = json['order_id'];
    phone = json['phone'];
    phoneCountryCode = json['phone_country_code'];
    alternatePhone = json['alternate_phone'];
    alterPhoneCountryCode = json['alter_phone_country_code'];
    addressType = json['address_type'];
    type = json['type'];
    isDefault = json['is_default'];
    address = json['address'];
    address2 = json['address2'];
    city = json['city'];
    country = json['country'];
    state = json['state'];
    town = json['town'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    cityId = json['city_id'];
    title = json['title'];
    zipCode = json['zip_code'];
    instruction = json['instruction'];
    landmark = json['landmark'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['is_login'] = this.isLogin;
    data['giveaway_id'] = this.giveawayId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['company_name'] = this.companyName;
    data['order_id'] = this.orderId;
    data['phone'] = this.phone;
    data['phone_country_code'] = this.phoneCountryCode;
    data['alternate_phone'] = this.alternatePhone;
    data['alter_phone_country_code'] = this.alterPhoneCountryCode;
    data['address_type'] = this.addressType;
    data['type'] = this.type;
    data['is_default'] = this.isDefault;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['town'] = this.town;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['title'] = this.title;
    data['zip_code'] = this.zipCode;
    data['instruction'] = this.instruction;
    data['landmark'] = this.landmark;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProductDimentions {
  int? id;
  Null? giveawayId;
  int? productId;
  int? weight;
  String? weightUnit;
  String? material;
  String? typeOfPackages;
  Null? numberOfPackage;
  String? description;
  Null? boxDimension;
  int? boxHeight;
  int? boxWidth;
  int? boxLength;
  String? units;
  String? createdAt;
  String? updatedAt;

  ProductDimentions(
      {this.id,
        this.giveawayId,
        this.productId,
        this.weight,
        this.weightUnit,
        this.material,
        this.typeOfPackages,
        this.numberOfPackage,
        this.description,
        this.boxDimension,
        this.boxHeight,
        this.boxWidth,
        this.boxLength,
        this.units,
        this.createdAt,
        this.updatedAt});

  ProductDimentions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    giveawayId = json['giveaway_id'];
    productId = json['product_id'];
    weight = json['weight'];
    weightUnit = json['weight_unit'];
    material = json['material'];
    typeOfPackages = json['type_of_packages'];
    numberOfPackage = json['number_of_package'];
    description = json['description'];
    boxDimension = json['box_dimension'];
    boxHeight = json['box_height'];
    boxWidth = json['box_width'];
    boxLength = json['box_length'];
    units = json['units'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['giveaway_id'] = this.giveawayId;
    data['product_id'] = this.productId;
    data['weight'] = this.weight;
    data['weight_unit'] = this.weightUnit;
    data['material'] = this.material;
    data['type_of_packages'] = this.typeOfPackages;
    data['number_of_package'] = this.numberOfPackage;
    data['description'] = this.description;
    data['box_dimension'] = this.boxDimension;
    data['box_height'] = this.boxHeight;
    data['box_width'] = this.boxWidth;
    data['box_length'] = this.boxLength;
    data['units'] = this.units;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
