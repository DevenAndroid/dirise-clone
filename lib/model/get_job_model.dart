class GetJobModel {
  bool? status;
  dynamic message;
  List<JobProduct>? jobProduct;

  GetJobModel({this.status, this.message, this.jobProduct});

  GetJobModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['job_product'] != null) {
      jobProduct = <JobProduct>[];
      json['job_product'].forEach((v) {
        jobProduct!.add(new JobProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (jobProduct != null) {
      data['job_product'] = jobProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JobProduct {
  dynamic id;
  dynamic vendorId;
  dynamic jobCat;
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
  dynamic uploadCv;
  dynamic accountStatus;
  dynamic isComplete;

  JobProduct(
      {this.id,
        this.vendorId,
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
        this.uploadCv,
        this.accountStatus,
        this.isComplete});

  JobProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    jobCat = json['job_cat'];
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
    uploadCv = json['upload_cv'];
    accountStatus = json['account_status'];
    isComplete = json['is_complete'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['job_cat'] = jobCat;
    data['pname'] = pname;
    data['slug'] = slug;
    data['product_type'] = productType;
    data['item_type'] = itemType;
    data['featured_image'] = featuredImage;
    data['gallery_image'] = galleryImage;
    data['in_stock'] = inStock;
    data['p_price'] = pPrice;
    data['jobseeking_or_offering'] = jobseekingOrOffering;
    data['job_type'] = jobType;
    data['job_model'] = jobModel;
    data['describe_job_role'] = describeJobRole;
    data['linkdin_url'] = linkdinUrl;
    data['experience'] = experience;
    data['salary'] = salary;
    data['about_yourself'] = aboutYourself;
    data['job_hours'] = jobHours;
    data['job_country_id'] = jobCountryId;
    data['job_state_id'] = jobStateId;
    data['job_city_id'] = jobCityId;
    data['upload_cv'] = uploadCv;
    data['account_status'] = accountStatus;
    data['is_complete'] = isComplete;
    return data;
  }
}
