class ModelProductDetails {
  bool? status;
  dynamic message;
  ProductDetails? productDetails;

  ModelProductDetails({this.status, this.message, this.productDetails});

  ModelProductDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    productDetails = json['product_details'] != null ? ProductDetails.fromJson(json['product_details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (productDetails != null) {
      data['product_details'] = productDetails!.toJson();
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (product != null) {
      data['product'] = product!.toJson();
    }
    if (address != null) {
      data['address'] = address!.toJson();
    }
    if (productDimentions != null) {
      data['product_dimentions'] = productDimentions!.toJson();
    }
    data['dirise_fess'] = diriseFess;
    return data;
  }
}

class Product {
  dynamic id;
  dynamic noNeedStock;
  dynamic spot;
  dynamic giveawayItemCondition;
  dynamic fromLocation;
  dynamic toLocation;
  dynamic fromExtraNotes;
  dynamic toExtraNotes;
  dynamic catName;
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
  dynamic meetingPlatform;
  dynamic meetingPlatform2;
  dynamic timingExtraNotes2;
  dynamic timingExtraNotes;
  dynamic vendorId;
  dynamic addressId;
  dynamic jobCountryId;
  dynamic jobStateId;
  dynamic jobCityId;
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
  dynamic jobCountryName;
  dynamic jobStateName;
  dynamic jobCityName;
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
  dynamic additionalDate;
  ReturnPolicyDesc? returnPolicyDesc;
  List<ServiceTimeSloat>? serviceTimeSloat;
  ProductAvailability? productAvailability;
  List<ProductWeeklyAvailability>? productWeeklyAvailability;
  List<ProductVacation>? productVacation;
  JobCategory? jobCategory;
  ProductSponsors? productSponsors;
  Product(
      {this.id,
      this.spot,
        this.fromLocation,
        this.toLocation,
        this.meetingPlatform2,
        this.timingExtraNotes2,
        this.additionalDate,
        this.fromExtraNotes,
        this.meetingPlatform,
        this.toExtraNotes,
        this.giveawayItemCondition,
      this.meeting_platform,
      this.serviceTimeSloat,
        this.catName,
      this.startLocation,
      this.endLocation,
      this.jobCountryId,
      this.jobStateId,
      this.jobCityId,
      this.timingExtraNotes,
      this.eligible_min_age,
      this.eligible_max_age,
      this.eligible_gender,
      this.host_name,
      this.program_name,
      this.noNeedStock,
      this.program_desc,
      this.program_goal,
      this.jobCountryName,
      this.jobStateName,
      this.jobCityName,
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
      this.jobCategory,
      this.productSponsors,
      this.discountPrice});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['serviceTimeSloat'] != null) {
      serviceTimeSloat = <ServiceTimeSloat>[];
      json['serviceTimeSloat'].forEach((v) {
        serviceTimeSloat!.add(ServiceTimeSloat.fromJson(v));
      });
    }
    startLocation = json['start_location'];
    spot = json['spot'];
    fromLocation = json['from_location'];
    toLocation = json['to_location'];
    additionalDate = json['additional_date'];
    fromExtraNotes = json['from_extra_notes'];
    toExtraNotes = json['to_extra_notes'];
    meeting_platform = json['meeting_platform'];
    endLocation = json['end_location'];
    catName = json['cat_name'];
    timingExtraNotes = json['timing_extra_notes'];
    eligible_min_age = json['eligible_min_age'];
    jobCountryId = json['job_country_id'];
    meetingPlatform2 = json['meeting_platform_2'];
    timingExtraNotes2 = json['timing_extra_notes_2'];
    jobStateId = json['job_state_id'];
    jobCityId = json['job_city_id'];
    eligible_max_age = json['eligible_max_age'];
    eligible_gender = json['eligible_gender'];
    bookable_product_location = json['bookable_product_location'];
    host_name = json['host_name'];
    giveawayItemCondition = json['giveaway_item_condition'];
    program_name = json['program_name'];
    program_goal = json['program_goal'];
    program_desc = json['program_desc'];
    vendorId = json['vendor_id'];
    jobCountry = json['job_country_id'];
    meetingPlatform = json['meeting_platform'];
    jobState = json['job_state_id'];
    jobCity = json['job_city_id'];
    jobCountryName = json['job_country_name'];
    jobStateName = json['job_state_name'];
    jobCityName = json['job_city_name'];
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
    noNeedStock = json['no_need_stock'];
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
    jobCategory = json['job_category'] != null
        ? JobCategory.fromJson(json['job_category'])
        : null;
    productSponsors = json['product_sponsors'] != null
        ? ProductSponsors.fromJson(json['product_sponsors'])
        : null;
    returnPolicyDesc =
        json['return_policy_desc'] != null ? ReturnPolicyDesc.fromJson(json['return_policy_desc']) : null;

    shippingPolicyDesc = json['shipping_policy_desc'];
    discountPrice = json['discount_price'];
    productAvailability =
        json['productAvailability'] != null ? ProductAvailability.fromJson(json['productAvailability']) : null;
    if (json['product_weekly_availability'] != null) {
      productWeeklyAvailability = <ProductWeeklyAvailability>[];
      json['product_weekly_availability'].forEach((v) {
        productWeeklyAvailability!.add(ProductWeeklyAvailability.fromJson(v));
      });
    }
    if (json['product_vacation'] != null) {
      productVacation = <ProductVacation>[];
      json['product_vacation'].forEach((v) {
        productVacation!.add(ProductVacation.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['from_location'] = fromLocation;
    data['to_location'] = toLocation;
    data['from_extra_notes'] = fromExtraNotes;
    data['to_extra_notes'] = toExtraNotes;
    data['vendor_id'] = vendorId;
    data['address_id'] = addressId;
    data['cat_id'] = catId;
    data['cat_id_2'] = catId2;
    data['job_cat'] = jobCat;
    data['additional_date'] = additionalDate;
    data['meeting_platform'] = meetingPlatform;
    data['no_need_stock'] = noNeedStock;
    data['meeting_platform_2'] = meetingPlatform2;
    data['timing_extra_notes_2'] = timingExtraNotes2;
    data['brand_slug'] = brandSlug;
    data['cat_name'] = catName;
    data['slug'] = slug;
    data['pname'] = pname;
    data['job_country_id'] = jobCountryId;
    data['job_state_id'] = jobStateId;
    data['job_city_id'] = jobCityId;
    data['prodect_image'] = prodectImage;
    data['prodect_name'] = prodectName;
    data['prodect_sku'] = prodectSku;
    data['views'] = views;
    data['job_country_name'] = jobCountryName;
    data['job_state_name'] = jobStateName;
    data['job_city_name'] = jobCityName;
    data['code'] = code;
    data['booking_product_type'] = bookingProductType;
    data['prodect_price'] = prodectPrice;
    data['prodect_min_qty'] = prodectMinQty;
    data['prodect_mix_qty'] = prodectMixQty;
    data['prodect_description'] = prodectDescription;
    data['image'] = image;
    data['arab_pname'] = arabPname;
    data['product_type'] = productType;
    data['item_type'] = itemType;
    data['virtual_product_type'] = virtualProductType;
    data['sku_id'] = skuId;
    data['p_price'] = pPrice;
    data['s_price'] = sPrice;
    data['commission'] = commission;
    data['newP'] = newP;
    data['best_saller'] = bestSaller;
    data['featured'] = featured;
    data['tax_apply'] = taxApply;
    data['tax_type'] = taxType;
    data['short_description'] = shortDescription;
    data['arab_short_description'] = arabShortDescription;
    data['long_description'] = longDescription;
    data['arab_long_description'] = arabLongDescription;
    data['featured_image'] = featuredImage;
    data['gallery_image'] = galleryImage;
    data['virtual_product_file'] = virtualProductFile;
    data['virtual_product_file_type'] = virtualProductFileType;
    data['giveaway_item_condition'] = giveawayItemCondition;
    data['virtual_product_file_language'] = virtualProductFileLanguage;
    data['feature_image_app'] = featureImageApp;
    data['feature_image_web'] = featureImageWeb;
    data['in_stock'] = inStock;
    data['weight'] = weight;
    data['weight_unit'] = weightUnit;
    data['time'] = time;
    data['time_period'] = timePeriod;
    data['stock_alert'] = stockAlert;
    data['shipping_type'] = shippingType;
    data['shipping_charge'] = shippingCharge;
    data['avg_rating'] = avgRating;
    data['meta_title'] = metaTitle;
    data['meta_keyword'] = metaKeyword;
    data['meta_description'] = metaDescription;
    data['meta_tags'] = metaTags;
    data['seo_tags'] = seoTags;
    data['parent_id'] = parentId;
    data['service_start_time'] = serviceStartTime;
    data['service_end_time'] = serviceEndTime;
    data['service_duration'] = serviceDuration;
    data['delivery_size'] = deliverySize;
    data['serial_number'] = serialNumber;
    data['product_number'] = productNumber;
    data['product_code'] = productCode;
    data['promotion_code'] = promotionCode;
    data['package_detail'] = packageDetail;
    data['jobseeking_or_offering'] = jobseekingOrOffering;
    data['job_type'] = jobType;
    data['job_model'] = jobModel;
    data['describe_job_role'] = describeJobRole;
    data['linkdin_url'] = linkdinUrl;
    data['experience'] = experience;
    data['salary'] = salary;
    data['about_yourself'] = aboutYourself;
    data['job_hours'] = jobHours;
    data['upload_cv'] = uploadCv;
    data['is_onsale'] = isOnsale;
    data['discount_percent'] = discountPercent;
    data['fixed_discount_price'] = fixedDiscountPrice;
    data['shipping_pay'] = shippingPay;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['top_hunderd'] = topHunderd;
    data['limited_time_deal'] = limitedTimeDeal;
    data['return_days'] = returnDays;
    data['keyword'] = keyword;
    data['is_publish'] = isPublish;
    data['in_offer'] = inOffer;
    data['for_auction'] = forAuction;
    data['return_policy_desc'] = returnPolicyDesc;
    data['shipping_policy_desc'] = shippingPolicyDesc;
    data['discount_price'] = discountPrice;
    if (serviceTimeSloat != null) {
      data['serviceTimeSloat'] =
          serviceTimeSloat!.map((v) => v.toJson()).toList();
    }
    if (productSponsors != null) {
      data['product_sponsors'] = productSponsors!.toJson();
    }
    if (jobCategory != null) {
      data['job_category'] = jobCategory!.toJson();
    }
    return data;
  }
}
class ProductSponsors {
  dynamic id;
  dynamic vendorId;
  dynamic sponsorType;
  dynamic sponsorName;
  dynamic sponsorLogo;

  ProductSponsors(
      {this.id,
        this.vendorId,
        this.sponsorType,
        this.sponsorName,
        this.sponsorLogo});

  ProductSponsors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    sponsorType = json['sponsor_type'];
    sponsorName = json['sponsor_name'];
    sponsorLogo = json['sponsor_logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['sponsor_type'] = sponsorType;
    data['sponsor_name'] = sponsorName;
    data['sponsor_logo'] = sponsorLogo;
    return data;
  }
}
class JobCategory {
 dynamic  id;
 dynamic  vendorId;
 dynamic  parentId;
 dynamic  vendorCategory;
 dynamic  level;
 dynamic   commision;
 dynamic  categoryImage;
 dynamic  categoryImageBanner;
 dynamic  discription;
 dynamic  arabDescription;
 dynamic   status;
 dynamic   title;
 dynamic   arabTitle;
 dynamic   slug;
 dynamic   createdAt;
 dynamic   updatedAt;

  JobCategory(
      {this.id,
        this.vendorId,
        this.parentId,
        this.vendorCategory,
        this.level,
        this.commision,
        this.categoryImage,
        this.categoryImageBanner,
        this.discription,
        this.arabDescription,
        this.status,
        this.title,
        this.arabTitle,
        this.slug,
        this.createdAt,
        this.updatedAt});

  JobCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    parentId = json['parent_id'];
    vendorCategory = json['vendor_category'];
    level = json['level'];
    commision = json['commision'];
    categoryImage = json['category_image'];
    categoryImageBanner = json['category_image_banner'];
    discription = json['discription'];
    arabDescription = json['arab_description'];
    status = json['status'];
    title = json['title'];
    arabTitle = json['arab_title'];
    slug = json['slug'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['parent_id'] = parentId;
    data['vendor_category'] = vendorCategory;
    data['level'] = level;
    data['commision'] = commision;
    data['category_image'] = categoryImage;
    data['category_image_banner'] = categoryImageBanner;
    data['discription'] = discription;
    data['arab_description'] = arabDescription;
    data['status'] = status;
    data['title'] = title;
    data['arab_title'] = arabTitle;
    data['slug'] = slug;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['is_login'] = isLogin;
    data['giveaway_id'] = giveawayId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['company_name'] = companyName;
    data['order_id'] = orderId;
    data['phone'] = phone;
    data['phone_country_code'] = phoneCountryCode;
    data['alternate_phone'] = alternatePhone;
    data['alter_phone_country_code'] = alterPhoneCountryCode;
    data['address_type'] = addressType;
    data['type'] = type;
    data['is_default'] = isDefault;
    data['address'] = address;
    data['address2'] = address2;
    data['city'] = city;
    data['country'] = country;
    data['state'] = state;
    data['town'] = town;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city_id'] = cityId;
    data['title'] = title;
    data['zip_code'] = zipCode;
    data['instruction'] = instruction;
    data['landmark'] = landmark;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['giveaway_id'] = giveawayId;
    data['product_id'] = productId;
    data['weight'] = weight;
    data['weight_unit'] = weightUnit;
    data['material'] = material;
    data['type_of_packages'] = typeOfPackages;
    data['number_of_package'] = numberOfPackage;
    data['description'] = description;
    data['box_dimension'] = boxDimension;
    data['box_height'] = boxHeight;
    data['box_width'] = boxWidth;
    data['box_length'] = boxLength;
    data['units'] = units;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
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
  dynamic preparationBlockTimeType;
  dynamic recoveryBlockTimeType;
  dynamic intervalType;


  ProductAvailability(
      {this.qty,
      this.type,
      this.fromDate,
      this.toDate,
      this.interval,
      this.preparationBlockTime,
      this.preparationBlockTimeType,
      this.recoveryBlockTimeType,
      this.intervalType,
      this.recoveryBlockTime});

  ProductAvailability.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    type = json['type'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    interval = json['interval'];
    preparationBlockTime = json['preparation_block_time'];
    recoveryBlockTime = json['recovery_block_time'];
    preparationBlockTimeType = json['preparation_block_time_type'];
    recoveryBlockTimeType = json['recovery_block_time_type'];
    intervalType = json['interval_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['qty'] = qty;
    data['type'] = type;
    data['from_date'] = fromDate;
    data['to_date'] = toDate;
    data['interval'] = interval;
    data['preparation_block_time'] = preparationBlockTime;
    data['recovery_block_time'] = recoveryBlockTime;
    data['preparation_block_time_type'] = preparationBlockTimeType;
    data['recovery_block_time_type'] = recoveryBlockTimeType;
    data['interval_type'] = intervalType;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['week_day'] = weekDay;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['start_break_time'] = startBreakTime;
    data['end_break_time'] = endBreakTime;
    data['status'] = status;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['product_id'] = productId;
    data['product_availability_id'] = productAvailabilityId;
    data['vendor_id'] = vendorId;
    data['vacation_type'] = vacationType;
    data['vacation_from_date'] = vacationFromDate;
    data['vacation_to_date'] = vacationToDate;
    return data;
  }
}

class ServiceTimeSloat {
  dynamic weekDay;
  dynamic date;
  dynamic timeSloat;
  dynamic timeSloatEnd;
  ServiceTimeSloat(
      {this.weekDay, this.date, this.timeSloat, this.timeSloatEnd});

  ServiceTimeSloat.fromJson(Map<String, dynamic> json) {
    weekDay = json['week_day'];
    date = json['date'];
    timeSloat = json['time_sloat'];
    timeSloatEnd = json['time_sloat_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['week_day'] = weekDay;
    data['date'] = date;
    data['time_sloat'] = timeSloat;
    data['time_sloat_end'] = timeSloatEnd;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['title'] = title;
    data['days'] = days;
    data['policy_discreption'] = policyDiscreption;
    data['return_shipping_fees'] = returnShippingFees;
    data['no_return'] = noReturn;
    data['unit'] = unit;
    data['is_default'] = isDefault;
    return data;
  }
}
