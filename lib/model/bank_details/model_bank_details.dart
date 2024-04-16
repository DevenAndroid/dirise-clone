class ModelBankInfo {
  bool? status;
  dynamic message;
  Data? data;

  ModelBankInfo({this.status, this.message, this.data});

  ModelBankInfo.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  dynamic id;
  dynamic bank;
  dynamic accountHolderName;
  dynamic accountNo;
  dynamic ifscCode;

  Data(
      {this.id,
        this.bank,
        this.accountHolderName,
        this.accountNo,
        this.ifscCode});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bank = json['bank'];
    accountHolderName = json['account_holder_name'];
    accountNo = json['account_no'];
    ifscCode = json['ifsc_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bank'] = bank;
    data['account_holder_name'] = accountHolderName;
    data['account_no'] = accountNo;
    data['ifsc_code'] = ifscCode;
    return data;
  }
}
