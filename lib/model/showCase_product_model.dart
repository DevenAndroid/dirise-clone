class GetShowCaseProductModel {
  bool? status;
  dynamic message;
  List<ShowcaseProduct>? showcaseProduct;

  GetShowCaseProductModel({this.status, this.message, this.showcaseProduct});

  GetShowCaseProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['showcase_product'] != null) {
      showcaseProduct = <ShowcaseProduct>[];
      json['showcase_product'].forEach((v) {
        showcaseProduct!.add(new ShowcaseProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (showcaseProduct != null) {
      data['showcase_product'] =
          showcaseProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShowcaseProduct {
  dynamic id;
  dynamic vendorId;
  dynamic pname;
  dynamic pPrice;
  dynamic shortDescription;
  dynamic featuredImage;
  dynamic addressId;
  dynamic countryName;
  dynamic catId;
  VendorDetails? vendorDetails;
  dynamic discountPrice;
  dynamic discountOff;
  dynamic address;

  ShowcaseProduct(
      {this.id,
        this.vendorId,
        this.pname,
        this.pPrice,
        this.catId,
        this.shortDescription,
        this.featuredImage,
        this.addressId,
        this.countryName,
        this.vendorDetails,
        this.discountPrice,
        this.discountOff,
        this.address});

  ShowcaseProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    pname = json['pname'];
    pPrice = json['p_price'];
    shortDescription = json['short_description'];
    featuredImage = json['featured_image'];
    addressId = json['address_id'];
    countryName = json['country_name'];
    vendorDetails = json['Vendor_details'] != null
        ? new VendorDetails.fromJson(json['Vendor_details'])
        : null;
    discountPrice = json['discount_price'];
    discountOff = json['discount_off'];
    address = json['address'];
    catId = json['cat_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['pname'] = pname;
    data['p_price'] = pPrice;
    data['short_description'] = shortDescription;
    data['cat_id'] = catId;
    data['featured_image'] = featuredImage;
    data['address_id'] = addressId;
    data['country_name'] = countryName;
    if (vendorDetails != null) {
      data['Vendor_details'] = vendorDetails!.toJson();
    }
    data['discount_price'] = discountPrice;
    data['discount_off'] = discountOff;
    data['address'] = address;
    return data;
  }
}

class VendorDetails {
  dynamic phoneCountryCode;
  dynamic phone;
  dynamic email;
  dynamic phoneNumber;

  VendorDetails(
      {this.phoneCountryCode, this.phone, this.email, this.phoneNumber});

  VendorDetails.fromJson(Map<String, dynamic> json) {
    phoneCountryCode = json['phone_country_code'];
    phone = json['phone'];
    email = json['email'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone_country_code'] = phoneCountryCode;
    data['phone'] = phone;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    return data;
  }
}
