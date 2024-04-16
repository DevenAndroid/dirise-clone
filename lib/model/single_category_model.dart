class SingleCategoryModel {
  bool? status;
  String? message;
  Data? data;

  SingleCategoryModel({this.status, this.message, this.data});

  SingleCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<String>? sliders;
  List<Stores>? stores;

  Data({this.sliders, this.stores});

  Data.fromJson(Map<String, dynamic> json) {
    sliders = json['sliders'].cast<String>();
    if (json['stores'] != null) {
      stores = <Stores>[];
      json['stores'].forEach((v) {
        stores!.add(Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sliders'] = sliders;
    if (stores != null) {
      data['stores'] = stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stores {
  String? businessName;
  String? country;
  String? state;
  String? city;
  String? postcode;
  String? helplineNumber;
  String? email;
  String? panNumber;
  String? gstinNumber;
  String? address;
  String? businessLogo;
  String? cinNumber;
  String? firstName;
  String? lastName;
  String? storeName;
  String? storeRating;
  String? storeUrl;
  String? phoneNumber;
  String? userName;
  String? street1;
  String? street2;
  String? zip;
  String? profileImg;
  String? bannerImg;
  int? vendorId;
  String? commision;
  String? instagram;
  String? youtube;
  String? twitter;
  String? linkedin;
  String? facebook;
  String? pinterest;
  String? accountName;
  String? accountNumber;
  String? bankName;
  String? bankNumber;
  String? swiftCode;
  String? routingNumber;
  String? selling;
  String? productPublish;
  String? featureVendor;
  String? notify;
  String? paypalId;
  String? freeShippingIsApplied;
  String? normalShippingIsApplied;
  String? normalPrice;
  String? freeShippingOver;
  String? shippingByCityIsApplied;
  String? sellingArea;

  Stores(
      {this.businessName,
      this.country,
      this.state,
      this.city,
      this.postcode,
      this.helplineNumber,
      this.email,
      this.panNumber,
      this.gstinNumber,
      this.address,
      this.businessLogo,
      this.cinNumber,
      this.firstName,
      this.lastName,
      this.storeName,
      this.storeRating,
      this.storeUrl,
      this.phoneNumber,
      this.userName,
      this.street1,
      this.street2,
      this.zip,
      this.profileImg,
      this.bannerImg,
      this.vendorId,
      this.commision,
      this.instagram,
      this.youtube,
      this.twitter,
      this.linkedin,
      this.facebook,
      this.pinterest,
      this.accountName,
      this.accountNumber,
      this.bankName,
      this.bankNumber,
      this.swiftCode,
      this.routingNumber,
      this.selling,
      this.productPublish,
      this.featureVendor,
      this.notify,
      this.paypalId,
      this.freeShippingIsApplied,
      this.normalShippingIsApplied,
      this.normalPrice,
      this.freeShippingOver,
      this.shippingByCityIsApplied,
      this.sellingArea});

  Stores.fromJson(Map<String, dynamic> json) {
    businessName = json['business_name'];
    country = json['country'];
    state = json['state'];
    city = json['city'];
    postcode = json['postcode'];
    helplineNumber = json['helpline_number_'];
    email = json['email'];
    panNumber = json['pan_number'];
    gstinNumber = json['gstin_number'];
    address = json['address'];
    businessLogo = json['business_logo'];
    cinNumber = json['cin_number'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    storeName = json['store_name'];
    storeRating = json['store_rating'];
    storeUrl = json['store_url'];
    phoneNumber = json['phone_number'];
    userName = json['user_name_'];
    street1 = json['street_1'];
    street2 = json['street_2'];
    zip = json['zip'];
    profileImg = json['profile_img'];
    bannerImg = json['banner_img'];
    vendorId = json['vendor_id'];
    commision = json['commision'];
    instagram = json['instagram'];
    youtube = json['youtube'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    facebook = json['facebook'];
    pinterest = json['pinterest'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bankName = json['bank_name'];
    bankNumber = json['bank_number'];
    swiftCode = json['swift_code'];
    routingNumber = json['routing_number'];
    selling = json['selling'];
    productPublish = json['product_publish'];
    featureVendor = json['feature_vendor'];
    notify = json['notify'];
    paypalId = json['paypal_id'];
    freeShippingIsApplied = json['free_shipping_is_applied'];
    normalShippingIsApplied = json['normal_shipping_is_applied'];
    normalPrice = json['normal_price'];
    freeShippingOver = json['free_shipping_over'];
    shippingByCityIsApplied = json['shipping_by_city_is_applied'];
    sellingArea = json['selling_area'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_name'] = businessName;
    data['country'] = country;
    data['state'] = state;
    data['city'] = city;
    data['postcode'] = postcode;
    data['helpline_number_'] = helplineNumber;
    data['email'] = email;
    data['pan_number'] = panNumber;
    data['gstin_number'] = gstinNumber;
    data['address'] = address;
    data['business_logo'] = businessLogo;
    data['cin_number'] = cinNumber;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['store_name'] = storeName;
    data['store_rating'] = storeRating;
    data['store_url'] = storeUrl;
    data['phone_number'] = phoneNumber;
    data['user_name_'] = userName;
    data['street_1'] = street1;
    data['street_2'] = street2;
    data['zip'] = zip;
    data['profile_img'] = profileImg;
    data['banner_img'] = bannerImg;
    data['vendor_id'] = vendorId;
    data['commision'] = commision;
    data['instagram'] = instagram;
    data['youtube'] = youtube;
    data['twitter'] = twitter;
    data['linkedin'] = linkedin;
    data['facebook'] = facebook;
    data['pinterest'] = pinterest;
    data['account_name'] = accountName;
    data['account_number'] = accountNumber;
    data['bank_name'] = bankName;
    data['bank_number'] = bankNumber;
    data['swift_code'] = swiftCode;
    data['routing_number'] = routingNumber;
    data['selling'] = selling;
    data['product_publish'] = productPublish;
    data['feature_vendor'] = featureVendor;
    data['notify'] = notify;
    data['paypal_id'] = paypalId;
    data['free_shipping_is_applied'] = freeShippingIsApplied;
    data['normal_shipping_is_applied'] = normalShippingIsApplied;
    data['normal_price'] = normalPrice;
    data['free_shipping_over'] = freeShippingOver;
    data['shipping_by_city_is_applied'] = shippingByCityIsApplied;
    data['selling_area'] = sellingArea;
    return data;
  }
}
