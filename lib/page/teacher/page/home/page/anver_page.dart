// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:acik_soru/const/const.dart';
import 'package:acik_soru/page/teacher/page/home/teacher_home_page.dart';
import 'package:acik_soru/service/send_notification.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../../model/add_model.dart';
import '../../../../../widget/custom_button.dart';

class AnsverPage extends StatelessWidget {
  const AnsverPage({
    Key? key,
    required this.file,
    required this.quesId,
    required this.studentId,
    required this.lessonName,
  }) : super(key: key);
  final String file;
  final String quesId;
  final String studentId;
  final String lessonName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cevap Gönder'),
        ),
        body: Column(
          children: [
            Image.file(
              File(file),
            ),
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                color: context.general.colorScheme.primary,
                onPressed: () {
                  questionAddAnsverService(
                          quesId: quesId, imageFile: file, studentId: studentId)
                      .then((value) {
                    if (value.data?.status ?? false) {
                      sendNotification(
                          userId: studentId,
                          desc: "$lessonName Dersine Ait Soruya Cevap Hazır",

                          /// "Gİden veri kontrol et"
                          title: "Soruna Cevap Geldi");
                      CherryToast.success(
                              title: const Text(
                                  "Soru cevabı başarıyla gönderildi"))
                          .show(context);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TeacherHomePage(),
                          ),
                          (route) => false);
                    } else {
                      CherryToast.error(
                              title: const Text(
                                  "Soru cevabı gönderilemedi tekrar deneyiniz"))
                          .show(context);
                    }
                  });
                },
                title: "Cevap Gönder",
              ),
            )
          ],
        ));
  }
}

Future<AddModel> questionAddAnsverService({
  required String quesId,
  required String imageFile,
  required String studentId,
}) async {
  const String url = 'https://aciksoru.com.tr/api/questionsAnswerAdd';
  String? bearerToken = Config.bareerToken;

  Dio dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Authorization'] = 'Bearer $bearerToken';

  FormData formData = FormData.fromMap({
    // "student_id": studentId,
    // "teacher_id": userID,

    "id": quesId,
    "pictureAnswer":
        await MultipartFile.fromFile(imageFile, filename: "upload.jpg"),
  });

  try {
    var response = await dio.post(url, data: formData);
    if (response.statusCode == 200) {
      print(response.data);
      return AddModel.fromJson(response.data);
    } else {
      throw Exception("Kademe Bulunamadı");
    }
  } catch (e) {
    print("Exception: $e");
    return throw Exception("Soru Eklenemedi");
  }
//   Future<bool> uploadData(
//     {required String path,
//     required String nameSurname,
//     required String password,
//     required String phone,
//     required String mail,
//     required String levelsId,
//     required String paswordAgain}) async {
//   // Text data

//   String fileName = path.split('/').last;
//   var data = {
//     "email": mail,
//     "name": nameSurname,
//     "password": password,
//     "c_password": paswordAgain,
//     "levels_id": levelsId,
//     "phone": phone,
//     "picture": await MultipartFile.fromFile(path, filename: fileName),
//   };

//   try {
//     // File

//     // Create form data
//     FormData formData = FormData.fromMap({
//       ...data, // Add text data
//       // Add the file
//     });

//     // Send data
//     var response = await dio.post(
//       "$apiBaseUrl"
//       "registerStudent", // API'nin tam yolunu buraya ekleyin
//       data: formData,
//       options: Options(
//         headers: {
//           // Eğer başlık eklemek isterseniz
//         },
//       ),
//     );

//     print("Upload response: ${response.data}");
//     if (response.statusCode == 200) {
//       bool status = response.data['data']['status'];
//       print('Status: $status');
//       return status;
//     } else {
//       print('Request failed with status: ${response.statusCode}.');
//       return false;
//     }
//   } catch (e, stacktrace) {
//     print("Upload error: $e");
//     print(stacktrace);
//     return false;
//   }
// }
}
