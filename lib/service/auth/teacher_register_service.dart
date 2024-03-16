import 'package:dio/dio.dart';

import '../../const/const.dart';

var dio = Dio();

Future<bool> registerTeacher(
    {required String? path,
    required String name,
    required String password,
    required String tcNumber,
    required String surname,
    required String phone,
    required String mail,
    required String levelsId,
    required String branchId,
    required String experienceYear,
    required String iban,
    required String bankName,
    required String? cv,
    required String paswordAgain}) async {
  // Text data

  String? fileName = path?.split('/').last;
  var data = {
    "email": mail,
    "name": name,
    "surname": surname,
    "password": password,
    "c_password": paswordAgain,
    "levels_id": levelsId,
    "branch_id": branchId,
    "tc": tcNumber,
    "experience_year": experienceYear,
    "iban": iban,
    "phone": phone,
    "bankName": bankName,
    if (path != null)
      "picture": await MultipartFile.fromFile(path, filename: fileName),
    if (cv != null) "cv": await MultipartFile.fromFile(cv, filename: fileName),
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
      "registerTeacher", // API'nin tam yolunu buraya ekleyin
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
    print(e);
    print("Upload error: $e");
    print(stacktrace);
    return false;
  }
}
