class JobProductModel {
  bool? status;
  dynamic message;
  SingleJobProduct? singleJobProduct;

  JobProductModel({this.status, this.message, this.singleJobProduct});

  JobProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    singleJobProduct = json['single_job_product'] != null
        ? new SingleJobProduct.fromJson(json['single_job_product'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.singleJobProduct != null) {
      data['single_job_product'] = this.singleJobProduct!.toJson();
    }
    return data;
  }
}

class SingleJobProduct {
  dynamic id;
  dynamic vendorId;
  dynamic storeName;
  dynamic storeEmail;
  dynamic storePhone;
  dynamic storeLinkedIn;
  StoerAddress? stoerAddress;
  List<JobCat>? jobCat;
  dynamic pname;
  dynamic slug;
  dynamic productType;
  dynamic itemType;
  dynamic featuredImage;
  List<String>? galleryImage;
  dynamic inStock;
  dynamic pPrice;
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
  dynamic phone;
  dynamic uploadCv;
  dynamic accountStatus;
  dynamic isComplete;

  SingleJobProduct(
      {this.id,
        this.vendorId,
        this.storeName,
        this.storeEmail,
        this.storePhone,
        this.storeLinkedIn,
        this.stoerAddress,
        this.jobCat,
        this.pname,
        this.slug,
        this.productType,
        this.itemType,
        this.featuredImage,
        this.galleryImage,
        this.inStock,
        this.pPrice,
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
        this.phone,
        this.uploadCv,
        this.accountStatus,
        this.isComplete});

  SingleJobProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    storeName = json['store_name'];
    storeEmail = json['store_email'];
    storePhone = json['store_phone'];
    storeLinkedIn = json['store_linked_in'];
    stoerAddress = json['stoer_address'] != null
        ? new StoerAddress.fromJson(json['stoer_address'])
        : null;
    if (json['job_cat'] != null) {
      jobCat = <JobCat>[];
      json['job_cat'].forEach((v) {
        jobCat!.add(new JobCat.fromJson(v));
      });
    }
    pname = json['pname'];
    slug = json['slug'];
    productType = json['product_type'];
    itemType = json['item_type'];
    featuredImage = json['featured_image'];
    galleryImage = json['gallery_image'].cast<String>();
    inStock = json['in_stock'];
    pPrice = json['p_price'];
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
    phone = json['phone'];
    uploadCv = json['upload_cv'];
    accountStatus = json['account_status'];
    isComplete = json['is_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['vendor_id'] = this.vendorId;
    data['store_name'] = this.storeName;
    data['store_email'] = this.storeEmail;
    data['store_phone'] = this.storePhone;
    data['store_linked_in'] = this.storeLinkedIn;
    if (this.stoerAddress != null) {
      data['stoer_address'] = this.stoerAddress!.toJson();
    }
    if (this.jobCat != null) {
      data['job_cat'] = this.jobCat!.map((v) => v.toJson()).toList();
    }
    data['pname'] = this.pname;
    data['slug'] = this.slug;
    data['product_type'] = this.productType;
    data['item_type'] = this.itemType;
    data['featured_image'] = this.featuredImage;
    data['gallery_image'] = this.galleryImage;
    data['in_stock'] = this.inStock;
    data['p_price'] = this.pPrice;
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
    data['phone'] = this.phone;
    data['upload_cv'] = this.uploadCv;
    data['account_status'] = this.accountStatus;
    data['is_complete'] = this.isComplete;
    return data;
  }
}

class StoerAddress {
  dynamic id;
  dynamic userId;
  dynamic isLogin;
  dynamic giveawayId;
  dynamic firstName;
  dynamic lastName;
  dynamic email;
  dynamic companyName;
  dynamic phone;
  dynamic addressType;
  dynamic type;
  bool? isDefault;
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

  StoerAddress(
      {this.id,
        this.userId,
        this.isLogin,
        this.giveawayId,
        this.firstName,
        this.lastName,
        this.email,
        this.companyName,
        this.phone,
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
        this.landmark});

  StoerAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    isLogin = json['is_login'];
    giveawayId = json['giveaway_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    companyName = json['company_name'];
    phone = json['phone'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['is_login'] = this.isLogin;
    data['giveaway_id'] = this.giveawayId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['company_name'] = this.companyName;
    data['phone'] = this.phone;
    data['address_type'] = this.addressType;
    data['type'] = this.type;
    data['is_default'] = this.isDefault;
    data['address'] = this.address;
    data['address2'] = this.address2;
    data['city'] = this.city;
    data['country'] = this.country;
    data['state'] = this.state;
    data['town'] = this.town;
    data['country_id'] = this.countryId;
    data['state_id'] = this.stateId;
    data['city_id'] = this.cityId;
    data['title'] = this.title;
    data['zip_code'] = this.zipCode;
    data['instruction'] = this.instruction;
    data['landmark'] = this.landmark;
    return data;
  }
}

class JobCat {
  dynamic id;
  dynamic title;

  JobCat({this.id, this.title});

  JobCat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
