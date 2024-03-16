import 'dart:io';

import 'package:acik_soru/page/students/bottom_bar/bottom_bar_page.dart';
import 'package:acik_soru/service/send_notification.dart';
import 'package:acik_soru/service/students/add_question_service.dart';
import 'package:acik_soru/widget/custom_button.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:quickalert/quickalert.dart';

import '../../../widget/info_widget.dart';
import '../../widget/package_widget.dart';

class DisplayImage extends StatelessWidget {
  final File image;
  final String teacherName;
  final String teacherId;

  final String lessonName;
  final String teacherImage;
  final String teacherRating;

  const DisplayImage({
    super.key,
    required this.image,
    required this.teacherName,
    required this.lessonName,
    required this.teacherId,
    required this.teacherImage,
    required this.teacherRating,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soru Önizleme'),
      ),
      body: Column(
        children: [
          Center(
            child: Image.file(image),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InfoWidget(
              title: lessonName,
              isTeac: false,
              image: "assets/image/lesson.jpeg",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InfoWidget(
              rating: int.parse(teacherRating),
              imageNetwork: teacherImage,
              title: teacherName,
              isTeac: true,
              image: "assets/image/user2.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: CustomButton(
              color: context.general.colorScheme.primary,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (context, setState) => Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16)),
                        height: 480,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 8,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Sorunun cevabını nasıl istersin ?",
                                  style: context.textTheme.bodyLarge,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  questionAddService(
                                          teacherId: teacherId,
                                          imageFile: image.path,
                                          type: 'video')
                                      .then((value) {
                                    if (value.data?.status ?? false) {
                                      sendNotification(
                                          userId: teacherId,
                                          desc:
                                              "$lessonName Sorusu Cevap Bekliyor",
                                          title: "Yeni Soru Geldi");
                                      CherryToast.success(
                                              title: const Text(
                                                  "Soru Başarıyla Gönderildi"))
                                          .show(context);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const StudentMyBottomBar(
                                              index: 1,
                                            ),
                                          ),
                                          (route) => false);
                                    } else {
                                      QuickAlert.show(
                                          confirmBtnText: "Tamam",
                                          context: context,
                                          text: "Soru Gönderilemedi",
                                          title: value.message,
                                          type: QuickAlertType.error);
                                    }
                                  });
                                },
                                child: const PackageWidget(
                                  desc: "Sorunun videlu anlatımı",
                                  image: "assets/image/video.jpeg",
                                  title: "Video ile cevap iste",
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () {
                                  questionAddService(
                                          teacherId: teacherId,
                                          imageFile: image.path,
                                          type: 'picture')
                                      .then((value) {
                                    if (value.data?.status ?? false) {
                                      print(value);
                                      sendNotification(
                                          userId: teacherId,
                                          desc:
                                              "$lessonName Soru Cevap Bekliyor",
                                          title: "Yeni Soru Geldi");
                                      CherryToast.success(
                                              title: const Text(
                                                  "Soru Başarıyla Gönderildi"))
                                          .show(context);
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const StudentMyBottomBar(
                                              index: 1,
                                            ),
                                          ),
                                          (route) => false);
                                      // QuickAlert.show(
                                      //     onConfirmBtnTap: () =>
                                      //         Navigator.pushAndRemoveUntil(
                                      //             context,
                                      //             MaterialPageRoute(
                                      //               builder: (context) =>
                                      //                   MyBottomBar(
                                      //                       cameras: cameras),
                                      //             ),
                                      //             (route) => false),
                                      //     confirmBtnText: "Tamam",
                                      //     context: context,
                                      //     text: "Soru Gönderildi",
                                      //     title: value.message,
                                      //     type: QuickAlertType.success);
                                    } else {
                                      QuickAlert.show(
                                          confirmBtnText: "Tamam",
                                          context: context,
                                          text: "Soru Gönderilemedi",
                                          title: value.message,
                                          type: QuickAlertType.error);
                                    }
                                  });
                                },
                                child: const PackageWidget(
                                  desc: "Sorunun yazı ile anlatımı",
                                  image: "assets/image/ansver.jpeg",
                                  title: "Açıklamalı cevap iste",
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              title: "Soruyu Gönder",
            ),
          )
        ],
      ),
    );
  }
}
