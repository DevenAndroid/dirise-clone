class ModelVendorRegistrationResponse {
  bool? status;
  String? message;
  Token? token;
  User? user;
  int? otp;
  String? redirectTo;

  ModelVendorRegistrationResponse({this.status, this.message, this.token, this.user, this.otp, this.redirectTo});

  ModelVendorRegistrationResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    otp = json['otp'];
    redirectTo = json['redirect_to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (token != null) {
      data['token'] = token!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['otp'] = otp;
    data['redirect_to'] = redirectTo;
    return data;
  }
}

class Token {
  String? token;

  Token({this.token});

  Token.fromJson(Map<String, dynamic> json) {
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    return data;
  }
}

class User {
  String? email;
  String? storeName;
  String? storeAddress;
  String? storeBusinessId;
  String? storeAboutUs;
  String? storeAboutMe;
  String? storeLogo;
  String? storeImage;
  String? updatedAt;
  String? createdAt;
  int? id;

  User(
      {this.email,
      this.storeName,
      this.storeAddress,
      this.storeBusinessId,
      this.storeAboutUs,
      this.storeAboutMe,
      this.storeLogo,
      this.storeImage,
      this.updatedAt,
      this.createdAt,
      this.id});

  User.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    storeName = json['store_name'];
    storeAddress = json['store_address'];
    storeBusinessId = json['store_business_id'];
    storeAboutUs = json['store_about_us'];
    storeAboutMe = json['store_about_me'];
    storeLogo = json['store_logo'];
    storeImage = json['store_image'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['store_name'] = storeName;
    data['store_address'] = storeAddress;
    data['store_business_id'] = storeBusinessId;
    data['store_about_us'] = storeAboutUs;
    data['store_about_me'] = storeAboutMe;
    data['store_logo'] = storeLogo;
    data['store_image'] = storeImage;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
