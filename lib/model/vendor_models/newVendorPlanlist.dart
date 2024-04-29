class ModelPlansList {
  bool? status;
  Plans? plans;
  PlanDiscount? planDiscount;

  ModelPlansList({this.status, this.plans, this.planDiscount});

  ModelPlansList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    plans = json['Plans'] != null ? new Plans.fromJson(json['Plans']) : null;
    planDiscount = json['Plan-discount'] != null
        ? new PlanDiscount.fromJson(json['Plan-discount'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.plans != null) {
      data['Plans'] = this.plans!.toJson();
    }
    if (this.planDiscount != null) {
      data['Plan-discount'] = this.planDiscount!.toJson();
    }
    return data;
  }
}

class Plans {
  List<Advertisement>? advertisement;
  List<Personal>? personal;
  List<Company>? company;

  Plans({this.advertisement, this.personal, this.company});

  Plans.fromJson(Map<String, dynamic> json) {
    if (json['advertisement'] != null) {
      advertisement = <Advertisement>[];
      json['advertisement'].forEach((v) {
        advertisement!.add(new Advertisement.fromJson(v));
      });
    }
    if (json['personal'] != null) {
      personal = <Personal>[];
      json['personal'].forEach((v) {
        personal!.add(new Personal.fromJson(v));
      });
    }
    if (json['company'] != null) {
      company = <Company>[];
      json['company'].forEach((v) {
        company!.add(new Company.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.advertisement != null) {
      data['advertisement'] =
          this.advertisement!.map((v) => v.toJson()).toList();
    }
    if (this.personal != null) {
      data['personal'] = this.personal!.map((v) => v.toJson()).toList();
    }
    if (this.company != null) {
      data['company'] = this.company!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Advertisement {
  dynamic id;
  dynamic title;
  dynamic businessType;
  dynamic amount;
  dynamic discountPlanAmount;
  dynamic currency;
  dynamic validity;
  dynamic label;

  Advertisement(
      {this.id,
        this.title,
        this.businessType,
        this.amount,
        this.discountPlanAmount,
        this.currency,
        this.validity,
        this.label});

  Advertisement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    businessType = json['business_type'];
    amount = json['amount'];
    discountPlanAmount = json['discount_plan_amount'];
    currency = json['currency'];
    validity = json['validity'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['business_type'] = this.businessType;
    data['amount'] = this.amount;
    data['discount_plan_amount'] = this.discountPlanAmount;
    data['currency'] = this.currency;
    data['validity'] = this.validity;
    data['label'] = this.label;
    return data;
  }
}

class Personal {
  dynamic id;
  dynamic title;
  dynamic businessType;
  dynamic amount;
  dynamic discountPlanAmount;
  dynamic currency;
  dynamic validity;
  dynamic label;

  Personal(
      {this.id,
        this.title,
        this.businessType,
        this.amount,
        this.discountPlanAmount,
        this.currency,
        this.validity,
        this.label});

  Personal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    businessType = json['business_type'];
    amount = json['amount'];
    discountPlanAmount = json['discount_plan_amount'];
    currency = json['currency'];
    validity = json['validity'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['business_type'] = this.businessType;
    data['amount'] = this.amount;
    data['discount_plan_amount'] = this.discountPlanAmount;
    data['currency'] = this.currency;
    data['validity'] = this.validity;
    data['label'] = this.label;
    return data;
  }
}

class Company {
  dynamic id;
  dynamic title;
  dynamic businessType;
  dynamic amount;
  dynamic discountPlanAmount;
  dynamic currency;
  dynamic  validity;
  dynamic label;

  Company(
      {this.id,
        this.title,
        this.businessType,
        this.amount,
        this.discountPlanAmount,
        this.currency,
        this.validity,
        this.label});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    businessType = json['business_type'];
    amount = json['amount'];
    discountPlanAmount = json['discount_plan_amount'];
    currency = json['currency'];
    validity = json['validity'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['business_type'] = this.businessType;
    data['amount'] = this.amount;
    data['discount_plan_amount'] = this.discountPlanAmount;
    data['currency'] = this.currency;
    data['validity'] = this.validity;
    data['label'] = this.label;
    return data;
  }
}

class PlanDiscount {
  String? companyDiscount;
  String? personalDiscount;

  PlanDiscount({this.companyDiscount, this.personalDiscount});

  PlanDiscount.fromJson(Map<String, dynamic> json) {
    companyDiscount = json['company_discount'];
    personalDiscount = json['personal_discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['company_discount'] = this.companyDiscount;
    data['personal_discount'] = this.personalDiscount;
    return data;
  }
}