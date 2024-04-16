class ModelPlaceOrderResponse {
  bool? status;
  String? message;
  String? URL;
  dynamic order_id;

  ModelPlaceOrderResponse({this.status, this.message, this.order_id, this.URL});

  ModelPlaceOrderResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    URL = json['URL'];
    message = json['message'];
    order_id = json['Order_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['URL'] = URL;
    data['Order_id'] = order_id;
    return data;
  }
}
