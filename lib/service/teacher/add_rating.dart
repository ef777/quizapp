import 'package:dio/dio.dart';

import '../../const/const.dart';
import '../../model/add_model.dart';

Future<AddModel?> ratingService(
    {required String? teacherId,
    required int rating,
    required String questionId}) async {
  const String url = 'https://aciksoru.com.tr/api/rateTeacher';
  String? bearerToken = Config.bareerToken;

  Dio dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Authorization'] = 'Bearer $bearerToken';

  FormData formData = FormData.fromMap({
    "rating": rating,
    "teacher_id": teacherId,
    "question_id": questionId,
  });

  try {
    var response = await dio.post(url, data: formData);
    print(response.data);
    if (response.statusCode == 200) {
      return AddModel.fromJson(response.data);
    } else {
      return AddModel.fromJson(response.data);
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}
