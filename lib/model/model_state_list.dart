class ModelStateList {
  bool? status;
  String? message;
  List<State>? state;

  ModelStateList({this.status, this.message, this.state});

  ModelStateList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['state'] != null) {
      state = <State>[];
      json['state'].forEach((v) {
        state!.add(new State.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.state != null) {
      data['state'] = this.state!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class State {
  int? stateId;
  String? stateName;
  String? arabStateName;
  int? countryId;

  State({this.stateId, this.stateName, this.arabStateName, this.countryId});

  State.fromJson(Map<String, dynamic> json) {
    stateId = json['state_id'];
    stateName = json['state_name'];
    arabStateName = json['arab_state_name'];
    countryId = json['country_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state_id'] = this.stateId;
    data['state_name'] = this.stateName;
    data['arab_state_name'] = this.arabStateName;
    data['country_id'] = this.countryId;
    return data;
  }
}
