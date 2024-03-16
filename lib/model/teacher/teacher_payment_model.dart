// class TeacherPaymentModel {
// 	bool? success;
// 	Data? data;
// 	String? message;

// 	TeacherPaymentModel({this.success, this.data, this.message});

// 	TeacherPaymentModel.fromJson(Map<String, dynamic> json) {
// 		success = json['success'];
// 		data = json['data'] != null ? new Data.fromJson(json['data']) : null;
// 		message = json['message'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['success'] = this.success;
// 		if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
// 		data['message'] = this.message;
// 		return data;
// 	}
// }

// class Data {
// 	Response? response;
// 	bool? status;

// 	Data({this.response, this.status});

// 	Data.fromJson(Map<String, dynamic> json) {
// 		response = json['response'] != null ? new Response.fromJson(json['response']) : null;
// 		status = json['status'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		if (this.response != null) {
//       data['response'] = this.response!.toJson();
//     }
// 		data['status'] = this.status;
// 		return data;
// 	}
// }

// class Response {
// 	102023? 1102023;

// 	Response({this.1102023});

// 	Response.fromJson(Map<String, dynamic> json) {
// 		1102023 = json['10-2023'] != null ? new 102023.fromJson(json['10-2023']) : null;
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		if (this.1102023 != null) {
//       data['10-2023'] = this.1102023!.toJson();
//     }
// 		return data;
// 	}
// }

// class 102023 {
// 	int? payments;
// 	List<PaymentsDate>? paymentsDate;

// 	102023({this.payments, this.paymentsDate});

// 	102023.fromJson(Map<String, dynamic> json) {
// 		payments = json['payments'];
// 		if (json['paymentsDate'] != null) {
// 			paymentsDate = <PaymentsDate>[];
// 			json['paymentsDate'].forEach((v) { paymentsDate!.add(new PaymentsDate.fromJson(v)); });
// 		}
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['payments'] = this.payments;
// 		if (this.paymentsDate != null) {
//       data['paymentsDate'] = this.paymentsDate!.map((v) => v.toJson()).toList();
//     }
// 		return data;
// 	}
// }

// class PaymentsDate {
// 	int? id;
// 	int? userId;
// 	int? payments;
// 	String? createdAt;
// 	String? updatedAt;
// 	String? paymentCreatedAt;
// 	String? email;
// 	String? password;
// 	String? name;
// 	String? surname;
// 	int? levelsId;
// 	int? branchId;
// 	int? experienceYear;
// 	String? phoneGSM;
// 	String? phone;
// 	String? tc;
// 	String? picture;
// 	String? role;
// 	String? cv;
// 	String? iban;
// 	String? bankName;
// 	Null? address;
// 	Null? city;
// 	Null? country;
// 	Null? zipcode;
// 	String? active;
// 	String? isChecked;
// 	String? deleted;
// 	String? lastLoginDate;

// 	PaymentsDate({this.id, this.userId, this.payments, this.createdAt, this.updatedAt, this.paymentCreatedAt, this.email, this.password, this.name, this.surname, this.levelsId, this.branchId, this.experienceYear, this.phoneGSM, this.phone, this.tc, this.picture, this.role, this.cv, this.iban, this.bankName, this.address, this.city, this.country, this.zipcode, this.active, this.isChecked, this.deleted, this.lastLoginDate});

// 	PaymentsDate.fromJson(Map<String, dynamic> json) {
// 		id = json['id'];
// 		userId = json['user_id'];
// 		payments = json['payments'];
// 		createdAt = json['created_at'];
// 		updatedAt = json['updated_at'];
// 		paymentCreatedAt = json['paymentCreatedAt'];
// 		email = json['email'];
// 		password = json['password'];
// 		name = json['name'];
// 		surname = json['surname'];
// 		levelsId = json['levels_id'];
// 		branchId = json['branch_id'];
// 		experienceYear = json['experience_year'];
// 		phoneGSM = json['phoneGSM'];
// 		phone = json['phone'];
// 		tc = json['tc'];
// 		picture = json['picture'];
// 		role = json['role'];
// 		cv = json['cv'];
// 		iban = json['iban'];
// 		bankName = json['bankName'];
// 		address = json['address'];
// 		city = json['city'];
// 		country = json['country'];
// 		zipcode = json['zipcode'];
// 		active = json['active'];
// 		isChecked = json['isChecked'];
// 		deleted = json['deleted'];
// 		lastLoginDate = json['lastLoginDate'];
// 	}

// 	Map<String, dynamic> toJson() {
// 		final Map<String, dynamic> data = new Map<String, dynamic>();
// 		data['id'] = this.id;
// 		data['user_id'] = this.userId;
// 		data['payments'] = this.payments;
// 		data['created_at'] = this.createdAt;
// 		data['updated_at'] = this.updatedAt;
// 		data['paymentCreatedAt'] = this.paymentCreatedAt;
// 		data['email'] = this.email;
// 		data['password'] = this.password;
// 		data['name'] = this.name;
// 		data['surname'] = this.surname;
// 		data['levels_id'] = this.levelsId;
// 		data['branch_id'] = this.branchId;
// 		data['experience_year'] = this.experienceYear;
// 		data['phoneGSM'] = this.phoneGSM;
// 		data['phone'] = this.phone;
// 		data['tc'] = this.tc;
// 		data['picture'] = this.picture;
// 		data['role'] = this.role;
// 		data['cv'] = this.cv;
// 		data['iban'] = this.iban;
// 		data['bankName'] = this.bankName;
// 		data['address'] = this.address;
// 		data['city'] = this.city;
// 		data['country'] = this.country;
// 		data['zipcode'] = this.zipcode;
// 		data['active'] = this.active;
// 		data['isChecked'] = this.isChecked;
// 		data['deleted'] = this.deleted;
// 		data['lastLoginDate'] = this.lastLoginDate;
// 		return data;
// 	}
// }
