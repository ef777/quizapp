import 'package:dio/dio.dart';

import '../../const/const.dart';
import '../../model/teacher/status_model.dart';

Future<StatusModel?> changeStatus({
  required String? teacherId,
}) async {
  const String url = 'https://aciksoru.com.tr/api/activestatusTeacher';
  String? bearerToken = Config.bareerToken;

  Dio dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Authorization'] = 'Bearer $bearerToken';

  FormData formData = FormData.fromMap({
    "id": teacherId,
  });

  try {
    var response = await dio.post(url, data: formData);
    print(response.data);
    if (response.statusCode == 200) {
      return StatusModel.fromJson(response.data);
    } else {
      return StatusModel.fromJson(response.data);
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}
