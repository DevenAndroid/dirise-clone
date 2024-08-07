import 'package:dirise/model/product_model/model_product_element.dart';

class ModelStoreProducts {
  dynamic status;
  dynamic message;
  VendorProducts? vendorProducts;

  ModelStoreProducts({this.status, this.message, this.vendorProducts});

  ModelStoreProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    vendorProducts = json['vendor_products'] != null
        ? new VendorProducts.fromJson(json['vendor_products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (vendorProducts != null) {
      data['vendor_products'] = vendorProducts!.toJson();
    }
    return data;
  }
}

class VendorProducts {
  dynamic currentPage;
  List<ProductElement>? data = [];
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  dynamic prevPageUrl;
  dynamic to;
  dynamic total;

  VendorProducts(
      {this.currentPage,
        this.data,
        this.firstPageUrl,
        this.from,
        this.lastPage,
        this.lastPageUrl,
        this.links,
        this.nextPageUrl,
        this.path,
        this.perPage,
        this.prevPageUrl,
        this.to,
        this.total});

  VendorProducts.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ProductElement>[];
      json['data'].forEach((v) {
        data!.add(new ProductElement.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    if (links != null) {
      data['links'] = links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class ShippingPolicy {
  dynamic id;
  dynamic vendorId;
  dynamic title;
  dynamic days;
  dynamic description;
  dynamic shippingType;
  dynamic freeFor;
  dynamic aboveShipping;
  dynamic shippingZone;
  dynamic range1Min;
  dynamic range1Max;
  dynamic range1Percent;
  dynamic range2Min;
  dynamic range2Max;
  dynamic range2Percent;
  dynamic priceLimit;
  dynamic isDefault;
  dynamic createdAt;
  dynamic updatedAt;

  ShippingPolicy(
      {this.id,
        this.vendorId,
        this.title,
        this.days,
        this.description,
        this.shippingType,
        this.freeFor,
        this.aboveShipping,
        this.shippingZone,
        this.range1Min,
        this.range1Max,
        this.range1Percent,
        this.range2Min,
        this.range2Max,
        this.range2Percent,
        this.priceLimit,
        this.isDefault,
        this.createdAt,
        this.updatedAt});

  ShippingPolicy.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    vendorId = json['vendor_id'];
    title = json['title'];
    days = json['days'];
    description = json['description'];
    shippingType = json['shipping_type'];
    freeFor = json['free_for'];
    aboveShipping = json['above_shipping'];
    shippingZone = json['shipping_zone'];
    range1Min = json['range1_min'];
    range1Max = json['range1_max'];
    range1Percent = json['range1_percent'];
    range2Min = json['range2_min'];
    range2Max = json['range2_max'];
    range2Percent = json['range2_percent'];
    priceLimit = json['price_limit'];
    isDefault = json['is_default'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['vendor_id'] = vendorId;
    data['title'] = title;
    data['days'] = days;
    data['description'] = description;
    data['shipping_type'] = shippingType;
    data['free_for'] = freeFor;
    data['above_shipping'] = aboveShipping;
    data['shipping_zone'] = shippingZone;
    data['range1_min'] = range1Min;
    data['range1_max'] = range1Max;
    data['range1_percent'] = range1Percent;
    data['range2_min'] = range2Min;
    data['range2_max'] = range2Max;
    data['range2_percent'] = range2Percent;
    data['price_limit'] = priceLimit;
    data['is_default'] = isDefault;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Links {
  dynamic url;
  dynamic label;
  dynamic active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
