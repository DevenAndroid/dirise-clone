class SampleCsvModel {
  bool? status;
  String? message;
  Data? data;

  SampleCsvModel({this.status, this.message, this.data});

  SampleCsvModel.fromJson(Map<String, dynamic> json) {
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
  String? csvFile;

  Data({this.csvFile});

  Data.fromJson(Map<String, dynamic> json) {
    csvFile = json['csv_file'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['csv_file'] = this.csvFile;
    return data;
  }
}
