class SocialLoginModel {
  Data? data;
  bool? status;
  dynamic message;
  Details? details;

  SocialLoginModel({this.data, this.status, this.message, this.details});

  SocialLoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    return data;
  }
}

class Details {
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
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic loginMethod;

  Details(
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
        this.paymentStatus,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.loginMethod});

  Details.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    loginMethod = json['login_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['country_code'] = this.countryCode;
    data['earned_balance'] = this.earnedBalance;
    data['phone'] = this.phone;
    data['referral_email'] = this.referralEmail;
    data['store_name'] = this.storeName;
    data['store_business_id'] = this.storeBusinessId;
    data['store_about_us'] = this.storeAboutUs;
    data['store_about_me'] = this.storeAboutMe;
    data['store_address'] = this.storeAddress;
    data['store_logo'] = this.storeLogo;
    data['store_image'] = this.storeImage;
    data['store_phone'] = this.storePhone;
    data['shipping_address'] = this.shippingAddress;
    data['shipping_store_address'] = this.shippingStoreAddress;
    data['shipping_street_1'] = this.shippingStreet1;
    data['shipping_street_2'] = this.shippingStreet2;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['bio'] = this.bio;
    data['social_id'] = this.socialId;
    data['api_token'] = this.apiToken;
    data['device_id'] = this.deviceId;
    data['device_token'] = this.deviceToken;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['new_social_user'] = this.newSocialUser;
    data['customer_id'] = this.customerId;
    data['default_card'] = this.defaultCard;
    data['user_wallet'] = this.userWallet;
    data['is_mobile_verified'] = this.isMobileVerified;
    data['otp_verified'] = this.otpVerified;
    data['is_approved'] = this.isApproved;
    data['vendor_wallet'] = this.vendorWallet;
    data['profile_image'] = this.profileImage;
    data['banner_profile'] = this.bannerProfile;
    data['store_logo_app'] = this.storeLogoApp;
    data['store_logo_web'] = this.storeLogoWeb;
    data['banner_profile_app'] = this.bannerProfileApp;
    data['banner_profile_web'] = this.bannerProfileWeb;
    data['category_image'] = this.categoryImage;
    data['address'] = this.address;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city'] = this.city;
    data['street_name'] = this.streetName;
    data['block'] = this.block;
    data['stripe_id'] = this.stripeId;
    data['currency'] = this.currency;
    data['store_on'] = this.storeOn;
    data['store_banner_desccription'] = this.storeBannerDesccription;
    data['store_url'] = this.storeUrl;
    data['ready_for_order'] = this.readyForOrder;
    data['is_vendor'] = this.isVendor;
    data['checkBox'] = this.checkBox;
    data['vendor_type'] = this.vendorType;
    data['tax_number'] = this.taxNumber;
    data['vendor_publish_status'] = this.vendorPublishStatus;
    data['active_plan_id'] = this.activePlanId;
    data['plan_start_date'] = this.planStartDate;
    data['plan_expire_date'] = this.planExpireDate;
    data['subscription_status'] = this.subscriptionStatus;
    data['commision_value'] = this.commisionValue;
    data['comm_percentage'] = this.commPercentage;
    data['status'] = this.status;
    data['payment_status'] = this.paymentStatus;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['login_method'] = this.loginMethod;
    return data;
  }
}
