import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../model/student_model/lesson_model.dart';

Future<LessonsModel?> getLessonsService({required int id, String? name}) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/branchandlevels');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      // 'id': id.toString(),
      'Authorization':
          'Bearer 101|YAfTgHuvDfh362Q5GMJ7UKWUonbk9kqfuPo9XYmV5a154126',
    },
    body: jsonEncode({'levels_id': id, "name": name}),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return LessonsModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  return null;
}
