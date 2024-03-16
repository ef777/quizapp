import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../const/const.dart';
import '../../model/get_package_model.dart';

Future<GetPackageModel> getPackageService() async {
  final url = Uri.parse('https://aciksoru.com.tr/api/packetsGet');
  final String? bearerToken = Config.bareerToken;

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
  );

  print(response.body);
  if (response.statusCode == 200) {
    return GetPackageModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  throw Exception("Kademe Bulunamadı");
}
