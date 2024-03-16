// ignore_for_file: deprecated_member_use, avoid_print
import 'dart:io';

import 'package:acik_soru/page/teacher/page/home/teacher_home_page.dart';
import 'package:acik_soru/service/send_notification.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

import 'dart:convert';
import 'package:acik_soru/page/students/profile/widget/ques_packet_select.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:photo_view/photo_view.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../../const/const.dart';
import '../../../../../model/teacher/single_ques.dart';
import '../../../../../widget/custom_button.dart';
import 'anver_page.dart';

Future<SingleQuestionModel> getQuestion(String quesId) async {
  final url = Uri.parse('https://aciksoru.com.tr/api/onlyQuestionget');
  final String? bearerToken = Config.bareerToken;

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
    body: jsonEncode({'id': quesId}),
  );
  print(response.body);
  if (response.statusCode == 200) {
    return SingleQuestionModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  throw Exception("Kademe Bulunamadı");
}

final picker = ImagePicker();
Future<void> _pickImageFromGallery(
    BuildContext context, String id, studentId, lessonName) async {
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    File tempFile = File(pickedFile.path);
    // img.Image? image = img.decodeImage(tempFile.readAsBytesSync());
    // img.Image resizedImg = img.copyResize(image!, width: 500);

    // final tempDir = await getTemporaryDirectory();
    // var newPath = '${tempDir.path}/resized_image.jpg';

    // File newFile = File(newPath)..writeAsBytesSync(img.encodeJpg(resizedImg));

    // ignore: use_build_context_synchronously
    questionAddAnsverService(
            quesId: id, imageFile: tempFile.path, studentId: studentId)
        .then((value) {
      if (value.data?.status ?? false) {
        print(studentId);
        sendNotification(
            userId: studentId,
            desc: "Sorunun cevabı hazır",

            /// "Gİden veri kontrol et"
            title: "Soruna Cevap Geldi");
        CherryToast.success(
                title: const Text("Soru cevabı başarıyla gönderildi"))
            .show(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const TeacherHomePage(),
            ),
            (route) => false);
      } else {
        CherryToast.error(
                title: const Text("Soru cevabı gönderilemedi tekrar deneyiniz"))
            .show(context);
      }
    });
  }
  //   context.navigateToPage(AnsverPage(
  //     lessonName: lessonName,
  //     quesId: id,
  //     file: tempFile.path,
  //     studentId: studentId,
  //   ));
  // } else {
  //   print('Fotoğraf seçilmedi.');
  // }
}

Future<void> _pickVideoFromGallery(
    BuildContext context, String id, studentId, lessonName) async {
  final pickedFile = await picker.pickVideo(source: ImageSource.gallery);
  if (pickedFile != null) {
    File tempFile = File(pickedFile.path);
    // img.Image? image = img.decodeImage(tempFile.readAsBytesSync());
    // img.Image resizedImg = img.copyResize(image!, width: 500);

    // final tempDir = await getTemporaryDirectory();
    // var newPath = '${tempDir.path}/resized_image.jpg';

    // File newFile = File(newPath)..writeAsBytesSync(img.encodeJpg(resizedImg));

    // ignore: use_build_context_synchronously
    questionAddAnsverService(
            quesId: id, imageFile: tempFile.path, studentId: studentId)
        .then((value) {
      if (value.data?.status ?? false) {
        sendNotification(
            userId: studentId,
            desc: "$lessonName Dersine Ait Soruya Cevap Hazır",

            /// "Gİden veri kontrol et"
            title: "Soruna Cevap Geldi");
        CherryToast.success(
                title: const Text("Soru cevabı başarıyla gönderildi"))
            .show(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const TeacherHomePage(),
            ),
            (route) => false);
      } else {
        CherryToast.error(
                title: const Text("Soru cevabı gönderilemedi tekrar deneyiniz"))
            .show(context);
      }
    });

    // context.navigateToPage(AnsverPage(
    //   lessonName: lessonName,
    //   quesId: id,
    //   file: tempFile.path,
    //   studentId: studentId,
    // ));
  } else {
    print('Fotoğraf seçilmedi.');
  }
}

Future<void> _captureImageWithCamera(
    BuildContext context, String id, studentId, lessonName) async {
  final pickedFile = await picker.pickImage(source: ImageSource.camera);
  if (pickedFile != null) {
    File tempFile = File(pickedFile.path);

    img.Image? image = img.decodeImage(tempFile.readAsBytesSync());
    img.Image resizedImg = img.copyResize(image!, width: 500);

    final tempDir = await getTemporaryDirectory();
    var newPath = '${tempDir.path}/resized_image.jpg';

    File newFile = File(newPath)..writeAsBytesSync(img.encodeJpg(resizedImg));

    // ignore: use_build_context_synchronously
    questionAddAnsverService(
            quesId: id, imageFile: tempFile.path, studentId: studentId)
        .then((value) {
      if (value.data?.status ?? false) {
        sendNotification(
            userId: "22",
            desc: "$lessonName Dersine Ait Soruya Cevap Hazır",
            title: "Soruna Cevap Geldi");
        CherryToast.success(
                title: const Text("Soru cevabı başarıyla gönderildi"))
            .show(context);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const TeacherHomePage(),
            ),
            (route) => false);
      } else {
        CherryToast.error(
                title: const Text("Soru cevabı gönderilemedi tekrar deneyiniz"))
            .show(context);
      }
    });
  }
}

class QuestionDetailPage extends StatelessWidget {
  const QuestionDetailPage(
      {super.key, required this.quesId, required this.lessonName});
  final String quesId;
  final String lessonName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<SingleQuestionModel>(
            future: getQuestion(quesId),
            builder: (context, snapshot) {
              print(snapshot.error);
              if (snapshot.hasData) {
                bool isType = true;
                String? type = snapshot.data?.data?.questions?.type;
                // String? studentId =
                //     snapshot.data?.data?.questions?..toString();

                if (type == "picture") {
                  isType = true;
                } else {
                  isType = false;
                }
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () => _showFullImage(
                            context,
                            snapshot.data?.data?.questions?.picture
                                    .toString() ??
                                "https://i.pinimg.com/originals/00/d9/49/00d949ab8dd9f210128dfa543c5ac810.jpg"),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                              snapshot.data?.data?.questions?.picture ?? ""),
                        ), // Buraya kendi asset yolunuzu ekleyin.
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      QuesPacketSelect(
                          isPacket: true,
                          desc: isType
                              ? "Öğrenci Açıklamalı Cevap İstiyor"
                              : " Öğrenci Videolu Cevap İstiyor",
                          image: isType
                              ? "assets/image/ansver.jpeg"
                              : "assets/image/gallery.jpeg",
                          title:
                              isType ? "Açıklamalı Cevap " : "Videolu Cevap"),
                      const SizedBox(
                        height: 32,
                      ),
                      CustomButton(
                        color: context.general.colorScheme.primary,
                        title: "Cevap Göndermeye Başla",
                        onPressed: () {
                          isType
                              ? _pickImageFromGallery(
                                  context,
                                  quesId,
                                  snapshot.data?.data?.questions?.studentId
                                      .toString(),
                                  lessonName)
                              : _pickVideoFromGallery(
                                  context,
                                  quesId,
                                  snapshot.data?.data?.questions?.studentId
                                      .toString(),
                                  lessonName);
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (BuildContext context) {
                          //     return StatefulBuilder(
                          //       builder: (context, setState) => Container(
                          //         decoration: BoxDecoration(
                          //             borderRadius: BorderRadius.circular(16)),
                          //         height: 480,
                          //         width: double.infinity,
                          //         child: Padding(
                          //           padding: const EdgeInsets.all(8.0),
                          //           child: Column(
                          //             crossAxisAlignment:
                          //                 CrossAxisAlignment.start,
                          //             children: [
                          //               const SizedBox(
                          //                 height: 8,
                          //               ),
                          //               Padding(
                          //                 padding: const EdgeInsets.all(8.0),
                          //                 child: Text(
                          //                   "Cevap Göndermeye Başla",
                          //                   style: context.textTheme.bodyLarge,
                          //                 ),
                          //               ),
                          //               GestureDetector(
                          //                 onTap: () {
                          //                   isType
                          //                       ? _pickImageFromGallery(context,
                          //                           quesId, "22", lessonName)
                          //                       : _pickVideoFromGallery(context,
                          //                           quesId, "22", lessonName);
                          //                 },
                          //                 child: const QuesPacketSelect(
                          //                   isPacket: true,
                          //                   desc:
                          //                       "Sorunun Cevabını Galeriden Seç",
                          //                   image: "assets/image/gallery.jpeg",
                          //                   title: "Galeriden Seç",
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 height: 16,
                          //               ),
                          //               GestureDetector(
                          //                 onTap: () {
                          //                   _captureImageWithCamera(context,
                          //                       quesId, "22", lessonName);
                          //                 },
                          //                 child: const QuesPacketSelect(
                          //                   isPacket: true,
                          //                   desc:
                          //                       "Sorunun Cevabını Kamera İle Yükle",
                          //                   image: "assets/image/video.jpeg",
                          //                   title: "Kamerayı Aç",
                          //                 ),
                          //               ),
                          //               const SizedBox(
                          //                 height: 16,
                          //               ),
                          //             ],
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // );
                        },
                      )
                    ],
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            }),
      ),
    );
  }

  void _showFullImage(BuildContext context, String image) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Scaffold(
        body: Center(
          child: PhotoView(
            imageProvider:
                NetworkImage(image), // Buraya kendi asset yolunuzu ekleyin.
          ),
        ),
      );
    }));
  }
}
