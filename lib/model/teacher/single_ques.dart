class SingleQuestionModel {
  bool? success;
  Data? data;
  String? message;

  SingleQuestionModel({this.success, this.data, this.message});

  SingleQuestionModel.fromJson(Map<String, dynamic> json) {
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
  Questions? questions;
  bool? status;

  Data({this.questions, this.status});

  Data.fromJson(Map<String, dynamic> json) {
    questions = json['questions'] != null
        ? Questions.fromJson(json['questions'])
        : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (questions != null) {
      data['questions'] = questions!.toJson();
    }
    data['status'] = status;
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
  Null? teacherReview;

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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['question_id'] = questionId;
    data['is_answer'] = isAnswer;
    data['type'] = type;
    data['picture'] = picture;
    data['pictureAnswer'] = pictureAnswer;
    data['teacher_name'] = teacherName;
    data['teacher_id'] = teacherId;
    data['student_id'] = studentId;
    data['branch_name'] = branchName;
    data['teacher_review'] = teacherReview;
    return data;
  }
}
