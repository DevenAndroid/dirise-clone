class OrderHistoryModel {
  bool? status;
 dynamic message;
  Dashboard? dashboard;
  List<Order>? order;

  OrderHistoryModel({this.status, this.message, this.dashboard, this.order});

  OrderHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dashboard = json['dashboard'] != null
        ? new Dashboard.fromJson(json['dashboard'])
        : null;
    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(new Order.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (dashboard != null) {
      data['dashboard'] = dashboard!.toJson();
    }
    if (order != null) {
      data['order'] = order!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dashboard {
 dynamic numberOfViews;
 dynamic totalOrders;
 dynamic pendingOrders;
 dynamic completedOrders;

  Dashboard(
      {this.numberOfViews,
        this.totalOrders,
        this.pendingOrders,
        this.completedOrders});

  Dashboard.fromJson(Map<String, dynamic> json) {
    numberOfViews = json['number_of_views'];
    totalOrders = json['total_orders'];
    pendingOrders = json['pending_orders'];
    completedOrders = json['completed_orders'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number_of_views'] = numberOfViews;
    data['total_orders'] = totalOrders;
    data['pending_orders'] = pendingOrders;
    data['completed_orders'] = completedOrders;
    return data;
  }
}

class Order {
 dynamic id;
 dynamic parentId;
 dynamic orderId;
 dynamic userId;
 dynamic vendorId;
 dynamic status;
 dynamic statusNote;
 dynamic shippingType;
 dynamic shippingPrice;
 dynamic shippingMethod;
 dynamic paymentMode;
 dynamic paymentStatus;
 dynamic currencyCode;
 dynamic couponId;
 dynamic couponCode;
 dynamic discountAmount;
 dynamic isShipmentCreated;
 dynamic deliveryType;
 dynamic grandTotal;
 dynamic vendorShippingType;
 dynamic updatedAt;
 dynamic createdDate;
  OrderMeta? orderMeta;
 dynamic expectedDate;
  List<OrderItem>? orderItem;

  Order(
      {this.id,
        this.parentId,
        this.orderId,
        this.userId,
        this.vendorId,
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
        this.isShipmentCreated,
        this.deliveryType,
        this.grandTotal,
        this.vendorShippingType,
        this.updatedAt,
        this.createdDate,
        this.orderMeta,
        this.expectedDate,
        this.orderItem});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    parentId = json['parent_id'];
    orderId = json['order_id'];
    userId = json['user_id'];
    vendorId = json['vendor_id'];
    status = json['status'];
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
    isShipmentCreated = json['is_shipment_created'];
    deliveryType = json['delivery_type'];
    grandTotal = json['grand_total'];
    vendorShippingType = json['vendor_shipping_type'];
    updatedAt = json['updated_at'];
    createdDate = json['created_date'];
    orderMeta = json['order_meta'] != null
        ? new OrderMeta.fromJson(json['order_meta'])
        : null;
    expectedDate = json['expected_date'];
    if (json['order_item'] != null) {
      orderItem = <OrderItem>[];
      json['order_item'].forEach((v) {
        orderItem!.add(new OrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['parent_id'] = parentId;
    data['order_id'] = orderId;
    data['user_id'] = userId;
    data['vendor_id'] = vendorId;
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
    data['is_shipment_created'] = isShipmentCreated;
    data['delivery_type'] = deliveryType;
    data['grand_total'] = grandTotal;
    data['vendor_shipping_type'] = vendorShippingType;
    data['updated_at'] = updatedAt;
    data['created_date'] = createdDate;
    if (orderMeta != null) {
      data['order_meta'] = orderMeta!.toJson();
    }
    data['expected_date'] = expectedDate;
    if (orderItem != null) {
      data['order_item'] = orderItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderMeta {
 dynamic billingAlternatePhone;
 dynamic billingFirstName;
 dynamic billingLastName;
 dynamic billingEmail;
 dynamic billingPhone;
 dynamic billingAddress2;
 dynamic billingAddressType;
 dynamic billingCity;
 dynamic billingCountry;
 dynamic billingState;
 dynamic billingZipCode;
 dynamic billingLandmark;
 dynamic subtotalPrice;
 dynamic totalPrice;
 dynamic discountedPrice;
 dynamic discountAmount;
 dynamic giftCardAmount;
 dynamic giftCardData;
 dynamic currencySign;
 dynamic shippingPrice;
 dynamic shipping;
 dynamic shippingFirstName;
 dynamic shippingLastName;
 dynamic shippingEmail;
 dynamic shippingPhone;
 dynamic shippingAlternatePhone;
 dynamic shippingAddress2;
 dynamic shippingAddressType;
 dynamic shippingCity;
 dynamic shippingCountry;
 dynamic shippingState;
 dynamic shippingZipCode;
 dynamic shippingLandmark;
 dynamic refundAmountIn;
 dynamic orderId;

  OrderMeta(
      {this.billingAlternatePhone,
        this.billingFirstName,
        this.billingLastName,
        this.billingEmail,
        this.billingPhone,
        this.billingAddress2,
        this.billingAddressType,
        this.billingCity,
        this.billingCountry,
        this.billingState,
        this.billingZipCode,
        this.billingLandmark,
        this.subtotalPrice,
        this.totalPrice,
        this.discountedPrice,
        this.discountAmount,
        this.giftCardAmount,
        this.giftCardData,
        this.currencySign,
        this.shippingPrice,
        this.shipping,
        this.shippingFirstName,
        this.shippingLastName,
        this.shippingEmail,
        this.shippingPhone,
        this.shippingAlternatePhone,
        this.shippingAddress2,
        this.shippingAddressType,
        this.shippingCity,
        this.shippingCountry,
        this.shippingState,
        this.shippingZipCode,
        this.shippingLandmark,
        this.refundAmountIn,
        this.orderId});

  OrderMeta.fromJson(Map<String, dynamic> json) {
    billingAlternatePhone = json['billing_alternate_phone'];
    billingFirstName = json['billing_first_name'];
    billingLastName = json['billing_last_name'];
    billingEmail = json['billing_email'];
    billingPhone = json['billing_phone'];
    billingAddress2 = json['billing_address2'];
    billingAddressType = json['billing_address_type'];
    billingCity = json['billing_city'];
    billingCountry = json['billing_country'];
    billingState = json['billing_state'];
    billingZipCode = json['billing_zip_code'];
    billingLandmark = json['billing_landmark'];
    subtotalPrice = json['subtotal_price'];
    totalPrice = json['total_price'];
    discountedPrice = json['discounted_price'];
    discountAmount = json['discount_amount'];
    giftCardAmount = json['gift_card_amount'];
    giftCardData = json['gift_card_data'];
    currencySign = json['currency_sign'];
    shippingPrice = json['shipping_price'];
    shipping = json['shipping'];
    shippingFirstName = json['shipping_first_name'];
    shippingLastName = json['shipping_last_name'];
    shippingEmail = json['shipping_email'];
    shippingPhone = json['shipping_phone'];
    shippingAlternatePhone = json['shipping_alternate_phone'];
    shippingAddress2 = json['shipping_address2'];
    shippingAddressType = json['shipping_address_type'];
    shippingCity = json['shipping_city'];
    shippingCountry = json['shipping_country'];
    shippingState = json['shipping_state'];
    shippingZipCode = json['shipping_zip_code'];
    shippingLandmark = json['shipping_landmark'];
    refundAmountIn = json['refund_amount_in'];
    orderId = json['order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['billing_alternate_phone'] = billingAlternatePhone;
    data['billing_first_name'] = billingFirstName;
    data['billing_last_name'] = billingLastName;
    data['billing_email'] = billingEmail;
    data['billing_phone'] = billingPhone;
    data['billing_address2'] = billingAddress2;
    data['billing_address_type'] = billingAddressType;
    data['billing_city'] = billingCity;
    data['billing_country'] = billingCountry;
    data['billing_state'] = billingState;
    data['billing_zip_code'] = billingZipCode;
    data['billing_landmark'] = billingLandmark;
    data['subtotal_price'] = subtotalPrice;
    data['total_price'] = totalPrice;
    data['discounted_price'] = discountedPrice;
    data['discount_amount'] = discountAmount;
    data['gift_card_amount'] = giftCardAmount;
    data['gift_card_data'] = giftCardData;
    data['currency_sign'] = currencySign;
    data['shipping_price'] = shippingPrice;
    data['shipping'] = shipping;
    data['shipping_first_name'] = shippingFirstName;
    data['shipping_last_name'] = shippingLastName;
    data['shipping_email'] = shippingEmail;
    data['shipping_phone'] = shippingPhone;
    data['shipping_alternate_phone'] = shippingAlternatePhone;
    data['shipping_address2'] = shippingAddress2;
    data['shipping_address_type'] = shippingAddressType;
    data['shipping_city'] = shippingCity;
    data['shipping_country'] = shippingCountry;
    data['shipping_state'] = shippingState;
    data['shipping_zip_code'] = shippingZipCode;
    data['shipping_landmark'] = shippingLandmark;
    data['refund_amount_in'] = refundAmountIn;
    data['order_id'] = orderId;
    return data;
  }
}

class OrderItem {
 dynamic id;
 dynamic orderId;
 dynamic childId;
 dynamic productId;
 dynamic vendorId;
 dynamic userId;
 dynamic productName;
 dynamic category;
 dynamic productType;
 dynamic virtualProductType;
 dynamic quantity;
 dynamic productPrice;
 dynamic weight;
 dynamic weightUnit;
 dynamic discount;
 dynamic totalPrice;
 dynamic tax;
 dynamic status;
 dynamic startDate;
 dynamic sloatTime;
 dynamic sloatEndTime;
 dynamic endDate;
 dynamic variation;
 dynamic createdAt;
 DateTime? createdAtDateTime;
 dynamic updatedAt;
 dynamic featuredImage;

  OrderItem(
      {this.id,
        this.orderId,
        this.childId,
        this.productId,
        this.vendorId,
        this.userId,
        this.productName,
        this.category,
        this.productType,
        this.virtualProductType,
        this.quantity,
        this.productPrice,
        this.weight,
        this.weightUnit,
        this.discount,
        this.totalPrice,
        this.tax,
        this.status,
        this.startDate,
        this.sloatTime,
        this.sloatEndTime,
        this.createdAtDateTime,
        this.endDate,
        this.variation,
        this.createdAt,
        this.updatedAt,
        this.featuredImage});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    childId = json['child_id'];
    productId = json['product_id'];
    vendorId = json['vendor_id'];
    userId = json['user_id'];
    productName = json['product_name'];
    category = json['category'];
    productType = json['product_type'];
    virtualProductType = json['virtual_product_type'];
    createdAtDateTime = DateTime.tryParse(json['created_at'].toString());
    quantity = json['quantity'];
    productPrice = json['product_price'];
    weight = json['weight'];
    weightUnit = json['weight_unit'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    tax = json['tax'];
    status = json['status'];
    startDate = json['start_date'];
    sloatTime = json['sloat_time'];
    sloatEndTime = json['sloat_end_time'];
    endDate = json['end_date'];
    variation = json['variation'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    featuredImage = json['featured_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['order_id'] = orderId;
    data['child_id'] = childId;
    data['product_id'] = productId;
    data['vendor_id'] = vendorId;
    data['user_id'] = userId;
    data['product_name'] = productName;
    data['category'] = category;
    data['product_type'] = productType;
    data['virtual_product_type'] = virtualProductType;
    data['quantity'] = quantity;
    data['product_price'] = productPrice;
    data['weight'] = weight;
    data['weight_unit'] = weightUnit;
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    data['tax'] = tax;
    data['status'] = status;
    data['start_date'] = startDate;
    data['sloat_time'] = sloatTime;
    data['sloat_end_time'] = sloatEndTime;
    data['end_date'] = endDate;
    data['variation'] = variation;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['featured_image'] = featuredImage;
    return data;
  }
}
