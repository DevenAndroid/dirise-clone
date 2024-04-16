class ModelPaymentMethods {
  bool? status;
  dynamic message;
  List<Data>? data;

  ModelPaymentMethods({this.status, this.message, this.data});

  ModelPaymentMethods.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic paymentMethodId;
  dynamic paymentMethodAr;
  dynamic paymentMethodEn;
  dynamic paymentMethodCode;
  bool? isDirectPayment;
  dynamic serviceCharge;
  dynamic totalAmount;
  dynamic currencyIso;
  dynamic imageUrl;
  bool? isEmbeddedSupported;
  dynamic paymentCurrencyIso;

  Data(
      {this.paymentMethodId,
        this.paymentMethodAr,
        this.paymentMethodEn,
        this.paymentMethodCode,
        this.isDirectPayment,
        this.serviceCharge,
        this.totalAmount,
        this.currencyIso,
        this.imageUrl,
        this.isEmbeddedSupported,
        this.paymentCurrencyIso});

  Data.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['PaymentMethodId'];
    paymentMethodAr = json['PaymentMethodAr'];
    paymentMethodEn = json['PaymentMethodEn'];
    paymentMethodCode = json['PaymentMethodCode'];
    isDirectPayment = json['IsDirectPayment'];
    serviceCharge = json['ServiceCharge'];
    totalAmount = json['TotalAmount'];
    currencyIso = json['CurrencyIso'];
    imageUrl = json['ImageUrl'];
    isEmbeddedSupported = json['IsEmbeddedSupported'];
    paymentCurrencyIso = json['PaymentCurrencyIso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PaymentMethodId'] = paymentMethodId;
    data['PaymentMethodAr'] = paymentMethodAr;
    data['PaymentMethodEn'] = paymentMethodEn;
    data['PaymentMethodCode'] = paymentMethodCode;
    data['IsDirectPayment'] = isDirectPayment;
    data['ServiceCharge'] = serviceCharge;
    data['TotalAmount'] = totalAmount;
    data['CurrencyIso'] = currencyIso;
    data['ImageUrl'] = imageUrl;
    data['IsEmbeddedSupported'] = isEmbeddedSupported;
    data['PaymentCurrencyIso'] = paymentCurrencyIso;
    return data;
  }
}
