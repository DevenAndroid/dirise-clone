import 'dart:convert';

import 'product_model/model_product_element.dart';

PopularProductsModal popularProductsModalFromJson(String str) => PopularProductsModal.fromJson(json.decode(str));

String popularProductsModalToJson(PopularProductsModal data) => json.encode(data.toJson());

class PopularProductsModal {
  bool? status;
  String? message;
  PopularProductsModalProduct? product;

  PopularProductsModal({
    this.status,
    this.message,
    this.product,
  });

  factory PopularProductsModal.fromJson(Map<String, dynamic> json) => PopularProductsModal(
        status: json["status"],
        message: json["message"],
        product: json["product"] == null ? null : PopularProductsModalProduct.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "product": product?.toJson(),
      };
}

class PopularProductsModalProduct {
  String? url;
  List<ProductElement>? product;

  PopularProductsModalProduct({
    this.url,
    this.product,
  });

  factory PopularProductsModalProduct.fromJson(Map<String, dynamic> json) => PopularProductsModalProduct(
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
