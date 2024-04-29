class ModelPlansList {
  bool? status;
  Plans? plans;
  PlansDiscount? plansDiscount;
  List<List<PlanInfoData>?> get allPlans => plans!.plants!.entries.map((e) => e.value).toList();

  ModelPlansList({this.status, this.plans});

  ModelPlansList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    plans = json['Plans'] != null ? Plans.fromJson(json['Plans']) : null;
    plansDiscount = json["Plan-discount"] != null ? PlansDiscount.fromJson(json["Plan-discount"]) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    return data;
  }
}

class Plans {
  Map<String, List<PlanInfoData>>? plants;

  Plans({this.plants});
  Plans.fromJson(Map<String, dynamic> json){
    for (var element in json.entries) {
      List<PlanInfoData> temp = [];
      if(element.value.toString().length > 20) {
        element.value.forEach((v) {
          temp.add(PlanInfoData.fromJson(v));
        });
      plants ??= {};
      plants![element.key] = temp;
      }
    }
  }
}

class PlansDiscount {
  String? companyDiscount;
  String? personalDiscount;

  PlansDiscount({
    this.companyDiscount,
    this.personalDiscount});
  PlansDiscount.fromJson(Map<String, dynamic> json){
    companyDiscount = json['company_discount'];
    personalDiscount = json['personal_discount'];
  }
}

class PlanInfoData {
  dynamic id;
  dynamic title;
  dynamic businessType;
  dynamic amount;
  dynamic validity;
  dynamic label;
  dynamic currency;
  dynamic discountPlan;
  String? planType;

  PlanInfoData(
      {this.id, this.title, this.businessType, this.amount, this.validity, this.label, this.currency,this.discountPlan});

  PlanInfoData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    currency = json['currency'];
    businessType = json['business_type'];
    amount = json['amount'];
    validity = json['validity'];
    label = json['label'];
    discountPlan = json['discount_plan_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['business_type'] = businessType;
    data['currency'] = currency;
    data['amount'] = amount;
    data['validity'] = validity;
    data['label'] = label;
    data['discount_plan_amount'] = discountPlan;
    return data;
  }
}
