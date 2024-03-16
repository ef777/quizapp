import 'package:http/http.dart' as http;
import '../../const/const.dart';

Future<void> sendNotification(
    {required String userId,
    required String desc,
    required String title}) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/send-notification');
  final String? bearerToken = Config.bareerToken;

  final response = await http.post(url, headers: {
    'Authorization': 'Bearer $bearerToken',
  }, body: {
    "title": title,
    "description": desc,
    "user_id": userId
  });

  print(response.body);
  if (response.statusCode == 200) {
    // Başarılı yanıt işleme
  }
  print(response.body);
}
