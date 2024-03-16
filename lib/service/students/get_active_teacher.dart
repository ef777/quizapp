import 'dart:convert';
import 'package:acik_soru/model/student_model/active_teacher_model.dart';
import 'package:http/http.dart' as http;

import '../../const/const.dart';

Future<ActiveTeacherModel?> getActiveTeacher({
  required int id,
}) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/active-teacher');
  print(Config.bareerToken);
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      // 'id': id.toString(),
      'Authorization': 'Bearer ${Config.bareerToken}',
    },
    body: jsonEncode({
      'branch_id': id,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return ActiveTeacherModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  return null;
}
