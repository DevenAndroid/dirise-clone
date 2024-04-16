class ModelVendorDetails {
  bool? status;
  dynamic message;
  VendorUser? user;

  ModelVendorDetails({this.status, this.message, this.user});

  ModelVendorDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? VendorUser.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class VendorUser {
  dynamic id;
  dynamic name;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic country_id;
  dynamic dob;
  dynamic countryCode;
  dynamic earnedBalance;
  dynamic phone;
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
  dynamic vendorType;
  dynamic subscription_status;
  dynamic taxNumber;
  dynamic vendorPublishStatus;
  dynamic activePlanId;
  dynamic planStartDate;
  dynamic planExpireDate;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic vendorCategory;
 List<VenderCategory>? venderCategory = [];
  VendorProfile? vendorProfile;
  VendorSub? vendorSub;

  VendorUser(
      {this.id,
        this.name,
        this.firstName,
        this.country_id,
        this.subscription_status,
        this.lastName,
        this.email,
        this.dob,
        this.countryCode,
        this.earnedBalance,
        this.phone,
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
        this.vendorSub,
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
        this.vendorType,
        this.taxNumber,
        this.vendorPublishStatus,
        this.activePlanId,
        this.planStartDate,
        this.planExpireDate,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.vendorCategory,
        this.venderCategory,
        this.vendorProfile});

  VendorUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    country_id = json['country_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    subscription_status = json['subscription_status'];
    email = json['email'];
    dob = json['dob'];
    countryCode = json['country_code'];
    earnedBalance = json['earned_balance'];
    phone = json['phone'];
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
    vendorType = json['vendor_type'];
    taxNumber = json['tax_number'];
    vendorPublishStatus = json['vendor_publish_status'];
    activePlanId = json['active_plan_id'];
    planStartDate = json['plan_start_date'];
    planExpireDate = json['plan_expire_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    vendorCategory = json['vendor_category'];
    try {
      if (json['vender_category'] != null) {
        venderCategory = <VenderCategory>[];
        json['vender_category'].forEach((v) {
          venderCategory!.add(VenderCategory.fromJson(v));
        });
      }
      venderCategory ??= [];
    } catch(e){
      venderCategory ??= [];
    }
    vendorProfile = json['vendor_profile'] != null
        ? VendorProfile.fromJson(json['vendor_profile'])
        : null;
    vendorSub = json['vendor_sub'] != null
        ? VendorSub.fromJson(json['vendor_sub'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_id'] = country_id;
    data['subscription_status'] = subscription_status;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['dob'] = dob;
    data['country_code'] = countryCode;
    data['earned_balance'] = earnedBalance;
    data['phone'] = phone;
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
    data['vendor_type'] = vendorType;
    data['tax_number'] = taxNumber;
    data['vendor_publish_status'] = vendorPublishStatus;
    data['active_plan_id'] = activePlanId;
    data['plan_start_date'] = planStartDate;
    data['plan_expire_date'] = planExpireDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['vendor_category'] = vendorCategory;
    if (venderCategory != null) {
      data['vender_category'] =
          venderCategory!.map((v) => v.toJson()).toList();
    }
    if (vendorProfile != null) {
      data['vendor_profile'] = vendorProfile!.toJson();
    }
    return data;
  }
}

class VenderCategory {
  dynamic id;
  dynamic name;
  dynamic status;
  dynamic description;
  dynamic profileImage;
  dynamic bannerProfile;
  dynamic createdAt;
  dynamic updatedAt;
  Pivot? pivot;

  VenderCategory(
      {this.id,
        this.name,
        this.status,
        this.description,
        this.profileImage,
        this.bannerProfile,
        this.createdAt,
        this.updatedAt,
        this.pivot});

  VenderCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    description = json['description'];
    profileImage = json['profile_image'];
    bannerProfile = json['banner_profile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['description'] = description;
    data['profile_image'] = profileImage;
    data['banner_profile'] = bannerProfile;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (pivot != null) {
      data['pivot'] = pivot!.toJson();
    }
    return data;
  }
}

class Pivot {
  dynamic userId;
  dynamic userVendorCategoryId;

  Pivot({this.userId, this.userVendorCategoryId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userVendorCategoryId = json['user_vendor_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_vendor_category_id'] = userVendorCategoryId;
    return data;
  }
}

class VendorProfile {
  dynamic id;
  dynamic userId;
  dynamic businessNumber;
  dynamic accountNumber;
  dynamic is_complete;
  dynamic ibnNumber;
  dynamic bankName;
  dynamic accountHolderName;
  dynamic home_address;
  dynamic workEmail;
  dynamic paymentCertificate;
  dynamic ownerName;
  dynamic companyName;
  dynamic commercialLicense;
  dynamic memorandumOfAssociation;
  dynamic ceoName;
  dynamic homeAddress;
  dynamic partners;
  dynamic partnersName;
  dynamic workAddress;
  dynamic ministyOfCommerce;
  dynamic originalCivilInformation;
  dynamic signatureApproval;
  dynamic companyBankAccount;
  dynamic taxNumber;
  dynamic label1;
  dynamic label2;
  dynamic label3;
  dynamic createdAt;
  dynamic idProof;
  dynamic updatedAt;

  VendorProfile(
      {this.id,
        this.userId,
        this.workEmail,
        this.is_complete,
        this.paymentCertificate,
        this.businessNumber,
        this.home_address,
        this.accountNumber,
        this.ibnNumber,
        this.bankName,
        this.accountHolderName,
        this.ownerName,
        this.companyName,
        this.commercialLicense,
        this.memorandumOfAssociation,
        this.ceoName,
        this.homeAddress,
        this.partners,
        this.workAddress,
        this.ministyOfCommerce,
        this.originalCivilInformation,
        this.signatureApproval,
        this.companyBankAccount,
        this.taxNumber,
        this.label1,
        this.label2,
        this.label3,
        this.createdAt,
        this.partnersName,
        this.idProof,
        this.updatedAt});

  VendorProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    home_address = json['home_address'];
    businessNumber = json['business_number'];
    accountNumber = json['account_number'];
    ibnNumber = json['ibn_number'];
    bankName = json['bank_name'];
    is_complete = json['is_complete'];
    accountHolderName = json['account_holder_name'];
    workEmail = json['work_email'];
    paymentCertificate = json['payment_certificate'];
    ownerName = json['owner_name'];
    companyName = json['company_name'];
    commercialLicense = json['commercial_license'];
    memorandumOfAssociation = json['memorandum_of_association'];
    ceoName = json['ceo_name'];
    homeAddress = json['home_address'];
    partners = json['partners'];
    workAddress = json['work_address'];
    ministyOfCommerce = json['ministy_of_commerce'];
    originalCivilInformation = json['original_civil_information'];
    signatureApproval = json['signature_approval'];
    companyBankAccount = json['company_bank_account'];
    taxNumber = json['tax_number'];
    label1 = json['label1'];
    label2 = json['label2'];
    label3 = json['label3'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    idProof = json['id_proof'];
    partnersName = json['partner_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['is_complete'] = is_complete;
    data['home_address'] = home_address;
    data['work_email'] = workEmail;
    data['payment_certificate'] = paymentCertificate;
    data['owner_name'] = ownerName;
    data['company_name'] = companyName;
    data['commercial_license'] = commercialLicense;
    data['memorandum_of_association'] = memorandumOfAssociation;
    data['ceo_name'] = ceoName;
    data['home_address'] = homeAddress;
    data['partners'] = partners;
    data['work_address'] = workAddress;
    data['ministy_of_commerce'] = ministyOfCommerce;
    data['original_civil_information'] = originalCivilInformation;
    data['signature_approval'] = signatureApproval;
    data['company_bank_account'] = companyBankAccount;
    data['tax_number'] = taxNumber;
    data['label1'] = label1;
    data['label2'] = label2;
    data['label3'] = label3;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['id_proof'] = idProof;
    data['partner_name'] = partnersName;
    return data;
  }
}

class VendorSub {
  dynamic id;
  dynamic vendorId;
  dynamic subCategoryId;
  dynamic createdAt;
  dynamic updatedAt;

  VendorSub(
      {this.id,
        this.vendorId,
        this.subCategoryId,
        this.createdAt,
        this.updatedAt});

  VendorSub.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    subCategoryId = json['sub_category_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['sub_category_id'] = this.subCategoryId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
