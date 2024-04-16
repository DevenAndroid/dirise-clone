class ModelVendorOrders {
  bool? status;
  dynamic message;
  Order? order;
  dynamic totalPage;

  ModelVendorOrders({this.status, this.message, this.order, this.totalPage});

  ModelVendorOrders.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    order = json['order'] != null && json['order'].toString() != "[]" ? Order.fromJson(json['order']) : Order(data: []);
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (order != null) {
      data['order'] = order!.toJson();
    }
    data['total_page'] = totalPage;
    return data;
  }
}

class Order {
  dynamic currentPage;
  List<OrderData>? data;
  dynamic firstPageUrl;
  dynamic from;
  dynamic lastPage;
  dynamic lastPageUrl;
  List<Links>? links;
  dynamic nextPageUrl;
  dynamic path;
  dynamic perPage;
  // Null? prevPageUrl;
  dynamic to;
  dynamic total;

  Order(
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
        // this.prevPageUrl,
        this.to,
        this.total});

  Order.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <OrderData>[];
      json['data'].forEach((v) {
        data!.add(OrderData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    // prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    // data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class OrderData {
  dynamic id;
  dynamic orderId;
  dynamic childId;
  dynamic productId;
  dynamic vendorId;
  dynamic userId;
  dynamic productName;
  dynamic category;
  dynamic productType;
  dynamic quantity;
  dynamic productPrice;
  // Null? discount;
  dynamic totalPrice;
  dynamic tax;
  dynamic status;
  dynamic startDate;
  dynamic sloatTime;
  dynamic sloatEndTime;
  // Null? endDate;
  // Null? variation;
  dynamic updatedAt;
  dynamic createdDate;
  // Null? orderMeta;
  dynamic expectedDate;
  // List<Null>? orderItem;

  OrderData(
      {this.id,
        this.orderId,
        this.childId,
        this.productId,
        this.vendorId,
        this.userId,
        this.productName,
        this.category,
        this.productType,
        this.quantity,
        this.productPrice,
        // this.discount,
        this.totalPrice,
        this.tax,
        this.status,
        this.startDate,
        this.sloatTime,
        this.sloatEndTime,
        // this.endDate,
        // this.variation,
        this.updatedAt,
        this.createdDate,
        // this.orderMeta,
        this.expectedDate,
        // this.orderItem
      });

  OrderData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    childId = json['child_id'];
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    userId = json['user_id'];
    productName = json['product_name'];
    category = json['category'];
    productType = json['product_type'];
    quantity = json['quantity'];
    productPrice = json['product_price'];
    // discount = json['discount'];
    totalPrice = json['total_price'];
    tax = json['tax'];
    status = json['status'];
    startDate = json['start_date'];
    sloatTime = json['sloat_time'];
    sloatEndTime = json['sloat_end_time'];
    // endDate = json['end_date'];
    // variation = json['variation'];
    updatedAt = json['updated_at'];
    createdDate = json['created_date'];
    // orderMeta = json['order_meta'];
    expectedDate = json['expected_date'];
    // if (json['order_item'] != null) {
    //   orderItem = <Null>[];
    //   json['order_item'].forEach((v) {
    //     orderItem!.add(Null.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_id'] = orderId;
    data['child_id'] = childId;
    data['product_id'] = productId;
    data['vendor_id'] = vendorId;
    data['user_id'] = userId;
    data['product_name'] = productName;
    data['category'] = category;
    data['product_type'] = productType;
    data['quantity'] = quantity;
    data['product_price'] = productPrice;
    // data['discount'] = discount;
    data['total_price'] = totalPrice;
    data['tax'] = tax;
    data['status'] = status;
    data['start_date'] = startDate;
    data['sloat_time'] = sloatTime;
    data['sloat_end_time'] = sloatEndTime;
    // data['end_date'] = endDate;
    // data['variation'] = variation;
    data['updated_at'] = updatedAt;
    data['created_date'] = createdDate;
    // data['order_meta'] = orderMeta;
    data['expected_date'] = expectedDate;
    // if (orderItem != null) {
    //   data['order_item'] = orderItem!.map((v) => v.toJson()).toList();
    // }
    return data;
  }
}

class Links {
  dynamic url;
  dynamic label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['label'] = label;
    data['active'] = active;
    return data;
  }
}
