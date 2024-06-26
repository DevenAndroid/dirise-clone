class ModelProductDetails {
  bool? status;
  dynamic message;
  ProductDetails? productDetails;

  ModelProductDetails({this.status, this.message, this.productDetails});

  ModelProductDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productDetails = json['product_details'] != null ? new ProductDetails.fromJson(json['product_details']) : null;
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
  dynamic diriseFess;

  ProductDetails({this.product, this.address, this.productDimentions,this.diriseFess});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    productDimentions =
        json['product_dimentions'] != null ? ProductDimentions.fromJson(json['product_dimentions']) : null;
    diriseFess = json['dirise_fess'];
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
    data['dirise_fess'] = this.diriseFess;
    return data;
  }
}

class Product {
  dynamic id;
  dynamic spot;
  dynamic fromLocation;
  dynamic toLocation;
  dynamic fromExtraNotes;
  dynamic toExtraNotes;
  dynamic meeting_platform;
  dynamic eligible_min_age;
  dynamic eligible_max_age;
  dynamic eligible_gender;
  dynamic host_name;
  dynamic program_name;
  dynamic program_goal;
  dynamic program_desc;
  dynamic bookable_product_location;
  dynamic jobCountry;
  dynamic jobState;
  dynamic jobCity;
  dynamic vendorId;
  dynamic addressId;
  dynamic catId;
  dynamic catId2;
  dynamic jobCat;
  dynamic jobParentCat;
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
  dynamic itemType;
  dynamic virtualProductType;
  dynamic skuId;
  dynamic pPrice;
  dynamic sPrice;
  dynamic commission;
  dynamic newP;
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
  dynamic shippingType;
  dynamic shippingCharge;
  dynamic avgRating;
  dynamic metaTitle;
  dynamic metaKeyword;
  dynamic metaDescription;
  dynamic metaTags;
  dynamic seoTags;
  dynamic parentId;
  dynamic serviceStartTime;
  dynamic serviceEndTime;
  dynamic serviceDuration;
  dynamic deliverySize;
  dynamic serialNumber;
  dynamic productNumber;
  dynamic productCode;
  dynamic promotionCode;
  dynamic packageDetail;
  dynamic jobseekingOrOffering;
  dynamic jobType;
  dynamic jobModel;
  dynamic describeJobRole;
  dynamic linkdinUrl;
  dynamic experience;
  dynamic salary;
  dynamic aboutYourself;
  dynamic jobHours;
  dynamic uploadCv;
  dynamic isOnsale;
  dynamic discountPercent;
  dynamic fixedDiscountPrice;
  dynamic shippingPay;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic topHunderd;
  dynamic limitedTimeDeal;
  dynamic returnDays;
  dynamic keyword;
  dynamic isPublish;
  dynamic inOffer;
  dynamic forAuction;
  dynamic shippingPolicyDesc;
  dynamic discountPrice;
  dynamic startLocation;
  dynamic endLocation;
  dynamic timingExtraNotes;
  ReturnPolicyDesc? returnPolicyDesc;
  ServiceTimeSloat? serviceTimeSloat;
  ProductAvailability? productAvailability;
  List<ProductWeeklyAvailability>? productWeeklyAvailability;
  List<ProductVacation>? productVacation;

  Product(
      {this.id,
      this.spot,
        this.fromLocation,
        this.toLocation,
        this.fromExtraNotes,
        this.toExtraNotes,
      this.meeting_platform,
      this.serviceTimeSloat,
      this.startLocation,
      this.endLocation,
      this.timingExtraNotes,
      this.eligible_min_age,
      this.eligible_max_age,
      this.eligible_gender,
      this.host_name,
      this.program_name,
      this.program_desc,
      this.program_goal,
      this.bookable_product_location,
      this.jobCountry,
      this.jobState,
      this.jobCity,
      this.vendorId,
      this.addressId,
      this.catId,
      this.catId2,
      this.jobCat,
      this.jobParentCat,
      this.brandSlug,
      this.slug,
      this.pname,
      this.prodectImage,
      this.prodectName,
      this.prodectSku,
      this.views,
      this.code,
      this.bookingProductType,
      this.prodectPrice,
      this.prodectMinQty,
      this.prodectMixQty,
      this.prodectDescription,
      this.image,
      this.arabPname,
      this.productType,
      this.itemType,
      this.virtualProductType,
      this.skuId,
      this.pPrice,
      this.sPrice,
      this.commission,
      this.newP,
      this.bestSaller,
      this.featured,
      this.taxApply,
      this.taxType,
      this.shortDescription,
      this.arabShortDescription,
      this.longDescription,
      this.arabLongDescription,
      this.featuredImage,
      this.galleryImage,
      this.virtualProductFile,
      this.virtualProductFileType,
      this.virtualProductFileLanguage,
      this.featureImageApp,
      this.featureImageWeb,
      this.inStock,
      this.weight,
      this.weightUnit,
      this.time,
      this.timePeriod,
      this.stockAlert,
      this.shippingType,
      this.shippingCharge,
      this.avgRating,
      this.metaTitle,
      this.metaKeyword,
      this.metaDescription,
      this.metaTags,
      this.seoTags,
      this.parentId,
      this.serviceStartTime,
      this.serviceEndTime,
      this.serviceDuration,
      this.deliverySize,
      this.serialNumber,
      this.productNumber,
      this.productCode,
      this.promotionCode,
      this.packageDetail,
      this.jobseekingOrOffering,
      this.jobType,
      this.jobModel,
      this.describeJobRole,
      this.linkdinUrl,
      this.experience,
      this.salary,
      this.aboutYourself,
      this.jobHours,
      this.uploadCv,
      this.isOnsale,
      this.discountPercent,
      this.fixedDiscountPrice,
      this.shippingPay,
      this.createdAt,
      this.updatedAt,
      this.topHunderd,
      this.limitedTimeDeal,
      this.returnDays,
      this.keyword,
      this.isPublish,
      this.inOffer,
      this.forAuction,
      this.returnPolicyDesc,
      this.shippingPolicyDesc,
      this.discountPrice});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceTimeSloat =
        json['serviceTimeSloat'] != null ? new ServiceTimeSloat.fromJson(json['serviceTimeSloat']) : null;
    startLocation = json['start_location'];
    spot = json['spot'];
    fromLocation = json['from_location'];
    toLocation = json['to_location'];
    fromExtraNotes = json['from_extra_notes'];
    toExtraNotes = json['to_extra_notes'];
    meeting_platform = json['meeting_platform'];
    endLocation = json['end_location'];
    timingExtraNotes = json['timing_extra_notes'];
    eligible_min_age = json['eligible_min_age'];
    eligible_max_age = json['eligible_max_age'];
    eligible_gender = json['eligible_gender'];
    bookable_product_location = json['bookable_product_location'];
    host_name = json['host_name'];
    program_name = json['program_name'];
    program_goal = json['program_goal'];
    program_desc = json['program_desc'];
    vendorId = json['vendor_id'];
    jobCountry = json['job_country_id'];
    jobState = json['job_state_id'];
    jobCity = json['job_city_id'];
    addressId = json['address_id'];
    catId = json['cat_id'];
    catId2 = json['cat_id_2'];
    jobCat = json['job_cat'];
    jobParentCat = json['job_parent_category'];
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
    itemType = json['item_type'];
    virtualProductType = json['virtual_product_type'];
    skuId = json['sku_id'];
    pPrice = json['p_price'];
    sPrice = json['s_price'];
    commission = json['commission'];
    newP = json['newP'];
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
    shippingType = json['shipping_type'];
    shippingCharge = json['shipping_charge'];
    avgRating = json['avg_rating'];
    metaTitle = json['meta_title'];
    metaKeyword = json['meta_keyword'];
    metaDescription = json['meta_description'];
    metaTags = json['meta_tags'];
    seoTags = json['seo_tags'];
    parentId = json['parent_id'];
    serviceStartTime = json['service_start_time'];
    serviceEndTime = json['service_end_time'];
    serviceDuration = json['service_duration'];
    deliverySize = json['delivery_size'];
    serialNumber = json['serial_number'];
    productNumber = json['product_number'];
    productCode = json['product_code'];
    promotionCode = json['promotion_code'];
    packageDetail = json['package_detail'];
    jobseekingOrOffering = json['jobseeking_or_offering'];
    jobType = json['job_type'];
    jobModel = json['job_model'];
    describeJobRole = json['describe_job_role'];
    linkdinUrl = json['linkdin_url'];
    experience = json['experience'];
    salary = json['salary'];
    aboutYourself = json['about_yourself'];
    jobHours = json['job_hours'];
    uploadCv = json['upload_cv'];
    isOnsale = json['is_onsale'];
    discountPercent = json['discount_percent'];
    fixedDiscountPrice = json['fixed_discount_price'];
    shippingPay = json['shipping_pay'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    topHunderd = json['top_hunderd'];
    limitedTimeDeal = json['limited_time_deal'];
    returnDays = json['return_days'];
    keyword = json['keyword'];
    isPublish = json['is_publish'];
    inOffer = json['in_offer'];
    forAuction = json['for_auction'];

    returnPolicyDesc =
        json['return_policy_desc'] != null ? ReturnPolicyDesc.fromJson(json['return_policy_desc']) : null;

    shippingPolicyDesc = json['shipping_policy_desc'];
    discountPrice = json['discount_price'];
    productAvailability =
        json['productAvailability'] != null ? new ProductAvailability.fromJson(json['productAvailability']) : null;
    if (json['product_weekly_availability'] != null) {
      productWeeklyAvailability = <ProductWeeklyAvailability>[];
      json['product_weekly_availability'].forEach((v) {
        productWeeklyAvailability!.add(new ProductWeeklyAvailability.fromJson(v));
      });
    }
    if (json['product_vacation'] != null) {
      productVacation = <ProductVacation>[];
      json['product_vacation'].forEach((v) {
        productVacation!.add(new ProductVacation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['from_location'] = this.fromLocation;
    data['to_location'] = this.toLocation;
    data['from_extra_notes'] = this.fromExtraNotes;
    data['to_extra_notes'] = this.toExtraNotes;
    data['vendor_id'] = this.vendorId;
    data['address_id'] = this.addressId;
    data['cat_id'] = this.catId;
    data['cat_id_2'] = this.catId2;
    data['job_cat'] = this.jobCat;
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
    data['item_type'] = this.itemType;
    data['virtual_product_type'] = this.virtualProductType;
    data['sku_id'] = this.skuId;
    data['p_price'] = this.pPrice;
    data['s_price'] = this.sPrice;
    data['commission'] = this.commission;
    data['newP'] = this.newP;
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
    data['shipping_type'] = this.shippingType;
    data['shipping_charge'] = this.shippingCharge;
    data['avg_rating'] = this.avgRating;
    data['meta_title'] = this.metaTitle;
    data['meta_keyword'] = this.metaKeyword;
    data['meta_description'] = this.metaDescription;
    data['meta_tags'] = this.metaTags;
    data['seo_tags'] = this.seoTags;
    data['parent_id'] = this.parentId;
    data['service_start_time'] = this.serviceStartTime;
    data['service_end_time'] = this.serviceEndTime;
    data['service_duration'] = this.serviceDuration;
    data['delivery_size'] = this.deliverySize;
    data['serial_number'] = this.serialNumber;
    data['product_number'] = this.productNumber;
    data['product_code'] = this.productCode;
    data['promotion_code'] = this.promotionCode;
    data['package_detail'] = this.packageDetail;
    data['jobseeking_or_offering'] = this.jobseekingOrOffering;
    data['job_type'] = this.jobType;
    data['job_model'] = this.jobModel;
    data['describe_job_role'] = this.describeJobRole;
    data['linkdin_url'] = this.linkdinUrl;
    data['experience'] = this.experience;
    data['salary'] = this.salary;
    data['about_yourself'] = this.aboutYourself;
    data['job_hours'] = this.jobHours;
    data['upload_cv'] = this.uploadCv;
    data['is_onsale'] = this.isOnsale;
    data['discount_percent'] = this.discountPercent;
    data['fixed_discount_price'] = this.fixedDiscountPrice;
    data['shipping_pay'] = this.shippingPay;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['top_hunderd'] = this.topHunderd;
    data['limited_time_deal'] = this.limitedTimeDeal;
    data['return_days'] = this.returnDays;
    data['keyword'] = this.keyword;
    data['is_publish'] = this.isPublish;
    data['in_offer'] = this.inOffer;
    data['for_auction'] = this.forAuction;
    data['return_policy_desc'] = this.returnPolicyDesc;
    data['shipping_policy_desc'] = this.shippingPolicyDesc;
    data['discount_price'] = this.discountPrice;
    return data;
  }
}

class Address {
  dynamic id;
  dynamic userId;
  dynamic isLogin;
  dynamic giveawayId;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic companyName;
  dynamic orderId;
  dynamic phone;
  dynamic phoneCountryCode;
  dynamic alternatePhone;
  dynamic alterPhoneCountryCode;
  dynamic addressType;
  dynamic type;
  dynamic isDefault;
  dynamic address;
  dynamic address2;
  dynamic city;
  dynamic country;
  dynamic state;
  dynamic town;
  dynamic countryId;
  dynamic stateId;
  dynamic cityId;
  dynamic title;
  dynamic zipCode;
  dynamic instruction;
  dynamic landmark;
  dynamic createdAt;
  dynamic updatedAt;

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
  dynamic id;
  dynamic giveawayId;
  dynamic productId;
  dynamic weight;
  dynamic weightUnit;
  dynamic material;
  dynamic typeOfPackages;
  dynamic numberOfPackage;
  dynamic description;
  dynamic boxDimension;
  dynamic boxHeight;
  dynamic boxWidth;
  dynamic boxLength;
  dynamic units;
  dynamic createdAt;
  dynamic updatedAt;

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

class ProductAvailability {
  dynamic qty;
  dynamic type;
  dynamic fromDate;
  dynamic toDate;
  dynamic interval;
  dynamic preparationBlockTime;
  dynamic recoveryBlockTime;

  ProductAvailability(
      {this.qty,
      this.type,
      this.fromDate,
      this.toDate,
      this.interval,
      this.preparationBlockTime,
      this.recoveryBlockTime});

  ProductAvailability.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    type = json['type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    interval = json['interval'];
    preparationBlockTime = json['preparation_block_time'];
    recoveryBlockTime = json['recovery_block_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['type'] = this.type;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['interval'] = this.interval;
    data['preparation_block_time'] = this.preparationBlockTime;
    data['recovery_block_time'] = this.recoveryBlockTime;
    return data;
  }
}

class ProductWeeklyAvailability {
  dynamic id;
  dynamic weekDay;
  dynamic startTime;
  dynamic endTime;
  dynamic startBreakTime;
  dynamic endBreakTime;
  dynamic status;

  ProductWeeklyAvailability(
      {this.id, this.weekDay, this.startTime, this.endTime, this.startBreakTime, this.endBreakTime, this.status});

  ProductWeeklyAvailability.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weekDay = json['week_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    startBreakTime = json['start_break_time'];
    endBreakTime = json['end_break_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['week_day'] = this.weekDay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['start_break_time'] = this.startBreakTime;
    data['end_break_time'] = this.endBreakTime;
    data['status'] = this.status;
    return data;
  }
}

class ProductVacation {
  dynamic id;
  dynamic productId;
  dynamic productAvailabilityId;
  dynamic vendorId;
  dynamic vacationType;
  dynamic vacationFromDate;
  dynamic vacationToDate;

  ProductVacation(
      {this.id,
      this.productId,
      this.productAvailabilityId,
      this.vendorId,
      this.vacationType,
      this.vacationFromDate,
      this.vacationToDate});

  ProductVacation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productAvailabilityId = json['product_availability_id'];
    vendorId = json['vendor_id'];
    vacationType = json['vacation_type'];
    vacationFromDate = json['vacation_from_date'];
    vacationToDate = json['vacation_to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_availability_id'] = this.productAvailabilityId;
    data['vendor_id'] = this.vendorId;
    data['vacation_type'] = this.vacationType;
    data['vacation_from_date'] = this.vacationFromDate;
    data['vacation_to_date'] = this.vacationToDate;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_sloat'] = this.timeSloat;
    data['time_sloat_end'] = this.timeSloatEnd;
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
  dynamic noReturn;
  dynamic unit;
  dynamic isDefault;

  ReturnPolicyDesc(
      {this.id,
      this.userId,
      this.title,
      this.days,
      this.policyDiscreption,
      this.returnShippingFees,
      this.noReturn,
      this.unit,
      this.isDefault});

  ReturnPolicyDesc.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    title = json['title'];
    days = json['days'];
    policyDiscreption = json['policy_discreption'];
    returnShippingFees = json['return_shipping_fees'];
    noReturn = json['no_return'];
    unit = json['unit'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['days'] = this.days;
    data['policy_discreption'] = this.policyDiscreption;
    data['return_shipping_fees'] = this.returnShippingFees;
    data['no_return'] = this.noReturn;
    data['unit'] = this.unit;
    data['is_default'] = this.isDefault;
    return data;
  }
}
