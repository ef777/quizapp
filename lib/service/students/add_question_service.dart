import 'package:dio/dio.dart';

import '../../const/const.dart';
import '../../model/add_model.dart';

Future<AddModel> questionAddService(
    {required String teacherId,
    required String imageFile,
    required String type}) async {
  const String url = 'https://aciksoru.com.tr/api/questionsAdd';
  String? bearerToken = Config.bareerToken;
  print(teacherId);
  Dio dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Authorization'] = 'Bearer $bearerToken';
  print(Config.userId);
  FormData formData = FormData.fromMap({
    "student_id": Config.userId,
    "teacher_id": teacherId,
    "type": type,
    "picture": await MultipartFile.fromFile(imageFile, filename: "upload.jpg"),
  });

  try {
    var response = await dio.post(url, data: formData);
    print(response.data);
    if (response.statusCode == 200) {
      return AddModel.fromJson(response.data);
    } else {
      throw Exception("Kademe Bulunamadı");
    }
  } catch (e) {
    print("Exception: $e");
    return throw Exception("Soru Eklenemedi");
  }
}
