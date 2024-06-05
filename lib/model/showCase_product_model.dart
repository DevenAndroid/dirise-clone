class GetShowCaseProductModel {
  bool? status;
  String? message;
  List<ShowcaseProduct>? showcaseProduct;

  GetShowCaseProductModel({this.status, this.message, this.showcaseProduct});

  GetShowCaseProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['showcase_product'] != null) {
      showcaseProduct = <ShowcaseProduct>[];
      json['showcase_product'].forEach((v) {
        showcaseProduct!.add(new ShowcaseProduct.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.showcaseProduct != null) {
      data['showcase_product'] =
          this.showcaseProduct!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ShowcaseProduct {
  String? pname;
  Null? shortDescription;
  String? featuredImage;
  String? discountPrice;
  String? discountOff;

  ShowcaseProduct(
      {this.pname,
        this.shortDescription,
        this.featuredImage,
        this.discountPrice,
        this.discountOff});

  ShowcaseProduct.fromJson(Map<String, dynamic> json) {
    pname = json['pname'];
    shortDescription = json['short_description'];
    featuredImage = json['featured_image'];
    discountPrice = json['discount_price'];
    discountOff = json['discount_off'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pname'] = this.pname;
    data['short_description'] = this.shortDescription;
    data['featured_image'] = this.featuredImage;
    data['discount_price'] = this.discountPrice;
    data['discount_off'] = this.discountOff;
    return data;
  }
}
