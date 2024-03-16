// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../const/const.dart';

//
Future<List<dynamic>?> getPoliticiy({String? id}) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/getActivePages');

  final response = await http.get(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Config.bareerToken}',
    },
  );
  print(response.body);
  if (response.statusCode == 200) {
    List<dynamic> modelData =
        jsonDecode(response.body); // Veriyi JSON'a dönüştürdükten sonra

    int dataLength = modelData.length; // Listenin uzunluğunu alır
    print("Veri uzunluğu: $dataLength");
    // Başarılı yanıt işleme
    return modelData;
  }
  return null;
}
