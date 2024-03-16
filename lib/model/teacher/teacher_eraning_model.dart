class TeacherEarningModel {
  int? lastMonthEarnings;
  int? thisMonthEarnings;
  int? pastMonthsEarnings;

  TeacherEarningModel(
      {this.lastMonthEarnings,
      this.thisMonthEarnings,
      this.pastMonthsEarnings});

  TeacherEarningModel.fromJson(Map<String, dynamic> json) {
    lastMonthEarnings = json['lastMonthEarnings'];
    thisMonthEarnings = json['thisMonthEarnings'];
    pastMonthsEarnings = json['pastMonthsEarnings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lastMonthEarnings'] = lastMonthEarnings;
    data['thisMonthEarnings'] = thisMonthEarnings;
    data['pastMonthsEarnings'] = pastMonthsEarnings;
    return data;
  }
}
