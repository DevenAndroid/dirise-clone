import 'product_model/model_product_element.dart';
class ModelStoreProducts {
  bool? status;
  dynamic message;
  List<ProductElement>? data = [];

  ModelStoreProducts({this.status, this.message, this.data});

  ModelStoreProducts.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ProductElement>[];
      json['data'].forEach((v) {
        data!.add(ProductElement.fromJson(v));
      });
    } else {
      data = [];
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
