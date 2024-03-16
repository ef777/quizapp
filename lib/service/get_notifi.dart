// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../const/const.dart';
import '../model/notifi_model.dart';

//
Future<NotifiModel?> getNotifi({String? id}) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/notifications');

  final response = await http.post(url, headers: {
    'Authorization': 'Bearer ${Config.bareerToken}',
  }, body: {
    "user_id": id
  });
  print(response.body);
  if (response.statusCode == 200) {
    return NotifiModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  return null;
}
