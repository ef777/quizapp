import 'package:dio/dio.dart';

import '../../const/const.dart';

var dio = Dio();

Future<bool> registerStudentService(
    {required String? path,
    required String name,
    required String surname,
    required String password,
    required String mail,
    required String levelsId,
    required String phone,
    required String tcNumber,
    required String paswordAgain}) async {
  // Text data

  String? fileName = path?.split('/').last;
  var data = {
    "email": mail,
    "name": name,
    "password": password,
    "c_password": paswordAgain,
    "levels_id": levelsId,
    "surname": surname,
    "tc": tcNumber,
    "phone": phone,
    if (path != null)
      "picture": await MultipartFile.fromFile(path, filename: fileName),
  };

  try {
    // File

    // Create form data
    FormData formData = FormData.fromMap({
      ...data, // Add text data
      // Add the file
    });

    // Send data
    var response = await dio.post(
      "$baseUrl"
      "registerStudent", // API'nin tam yolunu buraya ekleyin
      data: formData,
      options: Options(
        headers: {
          // Eğer başlık eklemek isterseniz
        },
      ),
    );

    print("Upload response: ${response.data}");
    if (response.statusCode == 200) {
      bool status = response.data['data']['status'];
      print('Status: $status');
      return status;
    } else {
      print('Request failed with status: ${response.statusCode}.');
      return false;
    }
  } catch (e, stacktrace) {
    print("Upload error: $e");
    print(stacktrace);
    return false;
  }
}
