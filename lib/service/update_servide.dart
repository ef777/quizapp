import 'dart:convert';
import 'package:acik_soru/model/update_model.dart';
import 'package:http/http.dart' as http;

import '../../const/const.dart';
import '../model/auth/user_model.dart';

Future<UpdateModel?> userUpdate(Data? userModel) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/usersUpdate');

  final response = await http.post(url, headers: {
    'Authorization': 'Bearer ${Config.bareerToken}',
  }, body: {
    if (userModel?.name != null) "name": userModel?.name,
    if (userModel?.email != null) "email": userModel?.email,
    if (userModel?.phone != null) "phone": userModel?.phone,
    if (userModel?.bankName != null) "bankName": userModel?.bankName,
    if (userModel?.iban != null) "iban": userModel?.iban,
    if (userModel?.address != null) "address": userModel?.address,
    if (userModel?.city != null) "city": userModel?.city,
    if (userModel?.country != null) "country": userModel?.country,
    if (userModel?.zipcode != null) "zipcode": userModel?.zipcode,
  });

  if (response.statusCode == 200) {
    var model = UpdateModel.fromJson(jsonDecode(response.body));
    Config.bareerToken = model.data?.token;
    return model;
    // Başarılı yanıt işleme
  }
  return null;
}
