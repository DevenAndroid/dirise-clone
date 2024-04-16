class ModelStoreAvailability {
  bool? status;
  String? message;
  List<TimeData>? data;

  ModelStoreAvailability({this.status, this.message, this.data});

  ModelStoreAvailability.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <TimeData>[];
      json['data'].forEach((v) {
        data!.add(TimeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeData {
  dynamic id;
  dynamic weekDay;
  dynamic startTime;
  dynamic endTime;
  bool? status;

  TimeData({this.id, this.weekDay, this.startTime, this.endTime, this.status});

  TimeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weekDay = json['week_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['week_day'] = weekDay;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    return data;
  }
}