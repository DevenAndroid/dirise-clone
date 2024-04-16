import 'dart:convert';
import 'product_model/model_product_element.dart';

class WhishlistModel {
  bool? status;
  String? message;
  List<ProductElement>? wishlist;

  WhishlistModel({
    this.status,
    this.message,
    this.wishlist,
  });

  factory WhishlistModel.fromRawJson(String str) => WhishlistModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WhishlistModel.fromJson(Map<String, dynamic> json) => WhishlistModel(
        status: json["status"],
        message: json["message"],
        wishlist: json["wishlist"] == null ? [] : List<ProductElement>.from(json["wishlist"]!.map((x) => ProductElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "wishlist": wishlist == null ? [] : List<dynamic>.from(wishlist!.map((x) => x.toJson())),
      };
}
