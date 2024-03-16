class UserModel {
  bool? success;
  Data? data;
  String? message;

  UserModel({this.success, this.data, this.message});

  UserModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? name;
  String? email;
  int? branchId;
  int? experienceYear;
  String? phoneGSM;
  String? phone;
  String? tc;
  String? picture;
  String? cv;
  String? iban;
  String? bankName;
  String? address;
  String? city;
  String? country;
  String? zipcode;
  String? active;
  String? levelName;

  Data(
      {this.id,
      this.name,
      this.email,
      this.branchId,
      this.experienceYear,
      this.phoneGSM,
      this.phone,
      this.tc,
      this.picture,
      this.cv,
      this.iban,
      this.bankName,
      this.address,
      this.city,
      this.country,
      this.zipcode,
      this.active,
      this.levelName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    branchId = json['branch_id'];
    experienceYear = json['experience_year'];
    phoneGSM = json['phoneGSM'];
    phone = json['phone'];
    tc = json['tc'];
    picture = json['picture'];
    cv = json['cv'];
    iban = json['iban'];
    bankName = json['bankName'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    zipcode = json['zipcode'];
    active = json['active'];
    levelName = json['level_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['branch_id'] = this.branchId;
    data['experience_year'] = this.experienceYear;
    data['phoneGSM'] = this.phoneGSM;
    data['phone'] = this.phone;
    data['tc'] = this.tc;
    data['picture'] = this.picture;
    data['cv'] = this.cv;
    data['iban'] = this.iban;
    data['bankName'] = this.bankName;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['zipcode'] = this.zipcode;
    data['active'] = this.active;
    data['level_name'] = this.levelName;
    return data;
  }
}
