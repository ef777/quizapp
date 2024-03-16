import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../model/student_model/level_model.dart';

Future<LevelModel?> getLevelService({String? name}) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/levelsGet');

  final response = await http.post(url, body: {"name": name});
  print(response.body);
  if (response.statusCode == 200) {
    return LevelModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  return null;
}
