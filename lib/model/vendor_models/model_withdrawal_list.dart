class ModelWithdrawalList {
  bool? status;
  String? message;
  Data? data;

  ModelWithdrawalList({this.status, this.message, this.data});

  ModelWithdrawalList.fromJson(Map<String, dynamic> json) {
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
  String? earnedBalance;
  List<WithdrawalList>? withdrawalList;

  Data({this.earnedBalance, this.withdrawalList});

  Data.fromJson(Map<String, dynamic> json) {
    earnedBalance = json['earnedBalance'];
    // earnedBalance = "10000";
    if (json['withdrawalList'] != null) {
      withdrawalList = <WithdrawalList>[];
      json['withdrawalList'].forEach((v) {
        withdrawalList!.add(WithdrawalList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['earnedBalance'] = earnedBalance;
    if (withdrawalList != null) {
      data['withdrawalList'] =
          withdrawalList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WithdrawalList {
  int? id;
  String? amount;
  String? date;
  String? status;

  WithdrawalList({this.id, this.amount, this.date, this.status});

  WithdrawalList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    amount = json['amount'];
    date = json['date'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['date'] = date;
    data['status'] = status;
    return data;
  }
}
