class ActiveTeacherModel {
  bool? success;
  List<Data>? data;
  String? message;

  ActiveTeacherModel({this.success, this.data, this.message});

  ActiveTeacherModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  String? email;
  String? name;
  String? surname;
  int? levelsId;
  int? branchId;
  int? experienceYear;
  String? phoneGSM;
  String? phone;
  String? tc;
  String? picture;
  String? role;
  String? cv;
  String? iban;
  String? bankName;
  String? address;
  String? city;
  String? country;
  String? zipcode;
  String? active;
  String? isChecked;
  String? deleted;
  String? lastLoginDate;
  String? createdAt;
  String? updatedAt;
  int? rating;
  String? branchName;
  String? levelName;

  Data(
      {this.id,
      this.email,
      this.name,
      this.surname,
      this.levelsId,
      this.branchId,
      this.experienceYear,
      this.phoneGSM,
      this.phone,
      this.tc,
      this.picture,
      this.role,
      this.cv,
      this.iban,
      this.bankName,
      this.address,
      this.city,
      this.country,
      this.zipcode,
      this.active,
      this.isChecked,
      this.deleted,
      this.lastLoginDate,
      this.createdAt,
      this.updatedAt,
      this.rating,
      this.branchName,
      this.levelName});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    name = json['name'];
    surname = json['surname'];
    levelsId = json['levels_id'];
    branchId = json['branch_id'];
    experienceYear = json['experience_year'];
    phoneGSM = json['phoneGSM'];
    phone = json['phone'];
    tc = json['tc'];
    picture = json['picture'];
    role = json['role'];
    cv = json['cv'];
    iban = json['iban'];
    bankName = json['bankName'];
    address = json['address'];
    city = json['city'];
    country = json['country'];
    zipcode = json['zipcode'];
    active = json['active'];
    isChecked = json['isChecked'];
    deleted = json['deleted'];
    lastLoginDate = json['lastLoginDate'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rating = json['rating'];
    branchName = json['branch_name'];
    levelName = json['level_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['name'] = this.name;
    data['surname'] = this.surname;
    data['levels_id'] = this.levelsId;
    data['branch_id'] = this.branchId;
    data['experience_year'] = this.experienceYear;
    data['phoneGSM'] = this.phoneGSM;
    data['phone'] = this.phone;
    data['tc'] = this.tc;
    data['picture'] = this.picture;
    data['role'] = this.role;
    data['cv'] = this.cv;
    data['iban'] = this.iban;
    data['bankName'] = this.bankName;
    data['address'] = this.address;
    data['city'] = this.city;
    data['country'] = this.country;
    data['zipcode'] = this.zipcode;
    data['active'] = this.active;
    data['isChecked'] = this.isChecked;
    data['deleted'] = this.deleted;
    data['lastLoginDate'] = this.lastLoginDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['rating'] = this.rating;
    data['branch_name'] = this.branchName;
    data['level_name'] = this.levelName;
    return data;
  }
}
