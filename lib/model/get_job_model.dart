class GetJobModel {
  bool? status;
  dynamic message;
  JobProduct? jobProduct;

  GetJobModel({this.status, this.message, this.jobProduct});

  GetJobModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    jobProduct = json['job_product'] != null
        ? new JobProduct.fromJson(json['job_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.jobProduct != null) {
      data['job_product'] = this.jobProduct!.toJson();
    }
    return data;
  }
}

class JobProduct {
  dynamic currentPage;
  List<Data>? data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  JobProduct(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  JobProduct.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  dynamic id;
  dynamic vendorId;
  dynamic addressId;
  dynamic catId;
  dynamic catId2;
  dynamic jobCat;
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
  dynamic giveawayItemCondition;
  dynamic image;
  dynamic arabPname;
  dynamic productType;
  dynamic itemType;
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
  dynamic galleryImage;
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
  dynamic jobCountryId;
  dynamic jobStateId;
  dynamic jobCityId;
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
  dynamic returnPolicyDesc;
  dynamic shippingPolicyDesc;
  dynamic pickupPolicyId;
  dynamic bookableProductLocation;
  dynamic spot;
  dynamic hostName;
  dynamic programName;
  dynamic programGoal;
  dynamic programDesc;
  dynamic eligibleMinAge;
  dynamic eligibleMaxAge;
  dynamic eligibleGender;
  dynamic fromLocation;
  dynamic toLocation;
  dynamic fromExtraNotes;
  dynamic toExtraNotes;
  dynamic startLocation;
  dynamic endLocation;
  dynamic timingExtraNotes;
  dynamic productSponsorsId;
  dynamic meetingPlatform;
  dynamic meetingLink;
  dynamic optionalLink;
  dynamic linkShareVia;
  dynamic seminarFullRefund;
  dynamic isTrending;
  dynamic isPopular;
  dynamic isShowcase;
  dynamic noNeedStock;
  dynamic isComplete;
  dynamic discountPrice;
  dynamic discountOff;

  Data(
      {this.id,
        this.vendorId,
        this.addressId,
        this.catId,
        this.catId2,
        this.jobCat,
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
        this.giveawayItemCondition,
        this.image,
        this.arabPname,
        this.productType,
        this.itemType,
        this.virtualProductType,
        this.skuId,
        this.pPrice,
        this.sPrice,
        this.commission,
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
        this.jobCountryId,
        this.jobStateId,
        this.jobCityId,
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
        this.pickupPolicyId,
        this.bookableProductLocation,
        this.spot,
        this.hostName,
        this.programName,
        this.programGoal,
        this.programDesc,
        this.eligibleMinAge,
        this.eligibleMaxAge,
        this.eligibleGender,
        this.fromLocation,
        this.toLocation,
        this.fromExtraNotes,
        this.toExtraNotes,
        this.startLocation,
        this.endLocation,
        this.timingExtraNotes,
        this.productSponsorsId,
        this.meetingPlatform,
        this.meetingLink,
        this.optionalLink,
        this.linkShareVia,
        this.seminarFullRefund,
        this.isTrending,
        this.isPopular,
        this.isShowcase,
        this.noNeedStock,
        this.isComplete,
        this.discountPrice,
        this.discountOff});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    addressId = json['address_id'];
    catId = json['cat_id'];
    catId2 = json['cat_id_2'];
    jobCat = json['job_cat'];
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
    giveawayItemCondition = json['giveaway_item_condition'];
    image = json['image'];
    arabPname = json['arab_pname'];
    productType = json['product_type'];
    itemType = json['item_type'];
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
    galleryImage = json['gallery_image'];
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
    jobCountryId = json['job_country_id'];
    jobStateId = json['job_state_id'];
    jobCityId = json['job_city_id'];
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
    returnPolicyDesc = json['return_policy_desc'];
    shippingPolicyDesc = json['shipping_policy_desc'];
    pickupPolicyId = json['pickup_policy_id'];
    bookableProductLocation = json['bookable_product_location'];
    spot = json['spot'];
    hostName = json['host_name'];
    programName = json['program_name'];
    programGoal = json['program_goal'];
    programDesc = json['program_desc'];
    eligibleMinAge = json['eligible_min_age'];
    eligibleMaxAge = json['eligible_max_age'];
    eligibleGender = json['eligible_gender'];
    fromLocation = json['from_location'];
    toLocation = json['to_location'];
    fromExtraNotes = json['from_extra_notes'];
    toExtraNotes = json['to_extra_notes'];
    startLocation = json['start_location'];
    endLocation = json['end_location'];
    timingExtraNotes = json['timing_extra_notes'];
    productSponsorsId = json['product_sponsors_id'];
    meetingPlatform = json['meeting_platform'];
    meetingLink = json['meeting_link'];
    optionalLink = json['optional_link'];
    linkShareVia = json['link_share_via'];
    seminarFullRefund = json['seminar_full_refund'];
    isTrending = json['is_trending'];
    isPopular = json['is_popular'];
    isShowcase = json['is_showcase'];
    noNeedStock = json['no_need_stock'];
    isComplete = json['is_complete'];
    discountPrice = json['discount_price'];
    discountOff = json['discount_off'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
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
    data['giveaway_item_condition'] = this.giveawayItemCondition;
    data['image'] = this.image;
    data['arab_pname'] = this.arabPname;
    data['product_type'] = this.productType;
    data['item_type'] = this.itemType;
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
    data['job_country_id'] = this.jobCountryId;
    data['job_state_id'] = this.jobStateId;
    data['job_city_id'] = this.jobCityId;
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
    data['pickup_policy_id'] = this.pickupPolicyId;
    data['bookable_product_location'] = this.bookableProductLocation;
    data['spot'] = this.spot;
    data['host_name'] = this.hostName;
    data['program_name'] = this.programName;
    data['program_goal'] = this.programGoal;
    data['program_desc'] = this.programDesc;
    data['eligible_min_age'] = this.eligibleMinAge;
    data['eligible_max_age'] = this.eligibleMaxAge;
    data['eligible_gender'] = this.eligibleGender;
    data['from_location'] = this.fromLocation;
    data['to_location'] = this.toLocation;
    data['from_extra_notes'] = this.fromExtraNotes;
    data['to_extra_notes'] = this.toExtraNotes;
    data['start_location'] = this.startLocation;
    data['end_location'] = this.endLocation;
    data['timing_extra_notes'] = this.timingExtraNotes;
    data['product_sponsors_id'] = this.productSponsorsId;
    data['meeting_platform'] = this.meetingPlatform;
    data['meeting_link'] = this.meetingLink;
    data['optional_link'] = this.optionalLink;
    data['link_share_via'] = this.linkShareVia;
    data['seminar_full_refund'] = this.seminarFullRefund;
    data['is_trending'] = this.isTrending;
    data['is_popular'] = this.isPopular;
    data['is_showcase'] = this.isShowcase;
    data['no_need_stock'] = this.noNeedStock;
    data['is_complete'] = this.isComplete;
    data['discount_price'] = this.discountPrice;
    data['discount_off'] = this.discountOff;
    return data;
  }
}

class Links {
  dynamic url;
  dynamic label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}