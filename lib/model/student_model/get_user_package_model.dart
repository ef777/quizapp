class GetUserPackageModel {
  bool? success;
  Data? data;
  String? message;

  GetUserPackageModel({this.success, this.data, this.message});

  GetUserPackageModel.fromJson(Map<String, dynamic> json) {
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
  Response? response;
  bool? status;

  Data({this.response, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Response {
  int? id;
  int? packetId;
  int? userId;
  int? amountPicture;
  int? amountVideo;
  String? deleted;
  String? createdAt;
  String? updatedAt;
  String? packetName;
  String? packetPicture;
  int? packetPrice;
  String? packetDescription;

  Response(
      {this.id,
      this.packetId,
      this.userId,
      this.amountPicture,
      this.amountVideo,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.packetName,
      this.packetPicture,
      this.packetPrice,
      this.packetDescription});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packetId = json['packet_id'];
    userId = json['user_id'];
    amountPicture = json['amountPicture'];
    amountVideo = json['amountVideo'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    packetName = json['packetName'];
    packetPicture = json['packetPicture'];
    packetPrice = json['packetPrice'];
    packetDescription = json['packetDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['packet_id'] = this.packetId;
    data['user_id'] = this.userId;
    data['amountPicture'] = this.amountPicture;
    data['amountVideo'] = this.amountVideo;
    data['deleted'] = this.deleted;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['packetName'] = this.packetName;
    data['packetPicture'] = this.packetPicture;
    data['packetPrice'] = this.packetPrice;
    data['packetDescription'] = this.packetDescription;
    return data;
  }
}
