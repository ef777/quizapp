class UpdateModel {
  bool? success;
  Data2? data;
  String? message;

  UpdateModel({this.success, this.data, this.message});

  UpdateModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data2.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = message;
    return data;
  }
}

class Data2 {
  String? token;
  String? name;
  bool? status;

  Data2({this.token, this.name, this.status});

  Data2.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['name'] = name;
    data['status'] = status;
    return data;
  }
}
