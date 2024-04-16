class ProfileModel {
  bool? status;
  dynamic message;
  User? user;

  ProfileModel({this.status, this.message, this.user});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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

class User {
  dynamic id;
  dynamic name;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic dob;
  dynamic countryCode;
  dynamic phone;
  dynamic storeName;
  dynamic storeBusinessId;
  dynamic storeAboutUs;
  dynamic storeAboutMe;
  dynamic storeAddress;
  dynamic storeLogo;
  dynamic storeImage;
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
  dynamic block;
  dynamic stripeId;
  dynamic street_name;
  dynamic currency;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic city_name;
  dynamic state_name;
  dynamic country_name;
  dynamic state_id;
  dynamic country_id;
  dynamic city;
  dynamic referralEmail;
  dynamic subscriptionStatus;
  dynamic phoneCountryCode;
  bool? isVendor;
  List<Roles>? roles;

  User(
      {this.id,
      this.name,
      this.firstName,
      this.street_name,
      this.state_id,
      this.state_name,
      this.phoneCountryCode,
      this.subscriptionStatus,
      this.country_name,
      this.lastName,
      this.email,
      this.dob,
      this.city_name,
      this.city,
      this.countryCode,
      this.phone,
      this.storeName,
      this.storeBusinessId,
      this.storeAboutUs,
      this.storeAboutMe,
      this.storeAddress,
      this.storeLogo,
      this.storeImage,
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
      this.categoryImage,
      this.address,
      this.block,
      this.stripeId,
      this.currency,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.country_id,
      this.isVendor,
      this.referralEmail,
      this.roles});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    city = json['city'];
    name = json['name'] ?? "";
    street_name = json['street_name'] ?? "";
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    state_name = json['state_name'] ?? "";
    email = json['email'] ?? "";
    dob = json['dob'] ?? "";
    countryCode = json['country_code'] ?? "";
    phone = json['phone'] ?? "";
    city_name = json['city_name'] ?? "";
    country_name = json['country_name'] ?? "";
    storeName = json['store_name'];
    storeBusinessId = json['store_business_id'];
    state_id = json['state_id'];
    country_id = json['country_id'];
    storeAboutUs = json['store_about_us'];
    storeAboutMe = json['store_about_me'];
    storeAddress = json['store_address'];
    storeLogo = json['store_logo'];
    storeImage = json['store_image'];
    description = json['description'];
    categoryId = json['category_id'];
    bio = json['bio'];
    socialId = json['social_id'];
    apiToken = json['api_token'];
    subscriptionStatus = json['subscription_status'];
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
    block = json['block'];
    stripeId = json['stripe_id'];
    currency = json['currency'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    referralEmail = json['referral_email'];
    phoneCountryCode = json['phone_country_code'];
    isVendor = json['is_vendor'] ?? false;
    if (json['roles'] != null) {
      roles = <Roles>[];
      json['roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['dob'] = dob;
    data['country_code'] = countryCode;
    data['phone'] = phone;
    data['store_name'] = storeName;
    data['store_business_id'] = storeBusinessId;
    data['store_about_us'] = storeAboutUs;
    data['store_about_me'] = storeAboutMe;
    data['store_address'] = storeAddress;
    data['store_logo'] = storeLogo;
    data['store_image'] = storeImage;
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
    data['block'] = block;
    data['subscription_status'] = subscriptionStatus;
    data['phone_country_code'] = phoneCountryCode;
    data['stripe_id'] = stripeId;
    data['currency'] = currency;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    data['is_vendor'] = isVendor;
    data['referral_email'] = referralEmail;
    if (roles != null) {
      data['roles'] = roles!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Roles {
  dynamic id;
  dynamic title;
  dynamic createdAt;
  dynamic updatedAt;
  Pivot? pivot;

  Roles({this.id, this.title, this.createdAt, this.updatedAt, this.pivot});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    pivot = json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
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
  dynamic roleId;

  Pivot({this.userId, this.roleId});

  Pivot.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    roleId = json['role_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['role_id'] = roleId;
    return data;
  }
}
