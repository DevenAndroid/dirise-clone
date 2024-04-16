class ModelAddReview {
  dynamic status;
  dynamic message;
  Data? data;

  ModelAddReview({this.status, this.message, this.data});

  ModelAddReview.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic comment;
  dynamic name;
  dynamic email;
  dynamic productId;
  dynamic updatedAt;
  dynamic createdAt;
  dynamic id;

  Data(
      {this.comment,
        this.name,
        this.email,
        this.productId,
        this.updatedAt,
        this.createdAt,
        this.id});

  Data.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    name = json['name'];
    email = json['email'];
    productId = json['product_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['name'] = this.name;
    data['email'] = this.email;
    data['product_id'] = this.productId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
