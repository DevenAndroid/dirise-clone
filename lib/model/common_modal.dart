class ModelCommonResponse {
  bool? status;
  String? message;
  dynamic otp;
  dynamic uRL;

  ModelCommonResponse({this.status, this.message, this.otp,this.uRL});

  ModelCommonResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    otp = json['otp'];
    uRL = json['URL'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['otp'] = otp;
    data['URL'] = uRL;
    return data;
  }
}
