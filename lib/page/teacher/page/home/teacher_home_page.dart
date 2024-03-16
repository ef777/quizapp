// ignore_for_file: deprecated_member_use

import 'package:acik_soru/page/teacher/page/home/page/ques_details_view.dart';
import 'package:acik_soru/service/token_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../const/const.dart';
import '../../../../model/student_model/get_question_model.dart';
import '../../../../service/notifi_service.dart';
import '../../../../service/teacher/change_status_teacher_service.dart';
import '../notification/teacher_notification_page.dart';
import '../profile/teacher_profile_page.dart';

Future<GetQuestionModel?> getQuestion() async {
  const String url = 'https://aciksoru.com.tr/api/questionsTeacherGet';
  String? bearerToken = Config.bareerToken;

  Dio dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Authorization'] = 'Bearer $bearerToken';

  FormData formData = FormData.fromMap({
    "id": Config.userId,
  });

  try {
    var response = await dio.post(url, data: formData);
    if (response.statusCode == 200) {
      return GetQuestionModel.fromJson(response.data);
    } else {
      return GetQuestionModel.fromJson(response.data);
    }
  } catch (e) {
    print("Exception: $e");
    return null;
  }
}

class TeacherHomePage extends StatefulWidget {
  const TeacherHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<TeacherHomePage> createState() => _TeacherHomePageState();
}

class _TeacherHomePageState extends State<TeacherHomePage> {
  @override
  initState() {
    FirebaseNotificationService().connectNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FutureBuilder(
            future: SharedService().getActive(),
            builder: (context, snapshot) {
              String titleIcon = "";
              Color color = Colors.grey;
              if (snapshot.data == "1") {
                titleIcon = "SORU ALMAYI DURDUR";

                color = Colors.red;
              } else {
                titleIcon = "SORU ALMAYI BAŞLAT";
                color = const Color.fromARGB(255, 0, 189, 82);
              }
              return FloatingActionButton.extended(
                  backgroundColor: color,
                  onPressed: () {
                    changeStatus(teacherId: Config.userId.toString())
                        .then((value) {
                      if (value?.data?.active == "0") {
                        setState(() {
                          SharedService().saveActive("0");

                          color = const Color.fromARGB(255, 0, 189, 82);
                          titleIcon = "SORU ALMAYı DURDUR";
                        });
                      } else {
                        setState(() {
                          SharedService().saveActive("1");

                          color = Colors.red;
                          titleIcon = "SORU ALMAYı DURDUR";
                        });
                      }
                    });
                  },
                  label: Text(
                    titleIcon,
                    style: const TextStyle(color: Colors.white),
                  ));
            }),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  context.route.navigateToPage(const TeacherNotificationPage());
                },
                icon: SvgPicture.asset(
                  "assets/icon/icon_notifi.svg",
                  height: 36,
                )),
            IconButton(
                onPressed: () {
                  context.route.navigateToPage(const TeacherProfilePage());
                },
                icon: SvgPicture.asset(
                  "assets/icon/icon_profile.svg",
                  height: 38,
                ))
          ],
          title: const Text('Sorularım'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: getQuestion(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Questions>? questionModel =
                      snapshot.data?.data?.questions;

                  if (snapshot.data?.data?.status ?? false) {
                    return ListView.builder(
                        itemCount: questionModel?.length,
                        itemBuilder: (context, index) {
                          print("object");
                          // DateTime givenTime =
                          //     DateTime.parse(questionModel?[0].updatedAt ?? "");
                          // DateTime now = DateTime.now().toUtc();

                          // // İki zaman arasındaki farkı hesaplıyoruz
                          // Duration difference = now.difference(givenTime);
                          // String time;
                          // if (difference.inHours > 24) {
                          //   time = ("${difference.inDays.toString()} Gün Önce");
                          // } else if (difference.inHours > 0) {
                          //   time =
                          //       ("${difference.inHours}:${difference.inMinutes.remainder(60)} Saat Önce");
                          // } else {
                          //   time = ("${difference.inMinutes} Dakika Önce");
                          // }ü
                          bool isType = questionModel?[index].type == "picture";

                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () => context.route
                                  .navigateToPage(QuestionDetailPage(
                                quesId: questionModel?[index]
                                        .questionId
                                        .toString() ??
                                    "0",
                                lessonName:
                                    questionModel?[index].branchName ?? "",
                              )),
                              child: QuesListWidget(
                                desc: isType ? "Fotoğraf İle" : "Video İle",
                                title: questionModel?[index].branchName ?? "",
                                time: "0",
                                buttonTitle: "Cevap Bekleniyor",
                                color: questionModel?[index].isAnswer == "0"
                                    ? Colors.redAccent
                                    : Colors.greenAccent,
                              ),
                            ),
                          );
                        });
                  } else {
                    return const Center(child: Text("Soru Bulunmamakta"));
                  }
                } else {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
              }),
        ));
  }
}

class QuesListWidget extends StatelessWidget {
  const QuesListWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.time,
    required this.color,
    required this.buttonTitle,
    this.onPressed,
  });
  final String title;
  final String desc;
  final String time;
  final Color color;

  final String buttonTitle;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: context.normalBorderRadius,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.blueGrey.withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 7)
          ]),
      child: Row(
        children: [
          Image.asset(
            "assets/image/question.jpeg",
            height: 60,
          ),
          SizedBox(
            width: context.width * 0.03,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyLarge,
                ),
                Text(
                  desc,
                ),
                // Text(
                //   time,
                //   style: context.textTheme.bodySmall,
                // ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 10,
                  width: 10,
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(6)),
                child: Text(
                  color == Colors.redAccent ? "Bekleniyor" : "Cevaplandı",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
