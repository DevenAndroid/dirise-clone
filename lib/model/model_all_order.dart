class ModelDataOrder {
  bool? status;
  String? message;
  List<Order>? order;

  ModelDataOrder({this.status, this.message, this.order});

  ModelDataOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (order != null) {
      data['order'] = order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Order {
  dynamic id;
  dynamic parentId;
  dynamic orderId;
  dynamic userId;
  String? status;
  String? statusNote;
  String? shippingType;
  dynamic shippingPrice;
  String? shippingMethod;
  String? paymentMode;
  String? paymentStatus;
  String? currencyCode;
  dynamic couponId;
  dynamic couponCode;
  String? discountAmount;
  String? createdAt;
  DateTime? createdAtDateTime;
  String? updatedAt;
  dynamic childId;
  dynamic productId;
  dynamic vendorId;
  String? productName;
  String? category;
  String? productType;
  String? quantity;
  String? productPrice;
  dynamic discount;
  dynamic totalPrice;
  dynamic tax;
  dynamic startDate;
  dynamic sloatTime;
  dynamic endDate;
  List<dynamic>? products;

  Order(
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
      this.currencyCode,
      this.couponId,
      this.couponCode,
      this.discountAmount,
      this.createdAt,
      this.createdAtDateTime,
      this.updatedAt,
      this.childId,
      this.productId,
      this.vendorId,
      this.productName,
      this.category,
      this.productType,
      this.quantity,
      this.productPrice,
      this.discount,
      this.totalPrice,
      this.tax,
      this.startDate,
      this.sloatTime,
      this.endDate,
      this.products});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    status = json['status'] ?? "";
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
    createdAt = json['created_at'];
    createdAtDateTime = DateTime.tryParse(json['created_at'].toString());
    updatedAt = json['updated_at'];
    childId = json['child_id'];
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    productName = json['product_name'];
    category = json['category'];
    productType = json['product_type'];
    quantity = json['quantity'];
    productPrice = json['product_price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    tax = json['tax'];
    startDate = json['start_date'];
    sloatTime = json['sloat_time'];
    endDate = json['end_date'];
    if (json['products'] != null) {
      products = <dynamic>[];
      // json['products'].forEach((v) {
      //   products!.add(new Null.fromJson(v));
      // });
    }
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
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['child_id'] = childId;
    data['product_id'] = productId;
    data['vendor_id'] = vendorId;
    data['product_name'] = productName;
    data['category'] = category;
    data['product_type'] = productType;
    data['quantity'] = quantity;
    data['product_price'] = productPrice;
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    data['tax'] = tax;
    data['start_date'] = startDate;
    data['sloat_time'] = sloatTime;
    data['end_date'] = endDate;
    // if (this.products != null) {
    //   data['products'] = this.products!.map((v) => v!.toJson()).toList();
    // }
    return data;
  }
}
