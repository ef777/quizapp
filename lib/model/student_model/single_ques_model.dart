class SingleQuesModel {
  bool? success;
  Data? data;
  String? message;

  SingleQuesModel({this.success, this.data, this.message});

  SingleQuesModel.fromJson(Map<String, dynamic> json) {
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
  Response? response;
  bool? status;

  Data({this.response, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class Response {
  int? id;
  int? studentId;
  int? teacherId;
  String? type;
  String? picture;
  String? pictureAnswer;
  String? isAnswer;
  String? isCompleted;
  String? deleted;
  String? createdAt;
  String? updatedAt;
  String? teacherName;
  String? branchName;
  int? teacherRating;

  Response(
      {this.id,
      this.studentId,
      this.teacherId,
      this.type,
      this.picture,
      this.pictureAnswer,
      this.isAnswer,
      this.isCompleted,
      this.deleted,
      this.createdAt,
      this.updatedAt,
      this.teacherName,
      this.branchName,
      this.teacherRating});

  Response.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    teacherId = json['teacher_id'];
    type = json['type'];
    picture = json['picture'];
    pictureAnswer = json['pictureAnswer'];
    isAnswer = json['isAnswer'];
    isCompleted = json['isCompleted'];
    deleted = json['deleted'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacherName = json['teacherName'];
    branchName = json['branchName'];
    teacherRating = json['teacherRating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_id'] = studentId;
    data['teacher_id'] = teacherId;
    data['type'] = type;
    data['picture'] = picture;
    data['pictureAnswer'] = pictureAnswer;
    data['isAnswer'] = isAnswer;
    data['isCompleted'] = isCompleted;
    data['deleted'] = deleted;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['teacherName'] = teacherName;
    data['branchName'] = branchName;
    data['teacherRating'] = teacherRating;
    return data;
  }
}
