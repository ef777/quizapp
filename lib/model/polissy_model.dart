class PolicistyModel {
  String? name;
  String? content;

  PolicistyModel({this.name, this.content});

  PolicistyModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['content'] = this.content;
    return data;
  }
}
