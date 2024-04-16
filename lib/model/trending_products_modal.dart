import 'product_model/model_product_element.dart';

class TendingModel {
  bool? status;
  dynamic message;
  TendingModelProduct? product;

  TendingModel({
    this.status,
    this.message,
    this.product,
  });

  factory TendingModel.fromJson(Map<String, dynamic> json) => TendingModel(
        status: json["status"],
        message: json["message"],
        product: json["product"] == null ? null : TendingModelProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "product": product?.toJson(),
      };
}

class TendingModelProduct {
  dynamic url;
  List<ProductElement>? product;

  TendingModelProduct({
    this.url,
    this.product,
  });

  factory TendingModelProduct.fromJson(Map<String, dynamic> json) => TendingModelProduct(
        url: json["url"],
        product: json["product"] == null
            ? []
            : List<ProductElement>.from(json["product"]!.map((x) => ProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "product": product == null ? [] : List<dynamic>.from(product!.map((x) => x.toJson())),
      };
}
