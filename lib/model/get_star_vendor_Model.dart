class GetStarVendorModel {
  bool? status;
  dynamic message;
  List<Data>? data;

  GetStarVendorModel({this.status, this.message, this.data});

  GetStarVendorModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic name;
  OfTheMonth? ofTheMonth;

  Data({this.id, this.name, this.ofTheMonth});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    ofTheMonth = json['of_the_month'] != null
        ? new OfTheMonth.fromJson(json['of_the_month'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    if (ofTheMonth != null) {
      data['of_the_month'] = ofTheMonth!.toJson();
    }
    return data;
  }
}

class OfTheMonth {
  dynamic id;
  dynamic name;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
 dynamic dob;
  dynamic countryCode;
  dynamic earnedBalance;
  dynamic phone;
  dynamic referralEmail;
  dynamic storeName;
 dynamic storeBusinessId;
  dynamic storeAboutUs;
  dynamic storeAboutMe;
 dynamic storeAddress;
 dynamic storeLogo;
 dynamic storeImage;
 dynamic storePhone;
 dynamic shippingAddress;
 dynamic shippingStoreAddress;
 dynamic shippingStreet1;
 dynamic shippingStreet2;
 dynamic description;
 dynamic categoryId;
 dynamic bio;
 dynamic socialId;
 dynamic apiToken;
 dynamic deviceId;
 dynamic deviceToken;
 dynamic emailVerifiedAt;
  dynamic newSocialUser;
  dynamic customerId;
 dynamic defaultCard;
  dynamic userWallet;
  dynamic isMobileVerified;
  dynamic otpVerified;
  dynamic isApproved;
  dynamic vendorWallet;
  dynamic profileImage;
 dynamic bannerProfile;
  dynamic storeLogoApp;
  dynamic storeLogoWeb;
  dynamic bannerProfileApp;
  dynamic bannerProfileWeb;
 dynamic categoryImage;
 dynamic address;
  dynamic countryId;
  dynamic stateId;
  dynamic city;
  dynamic streetName;
  dynamic block;
 dynamic stripeId;
  dynamic currency;
  dynamic storeOn;
 dynamic storeBannerDesccription;
  dynamic storeUrl;
  dynamic readyForOrder;
  dynamic isVendor;
  dynamic checkBox;
  dynamic vendorType;
 dynamic taxNumber;
  dynamic vendorPublishStatus;
  dynamic activePlanId;
  dynamic planStartDate;
  dynamic planExpireDate;
  dynamic subscriptionStatus;
 dynamic commisionValue;
 dynamic commPercentage;
  dynamic status;
  dynamic paymentStatus;

  OfTheMonth(
      {this.id,
        this.name,
        this.firstName,
        this.lastName,
        this.email,
        this.dob,
        this.countryCode,
        this.earnedBalance,
        this.phone,
        this.referralEmail,
        this.storeName,
        this.storeBusinessId,
        this.storeAboutUs,
        this.storeAboutMe,
        this.storeAddress,
        this.storeLogo,
        this.storeImage,
        this.storePhone,
        this.shippingAddress,
        this.shippingStoreAddress,
        this.shippingStreet1,
        this.shippingStreet2,
        this.description,
        this.categoryId,
        this.bio,
        this.socialId,
        this.apiToken,
        this.deviceId,
        this.deviceToken,
        this.emailVerifiedAt,
        this.newSocialUser,
        this.customerId,
        this.defaultCard,
        this.userWallet,
        this.isMobileVerified,
        this.otpVerified,
        this.isApproved,
        this.vendorWallet,
        this.profileImage,
        this.bannerProfile,
        this.storeLogoApp,
        this.storeLogoWeb,
        this.bannerProfileApp,
        this.bannerProfileWeb,
        this.categoryImage,
        this.address,
        this.countryId,
        this.stateId,
        this.city,
        this.streetName,
        this.block,
        this.stripeId,
        this.currency,
        this.storeOn,
        this.storeBannerDesccription,
        this.storeUrl,
        this.readyForOrder,
        this.isVendor,
        this.checkBox,
        this.vendorType,
        this.taxNumber,
        this.vendorPublishStatus,
        this.activePlanId,
        this.planStartDate,
        this.planExpireDate,
        this.subscriptionStatus,
        this.commisionValue,
        this.commPercentage,
        this.status,
        this.paymentStatus});

  OfTheMonth.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dob = json['dob'];
    countryCode = json['country_code'];
    earnedBalance = json['earned_balance'];
    phone = json['phone'];
    referralEmail = json['referral_email'];
    storeName = json['store_name'];
    storeBusinessId = json['store_business_id'];
    storeAboutUs = json['store_about_us'];
    storeAboutMe = json['store_about_me'];
    storeAddress = json['store_address'];
    storeLogo = json['store_logo'];
    storeImage = json['store_image'];
    storePhone = json['store_phone'];
    shippingAddress = json['shipping_address'];
    shippingStoreAddress = json['shipping_store_address'];
    shippingStreet1 = json['shipping_street_1'];
    shippingStreet2 = json['shipping_street_2'];
    description = json['description'];
    categoryId = json['category_id'];
    bio = json['bio'];
    socialId = json['social_id'];
    apiToken = json['api_token'];
    deviceId = json['device_id'];
    deviceToken = json['device_token'];
    emailVerifiedAt = json['email_verified_at'];
    newSocialUser = json['new_social_user'];
    customerId = json['customer_id'];
    defaultCard = json['default_card'];
    userWallet = json['user_wallet'];
    isMobileVerified = json['is_mobile_verified'];
    otpVerified = json['otp_verified'];
    isApproved = json['is_approved'];
    vendorWallet = json['vendor_wallet'];
    profileImage = json['profile_image'];
    bannerProfile = json['banner_profile'];
    storeLogoApp = json['store_logo_app'];
    storeLogoWeb = json['store_logo_web'];
    bannerProfileApp = json['banner_profile_app'];
    bannerProfileWeb = json['banner_profile_web'];
    categoryImage = json['category_image'];
    address = json['address'];
    countryId = json['country_id'];
    stateId = json['state_id'];
    city = json['city'];
    streetName = json['street_name'];
    block = json['block'];
    stripeId = json['stripe_id'];
    currency = json['currency'];
    storeOn = json['store_on'];
    storeBannerDesccription = json['store_banner_desccription'];
    storeUrl = json['store_url'];
    readyForOrder = json['ready_for_order'];
    isVendor = json['is_vendor'];
    checkBox = json['checkBox'];
    vendorType = json['vendor_type'];
    taxNumber = json['tax_number'];
    vendorPublishStatus = json['vendor_publish_status'];
    activePlanId = json['active_plan_id'];
    planStartDate = json['plan_start_date'];
    planExpireDate = json['plan_expire_date'];
    subscriptionStatus = json['subscription_status'];
    commisionValue = json['commision_value'];
    commPercentage = json['comm_percentage'];
    status = json['status'];
    paymentStatus = json['payment_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['dob'] = dob;
    data['country_code'] = countryCode;
    data['earned_balance'] = earnedBalance;
    data['phone'] = phone;
    data['referral_email'] = referralEmail;
    data['store_name'] = storeName;
    data['store_business_id'] = storeBusinessId;
    data['store_about_us'] = storeAboutUs;
    data['store_about_me'] = storeAboutMe;
    data['store_address'] = storeAddress;
    data['store_logo'] = storeLogo;
    data['store_image'] = storeImage;
    data['store_phone'] = storePhone;
    data['shipping_address'] = shippingAddress;
    data['shipping_store_address'] = shippingStoreAddress;
    data['shipping_street_1'] = shippingStreet1;
    data['shipping_street_2'] = shippingStreet2;
    data['description'] = description;
    data['category_id'] = categoryId;
    data['bio'] = bio;
    data['social_id'] = socialId;
    data['api_token'] = apiToken;
    data['device_id'] = deviceId;
    data['device_token'] = deviceToken;
    data['email_verified_at'] = emailVerifiedAt;
    data['new_social_user'] = newSocialUser;
    data['customer_id'] = customerId;
    data['default_card'] = defaultCard;
    data['user_wallet'] = userWallet;
    data['is_mobile_verified'] = isMobileVerified;
    data['otp_verified'] = otpVerified;
    data['is_approved'] = isApproved;
    data['vendor_wallet'] = vendorWallet;
    data['profile_image'] = profileImage;
    data['banner_profile'] = bannerProfile;
    data['store_logo_app'] = storeLogoApp;
    data['store_logo_web'] = storeLogoWeb;
    data['banner_profile_app'] = bannerProfileApp;
    data['banner_profile_web'] = bannerProfileWeb;
    data['category_image'] = categoryImage;
    data['address'] = address;
    data['country_id'] = countryId;
    data['state_id'] = stateId;
    data['city'] = city;
    data['street_name'] = streetName;
    data['block'] = block;
    data['stripe_id'] = stripeId;
    data['currency'] = currency;
    data['store_on'] = storeOn;
    data['store_banner_desccription'] = storeBannerDesccription;
    data['store_url'] = storeUrl;
    data['ready_for_order'] = readyForOrder;
    data['is_vendor'] = isVendor;
    data['checkBox'] = checkBox;
    data['vendor_type'] = vendorType;
    data['tax_number'] = taxNumber;
    data['vendor_publish_status'] = vendorPublishStatus;
    data['active_plan_id'] = activePlanId;
    data['plan_start_date'] = planStartDate;
    data['plan_expire_date'] = planExpireDate;
    data['subscription_status'] = subscriptionStatus;
    data['commision_value'] = commisionValue;
    data['comm_percentage'] = commPercentage;
    data['status'] = status;
    data['payment_status'] = paymentStatus;
    return data;
  }
}
