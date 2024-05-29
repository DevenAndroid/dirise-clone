class ModelProductRemark {
  bool? status;
  String? message;
  List<Data>? data;

  ModelProductRemark({this.status, this.message, this.data});

  ModelProductRemark.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
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
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic userId;
  dynamic productId;
  dynamic remark;
  dynamic date;
  dynamic postedBy;

  Data(
      {this.id,
        this.userId,
        this.productId,
        this.remark,
        this.date,
        this.postedBy});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    remark = json['remark'];
    date = json['date'];
    postedBy = json['posted_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['remark'] = this.remark;
    data['date'] = this.date;
    data['posted_by'] = this.postedBy;
    return data;
  }
}
