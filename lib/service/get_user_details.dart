import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../const/const.dart';
import '../model/auth/user_model.dart';

Future<UserModel?> getUserDetails() async {
  final url = Uri.parse('https://aciksoru.com.tr/api/getUserDetails');

  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Config.bareerToken}',
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    return UserModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  return null;
}
