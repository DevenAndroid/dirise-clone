import 'product_model/model_product_element.dart';

class ModelVirtualAssets {
  bool? status;
  dynamic message;
  List<ProductElement>? product;

  ModelVirtualAssets({this.status, this.message, this.product});

  ModelVirtualAssets.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['Product'] != null) {
      product = <ProductElement>[];
      json['Product'].forEach((v) {
        product!.add(ProductElement.fromJson(v));
      });
    } else {
      product = [];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (product != null) {
      data['Product'] = product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
