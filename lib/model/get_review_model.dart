class ModelGetReview {
  dynamic status;
  dynamic message;
  List<Data>? data;
  dynamic reviewCount;

  ModelGetReview({this.status, this.message, this.data,this.reviewCount});

  ModelGetReview.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    reviewCount = json['reviewCount'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['reviewCount'] = this.reviewCount;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic email;
  dynamic name;
  dynamic comment;
  dynamic productId;
  dynamic ratingNumber;
  dynamic createdAt;
  dynamic updatedAt;

  Data(
      {this.id,
        this.email,
        this.name,
        this.comment,
        this.productId,
        this.ratingNumber,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    comment = json['comment'];
    productId = json['product_id'];
    ratingNumber = json['rating_number'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['comment'] = this.comment;
    data['product_id'] = this.productId;
    data['rating_number'] = this.ratingNumber;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
