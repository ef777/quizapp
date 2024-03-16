class LoginModel {
  bool? success;
  Data? data;
  String? message;

  LoginModel({this.success, this.data, this.message});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
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

class Data {
  String? token;
  int? id;
  String? name;
  String? phone;
  String? picture;
  String? role;
  String? branchName;
  int? experienceYear;

  Data(
      {this.token,
      this.id,
      this.name,
      this.phone,
      this.picture,
      this.role,
      this.branchName,
      this.experienceYear});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    picture = json['picture'];
    role = json['role'];
    branchName = json['branchName'];
    experienceYear = json['experience_year'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['picture'] = picture;
    data['role'] = role;
    data['branchName'] = branchName;
    data['experience_year'] = experienceYear;
    return data;
  }
}
