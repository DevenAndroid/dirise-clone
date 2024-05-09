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
        data!.add(new TimeData.fromJson(v));
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

class TimeData {
  dynamic id;
  dynamic weekDay;
  dynamic startTime;
  dynamic endTime;
  dynamic startBreakTime;
  dynamic endBreakTime;
  bool? status;

  TimeData(
      {this.id,
        this.weekDay,
        this.startTime,
        this.endTime,
        this.startBreakTime,
        this.endBreakTime,
        this.status});

  TimeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    weekDay = json['week_day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    startBreakTime = json['start_break_time'];
    endBreakTime = json['end_break_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['week_day'] = this.weekDay;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['start_break_time'] = this.startBreakTime;
    data['end_break_time'] = this.endBreakTime;
    data['status'] = this.status;
    return data;
  }
}
