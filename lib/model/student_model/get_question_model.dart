class GetQuestionModel {
  bool? success;
  Data? data;
  String? message;

  GetQuestionModel({this.success, this.data, this.message});

  GetQuestionModel.fromJson(Map<String, dynamic> json) {
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
  List<Questions>? questions;
  bool? status;

  Data({this.questions, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(new Questions.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.questions != null) {
      data['questions'] = this.questions!.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Questions {
  int? questionId;
  String? isAnswer;
  String? type;
  String? picture;
  String? pictureAnswer;
  String? teacherName;
  int? teacherId;
  int? studentId;
  String? branchName;
  int? teacherReview;

  Questions(
      {this.questionId,
      this.isAnswer,
      this.type,
      this.picture,
      this.pictureAnswer,
      this.teacherName,
      this.teacherId,
      this.studentId,
      this.branchName,
      this.teacherReview});

  Questions.fromJson(Map<String, dynamic> json) {
    questionId = json['question_id'];
    isAnswer = json['is_answer'];
    type = json['type'];
    picture = json['picture'];
    pictureAnswer = json['pictureAnswer'];
    teacherName = json['teacher_name'];
    teacherId = json['teacher_id'];
    studentId = json['student_id'];
    branchName = json['branch_name'];
    teacherReview = json['teacher_review'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question_id'] = this.questionId;
    data['is_answer'] = this.isAnswer;
    data['type'] = this.type;
    data['picture'] = this.picture;
    data['pictureAnswer'] = this.pictureAnswer;
    data['teacher_name'] = this.teacherName;
    data['teacher_id'] = this.teacherId;
    data['student_id'] = this.studentId;
    data['branch_name'] = this.branchName;
    data['teacher_review'] = this.teacherReview;
    return data;
  }
}
