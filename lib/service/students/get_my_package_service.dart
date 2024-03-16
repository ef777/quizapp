import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../const/const.dart';
import '../../model/student_model/get_user_package_model.dart';

Future<GetUserPackageModel> getMyPackage() async {
  final url = Uri.parse('https://aciksoru.com.tr/api/packetUsersGet');
  final String? bearerToken = Config.bareerToken;
  print(Config.userId);
  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
    body: jsonEncode({
      'user_id': Config.userId,
    }),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return GetUserPackageModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  throw Exception("Kademe Bulunamadı");
}
