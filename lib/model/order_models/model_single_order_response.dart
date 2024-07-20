import 'package:get/get.dart';

class ModelSingleOrderResponse {
  bool? status;
  dynamic message;
  SingleOrderData? order;

  ModelSingleOrderResponse({this.status, this.message, this.order});

  ModelSingleOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    order = json['order'] != null ? SingleOrderData.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    return data;
  }
}

class SingleOrderData {
  dynamic id;
  dynamic parentId;
  dynamic orderId;
  dynamic userId;
  dynamic status;
  dynamic statusNote;
  dynamic shippingType;
  dynamic shippingPrice;
  dynamic shippingMethod;
  dynamic paymentMode;
  dynamic paymentStatus;
  dynamic currencyCode;
  dynamic couponId;
  dynamic couponCode;
  dynamic discountAmount;
  dynamic updatedAt;
  dynamic deliveryCharges;
  dynamic createdDate;
  OrderMeta? orderMeta;
  dynamic expectedDate;
  OrderShipping? orderShipping;
  List<OrderItem>? orderItem = [];
  User? user;

  SingleOrderData(
      {this.id,
      this.parentId,
      this.orderId,
      this.userId,
      this.status,
      this.statusNote,
      this.shippingType,
      this.shippingPrice,
      this.shippingMethod,
      this.paymentMode,
      this.paymentStatus,
      this.deliveryCharges,
      this.currencyCode,
      this.couponId,
      this.couponCode,
        this.orderShipping,
      this.discountAmount,
      this.updatedAt,
      this.createdDate,
      this.orderMeta,
      this.user,
      this.expectedDate,
      this.orderItem});

  SingleOrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    status = json['status'];
    statusNote = json['status_note'];
    shippingType = json['shipping_type'];
    shippingPrice = json['shipping_price'];
    shippingMethod = json['shipping_method'];
    paymentMode = json['payment_mode'];
    paymentStatus = json['payment_status'];
    currencyCode = json['currency_code'];
    couponId = json['coupon_id'];
    couponCode = json['coupon_code'];
    discountAmount = json['discount_amount'];
    deliveryCharges = json['delivery_charges'];
    updatedAt = json['updated_at'];
    createdDate = json['created_date'];
    orderMeta = json['order_meta'] != null ? OrderMeta.fromJson(json['order_meta']) : null;
    orderShipping = json['OrderShipping'] != null
        ? new OrderShipping.fromJson(json['OrderShipping'])
        : null;
    expectedDate = json['expected_date'];
    if (json['order_item'] != null) {
      orderItem = <OrderItem>[];
      json['order_item'].forEach((v) {
        orderItem!.add(OrderItem.fromJson(v));
      });
    }
    else {
      orderItem = [];
    }
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['parent_id'] = parentId;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['status'] = status;
    data['status_note'] = statusNote;
    data['shipping_type'] = shippingType;
    data['shipping_price'] = shippingPrice;
    data['shipping_method'] = shippingMethod;
    data['payment_mode'] = paymentMode;
    data['payment_status'] = paymentStatus;
    data['currency_code'] = currencyCode;
    data['coupon_id'] = couponId;
    data['coupon_code'] = couponCode;
    data['discount_amount'] = discountAmount;
    data['updated_at'] = updatedAt;
    data['created_date'] = createdDate;
    data['delivery_charges'] = deliveryCharges;
    if (orderMeta != null) {
      data['order_meta'] = orderMeta!.toJson();
    }
    if (this.orderShipping != null) {
      data['OrderShipping'] = this.orderShipping!.toJson();
    }
    data['expected_date'] = expectedDate;
    if (orderItem != null) {
      data['order_item'] = orderItem!.map((v) => v.toJson()).toList();
    }

    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class OrderShipping {
  dynamic  id;
  dynamic  orderId;
  dynamic vendorId;
  dynamic shippingType;
  dynamic shipmentProvider;
  dynamic shippingTitle;
  dynamic shippingPrice;
  dynamic shippingDate;

  OrderShipping(
      {this.id,
        this.orderId,
        this.vendorId,
        this.shippingType,
        this.shipmentProvider,
        this.shippingTitle,
        this.shippingPrice,
        this.shippingDate});

  OrderShipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    vendorId = json['vendor_id'];
    shippingType = json['shipping_type'];
    shipmentProvider = json['shipment_provider'];
    shippingTitle = json['shipping_title'];
    shippingPrice = json['shipping_price'];
    shippingDate = json['shipping_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['vendor_id'] = this.vendorId;
    data['shipping_type'] = this.shippingType;
    data['shipment_provider'] = this.shipmentProvider;
    data['shipping_title'] = this.shippingTitle;
    data['shipping_price'] = this.shippingPrice;
    data['shipping_date'] = this.shippingDate;
    return data;
  }
}


class OrderMeta {

  String get completeOrder{
    List<String> kk = [];

    if(billingAddress2 != null){
      kk.add(billingAddress2.toString());
    }
    if(billingLandmark != null){
      kk.add(billingLandmark.toString());
    }
    if(billingCity != null){
      kk.add(billingCity.toString());
    }
    if(billingState != null){
      kk.add(billingState.toString());
    }
    if(billingCountry != null){
      kk.add(billingCountry.toString());
    }
    kk.removeWhere((element) => element.isEmpty);
    return kk.join(", ");
  }

  dynamic billingFirstName;
  dynamic billingLastName;
  dynamic billingPhone;
  dynamic billingAlternatePhone;
  dynamic billingAddress2;
  dynamic billingAddressType;
  dynamic billingCity;
  dynamic billingCountry;
  dynamic billingState;
  dynamic billingZipCode;
  dynamic billingLandmark;
  dynamic subtotalPrice;
  dynamic totalPrice;
  dynamic giftCardAmount;
  dynamic giftCardData;
  dynamic currencySign;
  dynamic shippingPrice;
  dynamic shippingFirstName;
  dynamic shippingLastName;
  dynamic shippingPhone;
  dynamic shippingAlternatePhone;
  dynamic shippingAddress2;
  dynamic shippingAddressType;
  dynamic shippingCity;
  dynamic shippingCountry;
  dynamic shippingState;
  dynamic shippingZipCode;
  dynamic shippingLandmark;
  dynamic refundAmountIn;

  OrderMeta(
      {this.billingFirstName,
      this.billingLastName,
      this.billingPhone,
      this.billingAlternatePhone,
      this.billingAddress2,
      this.billingAddressType,
      this.billingCity,
      this.billingCountry,
      this.billingState,
      this.billingZipCode,
      this.billingLandmark,
      this.subtotalPrice,
      this.totalPrice,
      this.giftCardAmount,
      this.giftCardData,
      this.currencySign,
      this.shippingPrice,
      // this.shipping,
      this.shippingFirstName,
      this.shippingLastName,
      this.shippingPhone,
      this.shippingAlternatePhone,
      this.shippingAddress2,
      this.shippingAddressType,
      this.shippingCity,
      this.shippingCountry,
      this.shippingState,
      this.shippingZipCode,
      this.shippingLandmark,
      this.refundAmountIn});

  OrderMeta.fromJson(Map<String, dynamic> json) {
    billingFirstName = json['billing_first_name'];
    billingLastName = json['billing_last_name'];
    billingPhone = json['billing_phone'];
    billingAlternatePhone = json['billing_alternate_phone'];
    billingAddress2 = json['billing_address2'];
    billingAddressType = json['billing_address_type'];
    billingCity = json['billing_city'];
    billingCountry = json['billing_country'];
    billingState = json['billing_state'];
    billingZipCode = json['billing_zip_code'];
    billingLandmark = json['billing_landmark'];
    subtotalPrice = json['subtotal_price'];
    totalPrice = json['total_price'];
    giftCardAmount = json['gift_card_amount'];
    giftCardData = json['gift_card_data'];
    currencySign = json['currency_sign'];
    shippingPrice = json['shipping_price'];
    // if (json['shipping'] != null) {
    //   shipping = <Shipping>[];
    //   json['shipping'].forEach((v) {
    //     shipping!.add(Shipping.fromJson(v));
    //   });
    // }
    shippingFirstName = json['shipping_first_name'];
    shippingLastName = json['shipping_last_name'];
    shippingPhone = json['shipping_phone'];
    shippingAlternatePhone = json['shipping_alternate_phone'];
    shippingAddress2 = json['shipping_address2'];
    shippingAddressType = json['shipping_address_type'];
    shippingCity = json['shipping_city'];
    shippingCountry = json['shipping_country'];
    shippingState = json['shipping_state'];
    shippingZipCode = json['shipping_zip_code'];
    shippingLandmark = json['shipping_landmark'];
    refundAmountIn = json['refund_amount_in'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billing_first_name'] = billingFirstName;
    data['billing_last_name'] = billingLastName;
    data['billing_phone'] = billingPhone;
    data['billing_alternate_phone'] = billingAlternatePhone;
    data['billing_address2'] = billingAddress2;
    data['billing_address_type'] = billingAddressType;
    data['billing_city'] = billingCity;
    data['billing_country'] = billingCountry;
    data['billing_state'] = billingState;
    data['billing_zip_code'] = billingZipCode;
    data['billing_landmark'] = billingLandmark;
    data['subtotal_price'] = subtotalPrice;
    data['total_price'] = totalPrice;
    data['gift_card_amount'] = giftCardAmount;
    data['gift_card_data'] = giftCardData;
    data['currency_sign'] = currencySign;
    data['shipping_price'] = shippingPrice;
    // if (shipping != null) {
    //   data['shipping'] = shipping!.map((v) => v.toJson()).toList();
    // }
    data['shipping_first_name'] = shippingFirstName;
    data['shipping_last_name'] = shippingLastName;
    data['shipping_phone'] = shippingPhone;
    data['shipping_alternate_phone'] = shippingAlternatePhone;
    data['shipping_address2'] = shippingAddress2;
    data['shipping_address_type'] = shippingAddressType;
    data['shipping_city'] = shippingCity;
    data['shipping_country'] = shippingCountry;
    data['shipping_state'] = shippingState;
    data['shipping_zip_code'] = shippingZipCode;
    data['shipping_landmark'] = shippingLandmark;
    data['refund_amount_in'] = refundAmountIn;
    return data;
  }
}

class Shipping {
  dynamic storeId;
  dynamic storeName;
  dynamic title;
  dynamic shipPrice;

  Shipping({this.storeId, this.storeName, this.title, this.shipPrice});

  Shipping.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    title = json['title'];
    shipPrice = json['ship_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['title'] = title;
    data['ship_price'] = shipPrice;
    return data;
  }
}

class OrderItem {

  bool get isVirtualProduct => productType == "virtual_product";
  bool get isVirtualProductPDF => virtualProductFile.toString().contains(".pdf");

  RxBool showDetails = false.obs;
  dynamic id;
  dynamic selectedSlotStart;
  dynamic selectedSlotEnd;
  dynamic selectedSlotDate;
  dynamic virtualProductFile;
  dynamic orderId;
  dynamic childId;
  dynamic productId;
  dynamic vendorId;
  dynamic userId;
  dynamic productName;
  bool? isReturnExpire;
  dynamic category;
  dynamic productType;
  dynamic quantity;
  dynamic productPrice;
  dynamic discount;
  dynamic totalPrice;
  dynamic tax;
  dynamic status;
  dynamic startDate;
  dynamic sloatTime;
  dynamic endDate;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic featuredImage;
  List<OrderTrackData>? orderTrackData;

  OrderItem(
      {this.id,
      this.selectedSlotStart,
      this.selectedSlotEnd,
      this.selectedSlotDate,
      this.orderTrackData,
      this.virtualProductFile,
      this.orderId,
      this.isReturnExpire,
      this.childId,
      this.productId,
      this.vendorId,
      this.userId,
      this.productName,
      this.category,
      this.productType,
      this.quantity,
      this.productPrice,
      this.discount,
      this.totalPrice,
      this.tax,
      this.status,
      this.startDate,
      this.sloatTime,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.featuredImage});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    selectedSlotStart = json["selected_sloat_start"];
    selectedSlotEnd = json["selected_sloat_end"] ?? "";
    selectedSlotDate = json["selected_sloat_date"] ?? "";
    orderId = json['order_id'];
    virtualProductFile = json['virtual_product_file'];
    childId = json['child_id'];
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    userId = json['user_id'];
    productName = json['product_name'];
    category = json['category'];
    productType = json['product_type'];
    quantity = json['quantity'];
    productPrice = json['product_price'];
    discount = json['discount'];
    isReturnExpire = json['is_return_expire'];
    totalPrice = json['total_price'];
    tax = json['tax'];
    status = json['status'];
    startDate = json['start_date'];
    sloatTime = json['sloat_time'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    featuredImage = json['featured_image'];
    if (json['order_track_data'] != null) {
      orderTrackData = <OrderTrackData>[];
      json['order_track_data'].forEach((v) {
        orderTrackData!.add(OrderTrackData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['child_id'] = childId;
    data['virtual_product_file'] = virtualProductFile;
    data['product_id'] = productId;
    data['is_return_expire'] = isReturnExpire;
    data['vendor_id'] = vendorId;
    data['user_id'] = userId;
    data['product_name'] = productName;
    data['category'] = category;
    data['product_type'] = productType;
    data['quantity'] = quantity;
    data['product_price'] = productPrice;
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    data['tax'] = tax;
    data['status'] = status;
    data['start_date'] = startDate;
    data['sloat_time'] = sloatTime;
    data['end_date'] = endDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['featured_image'] = featuredImage;
    if (orderTrackData != null) {
      data['order_track_data'] =
          orderTrackData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class OrderTrackData {
  dynamic title;
  dynamic completed;
  dynamic date;

  OrderTrackData({this.title, this.completed, this.date});

  OrderTrackData.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    completed = json['completed'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['title'] = title;
    data['completed'] = completed;
    data['date'] = date;
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
  dynamic readyForOrder;
  dynamic isVendor;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic deletedAt;

  User(
      {this.id,
        this.name,
        this.firstName,
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
        this.countryId,
        this.stateId,
        this.city,
        this.streetName,
        this.block,
        this.stripeId,
        this.currency,
        this.storeOn,
        this.readyForOrder,
        this.isVendor,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
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
    readyForOrder = json['ready_for_order'];
    isVendor = json['is_vendor'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
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
    data['ready_for_order'] = readyForOrder;
    data['is_vendor'] = isVendor;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    return data;
  }
}
