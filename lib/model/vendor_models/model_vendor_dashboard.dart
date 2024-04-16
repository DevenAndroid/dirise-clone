class ModelVendorDashboard {
  bool? status;
  dynamic message;
  Dashboard? dashboard;
  List<Order>? order;

  ModelVendorDashboard({this.status, this.message, this.dashboard, this.order});

  ModelVendorDashboard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    dashboard = json['dashboard'] != null ? Dashboard.fromJson(json['dashboard']) : null;

    if (json['order'] != null) {
      order = <Order>[];
      json['order'].forEach((v) {
        order!.add(Order.fromJson(v));
      });
    } else {
      order = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
  dynamic grossSales;
  dynamic earning;
  dynamic soldItems;
  dynamic orderReceived;
  dynamic storeOn;
  Map<String, String> values = {};

  // updateDashBoard(){
  //   // Gross Sales
  //   // Earning
  //   // Sold items
  //   // Order Received
  // }

  Dashboard({this.grossSales, this.earning, this.soldItems, this.orderReceived, this.storeOn});

  Dashboard.fromJson(Map<String, dynamic> json) {
    grossSales = json['gross_sales'];
    earning = json['earning'];
    soldItems = json['sold_items'];
    orderReceived = json['order_received'];
    storeOn = json['store_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gross_sales'] = grossSales;
    data['earning'] = earning;
    data['sold_items'] = soldItems;
    data['order_received'] = orderReceived;
    data['store_on'] = storeOn;
    return data;
  }

  Map<String, dynamic> getJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gross_sales'] = grossSales ?? "0";
    data['earning'] = earning ?? "0";
    data['sold_items'] = soldItems ?? "0";
    data['order_received'] = orderReceived ?? "0";
    return data;
  }
}

class Order {
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
  dynamic discount;
  dynamic totalPrice;
  dynamic tax;
  dynamic status;
  dynamic startDate;
  dynamic sloatTime;
  dynamic sloatEndTime;
  dynamic endDate;
  dynamic updatedAt;
  dynamic createdDate;
  OrderShipping? orderShipping;
  OrderMeta? orderMeta;
  dynamic expectedDate;
  List<OrderItem>? orderItem;

  Order(
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
      this.discount,
      this.orderShipping,
      this.totalPrice,
      this.tax,
      this.status,
      this.startDate,
      this.sloatTime,
      this.sloatEndTime,
      this.endDate,
      this.updatedAt,
      this.createdDate,
      this.orderMeta,
      this.expectedDate,
      this.orderItem});

  Order.fromJson(Map<String, dynamic> json) {
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
    discount = json['discount'];
    totalPrice = json['total_price'];
    tax = json['tax'];
    status = json['status'];
    startDate = json['start_date'];
    sloatTime = json['sloat_time'];
    sloatEndTime = json['sloat_end_time'];
    endDate = json['end_date'];
    updatedAt = json['updated_at'];
    createdDate = json['created_date'];
    orderMeta = json['order_meta'] != null ? OrderMeta.fromJson(json['order_meta']) : null;
    orderShipping = json['order_shipping'] != null ? OrderShipping.fromJson(json['order_shipping']) : null;
    expectedDate = json['expected_date'];
    if (json['order_item'] != null) {
      orderItem = <OrderItem>[];
      json['order_item'].forEach((v) {
        orderItem!.add(OrderItem.fromJson(v));
      });
    }
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
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    data['tax'] = tax;
    data['status'] = status;
    data['start_date'] = startDate;
    data['sloat_time'] = sloatTime;
    data['sloat_end_time'] = sloatEndTime;
    data['end_date'] = endDate;
    data['updated_at'] = updatedAt;
    data['created_date'] = createdDate;
    if (orderMeta != null) {
      data['order_meta'] = orderMeta!.toJson();
    }
    if (orderShipping != null) {
      data['order_shipping'] = orderShipping!.toJson();
    }
    data['expected_date'] = expectedDate;
    if (orderItem != null) {
      data['order_item'] = orderItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderMeta {
  dynamic billingFirstName;
  dynamic billingLastName;
  dynamic billingPhone;
  dynamic billingAlternatePhone;
  dynamic billingAddress2;
  dynamic billingAddressType;
  dynamic billingCity;
  dynamic billingCountry;
  dynamic billingState;
  dynamic billingZipCode;
  dynamic billingLandmark;
  dynamic subtotalPrice;
  dynamic totalPrice;
  dynamic giftCardAmount;
  dynamic giftCardData;
  dynamic currencySign;
  dynamic shippingPrice;
  // List<Shipping>? shipping;
  dynamic shippingFirstName;
  dynamic shippingLastName;
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

  OrderMeta(
      {this.billingFirstName,
      this.billingLastName,
      this.billingPhone,
      this.billingAlternatePhone,
      this.billingAddress2,
      this.billingAddressType,
      this.billingCity,
      this.billingCountry,
      this.billingState,
      this.billingZipCode,
      this.billingLandmark,
      this.subtotalPrice,
      this.totalPrice,
      this.giftCardAmount,
      this.giftCardData,
      this.currencySign,
      this.shippingPrice,
      // this.shipping,
      this.shippingFirstName,
      this.shippingLastName,
      this.shippingPhone,
      this.shippingAlternatePhone,
      this.shippingAddress2,
      this.shippingAddressType,
      this.shippingCity,
      this.shippingCountry,
      this.shippingState,
      this.shippingZipCode,
      this.shippingLandmark,
      this.refundAmountIn});

  OrderMeta.fromJson(Map<String, dynamic> json) {
    billingFirstName = json['billing_first_name'];
    billingLastName = json['billing_last_name'];
    billingPhone = json['billing_phone'];
    billingAlternatePhone = json['billing_alternate_phone'];
    billingAddress2 = json['billing_address2'];
    billingAddressType = json['billing_address_type'];
    billingCity = json['billing_city'];
    billingCountry = json['billing_country'];
    billingState = json['billing_state'];
    billingZipCode = json['billing_zip_code'];
    billingLandmark = json['billing_landmark'];
    subtotalPrice = json['subtotal_price'];
    totalPrice = json['total_price'];
    giftCardAmount = json['gift_card_amount'];
    giftCardData = json['gift_card_data'];
    currencySign = json['currency_sign'];
    shippingPrice = json['shipping_price'];
    // if (json['shipping'] != null) {
    //   shipping = <Shipping>[];
    //   json['shipping'].forEach((v) {
    //     shipping!.add(Shipping.fromJson(v));
    //   });
    // }
    shippingFirstName = json['shipping_first_name'];
    shippingLastName = json['shipping_last_name'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['billing_first_name'] = billingFirstName;
    data['billing_last_name'] = billingLastName;
    data['billing_phone'] = billingPhone;
    data['billing_alternate_phone'] = billingAlternatePhone;
    data['billing_address2'] = billingAddress2;
    data['billing_address_type'] = billingAddressType;
    data['billing_city'] = billingCity;
    data['billing_country'] = billingCountry;
    data['billing_state'] = billingState;
    data['billing_zip_code'] = billingZipCode;
    data['billing_landmark'] = billingLandmark;
    data['subtotal_price'] = subtotalPrice;
    data['total_price'] = totalPrice;
    data['gift_card_amount'] = giftCardAmount;
    data['gift_card_data'] = giftCardData;
    data['currency_sign'] = currencySign;
    data['shipping_price'] = shippingPrice;
    // if (shipping != null) {
    //   data['shipping'] = shipping!.map((v) => v.toJson()).toList();
    // }
    data['shipping_first_name'] = shippingFirstName;
    data['shipping_last_name'] = shippingLastName;
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
    return data;
  }
}

class OrderShipping {
 dynamic id;
 dynamic orderId;
 dynamic vendorId;
  dynamic shippingTitle;
  dynamic shippingPrice;
  dynamic createdAt;
  dynamic updatedAt;

  OrderShipping(
      {this.id,
        this.orderId,
        this.vendorId,
        this.shippingTitle,
        this.shippingPrice,
        this.createdAt,
        this.updatedAt});

  OrderShipping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    vendorId = json['vendor_id'];
    shippingTitle = json['shipping_title'];
    shippingPrice = json['shipping_price'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['vendor_id'] = this.vendorId;
    data['shipping_title'] = this.shippingTitle;
    data['shipping_price'] = this.shippingPrice;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}


class Shipping {
  dynamic storeId;
  dynamic storeName;
  dynamic title;
  dynamic shipPrice;

  Shipping({this.storeId, this.storeName, this.title, this.shipPrice});

  Shipping.fromJson(Map<String, dynamic> json) {
    storeId = json['store_id'];
    storeName = json['store_name'];
    title = json['title'];
    shipPrice = json['ship_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['store_id'] = storeId;
    data['store_name'] = storeName;
    data['title'] = title;
    data['ship_price'] = shipPrice;
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
  dynamic quantity;
  dynamic productPrice;
  dynamic discount;
  dynamic totalPrice;
  dynamic tax;
  dynamic status;
  dynamic startDate;
  dynamic sloatTime;
  dynamic sloatEndTime;
  dynamic endDate;
  dynamic createdAt;
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
      this.quantity,
      this.productPrice,
      this.discount,
      this.totalPrice,
      this.tax,
      this.status,
      this.startDate,
      this.sloatTime,
      this.sloatEndTime,
      this.endDate,
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
    quantity = json['quantity'];
    productPrice = json['product_price'];
    discount = json['discount'];
    totalPrice = json['total_price'];
    tax = json['tax'];
    status = json['status'];
    startDate = json['start_date'];
    sloatTime = json['sloat_time'];
    sloatEndTime = json['sloat_end_time'];
    endDate = json['end_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    featuredImage = json['featured_image'];
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
    data['discount'] = discount;
    data['total_price'] = totalPrice;
    data['tax'] = tax;
    data['status'] = status;
    data['start_date'] = startDate;
    data['sloat_time'] = sloatTime;
    data['sloat_end_time'] = sloatEndTime;
    data['end_date'] = endDate;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['featured_image'] = featuredImage;
    return data;
  }
}
