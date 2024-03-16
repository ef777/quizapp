import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../const/const.dart';
import '../../model/teacher/teacher_eraning_model.dart';

//
Future<TeacherEarningModel?> getTeacherEarning({String? id}) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/getTeacherEarnings');

  final response = await http.get(url, headers: {
    'Authorization': 'Bearer ${Config.bareerToken}',
  });
  print(response.body);
  if (response.statusCode == 200) {
    return TeacherEarningModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  return null;
}
