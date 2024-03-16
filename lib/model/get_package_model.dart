class GetPackageModel {
  bool? success;
  Data? data;
  String? message;

  GetPackageModel({this.success, this.data, this.message});

  GetPackageModel.fromJson(Map<String, dynamic> json) {
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
  List<Response>? response;
  bool? status;

  Data({this.response, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['response'] != null) {
      response = <Response>[];
      json['response'].forEach((v) {
        response!.add(Response.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    return data;
  }
}

class Response {
  int? id;
  String? name;
  String? description;
  int? price;
  int? packDay;
  int? amountPicture;
  int? amountVideo;
  String? status;
  String? deleted;
  String? createdAt;
  String? updatedAt;

  Response(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.packDay,
      this.amountPicture,
      this.amountVideo,
      this.status,
      this.deleted,
      this.createdAt,
      this.updatedAt});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    packDay = json['pack_day'];
    amountPicture = json['amountPicture'];
    amountVideo = json['amountVideo'];
    status = json['status'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['pack_day'] = packDay;
    data['amountPicture'] = amountPicture;
    data['amountVideo'] = amountVideo;
    data['status'] = status;
    data['deleted'] = deleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
