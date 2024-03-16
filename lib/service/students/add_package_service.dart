import 'dart:convert';

import 'package:acik_soru/const/const.dart';
import 'package:http/http.dart' as http;

import '../../model/add_model.dart';

Future<AddModel?> packageAdd(
    {required String packetId, required int? userId}) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/packetUsersAdd');
  final String? bearerToken = Config.bareerToken;
  
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
    body: jsonEncode({
      "address": "addres",
      "city": "Konya",
      'country': "Türkiye",
      'zipcode': "42060",
      'packet_id': packetId,
      "user_id": userId,
      "ip_address": "192.182.1.1",
      "cardName": "Kemal Erkmen",
      "cardNumber": "5890040000000016",
      "expireMonth": "12",
      "expireYear": "2026",
      "cvc": "333"
    }),
  );

  print(response.body);
  if (response.statusCode == 200) {
    //   return AddModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  return null;
  //throw Exception("Kademe Bulunamadı");
}
