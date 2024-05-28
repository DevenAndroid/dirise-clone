class CreateShipmentModel {
  bool? status;
  String? message;
  Data? data;

  CreateShipmentModel({this.status, this.message, this.data});

  CreateShipmentModel.fromJson(Map<String, dynamic> json) {
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
  String? trackingNo;
  String? url;

  Data({this.trackingNo, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    trackingNo = json['trackingNo'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['trackingNo'] = this.trackingNo;
    data['url'] = this.url;
    return data;
  }
}


class CreateShipmentModelError {
  bool? status;
  Message? errorMessage;

  CreateShipmentModelError({this.status, this.errorMessage});

  CreateShipmentModelError.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorMessage =
    json['message'] != null ? new Message.fromJson(json['message']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.errorMessage != null) {
      data['message'] = this.errorMessage!.toJson();
    }
    return data;
  }
}

class Message {
  dynamic transactionId;
  List<Errors>? errors;

  Message({this.transactionId, this.errors});

  Message.fromJson(Map<String, dynamic> json) {
    transactionId = json['transactionId'];
    if (json['errors'] != null) {
      errors = <Errors>[];
      json['errors'].forEach((v) {
        errors!.add(new Errors.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transactionId'] = this.transactionId;
    if (this.errors != null) {
      data['errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Errors {
  dynamic code;
  dynamic message;

  Errors({this.code, this.message});

  Errors.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    return data;
  }
}
