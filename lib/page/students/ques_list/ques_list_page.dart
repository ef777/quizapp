// ignore_for_file: deprecated_member_use
import 'dart:convert';

import 'package:acik_soru/page/students/ques_list/ques_details_view.dart';
import 'package:acik_soru/page/students/ques_list/widget/ques_list_widget.dart';
import 'package:acik_soru/page/students/ques_list/video_details_view.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../const/const.dart';
import '../../../model/student_model/get_question_model.dart';

Future<GetQuestionModel> getQuestionStudent() async {
  final url = Uri.parse('https://aciksoru.com.tr/api/questionsGet');
  final String? bearerToken = Config.bareerToken;

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $bearerToken',
    },
    body: jsonEncode({'student_id': Config.userId}),
  );
  if (response.statusCode == 200) {
    return GetQuestionModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  throw Exception("Kademe Bulunamadı");
}

class QuesListPage extends StatelessWidget {
  const QuesListPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sorularım'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
              future: getQuestionStudent(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Questions>? questionModel =
                      snapshot.data?.data?.questions;
                  if (questionModel?.length == null) {
                    return const Text("Soru Yok");
                  } else {
                    return ListView.builder(
                        itemCount: questionModel?.length,
                        itemBuilder: (context, index) {
                          // DateTime givenTime = DateTime.parse(
                          //     questionModel?[index].updatedAt ?? "");
                          // DateTime now = DateTime.now().toUtc();

                          // // İki zaman arasındaki farkı hesaplıyoruz

                          // Duration difference = now.difference(givenTime);
                          // String time;
                          // if (difference.inHours > 24) {
                          //   time = ("${difference.inDays} Gün Önce");
                          // } else if (difference.inHours > 0) {
                          //   time =
                          //       ("${difference.inHours}:${difference.inMinutes.remainder(60)} Saat Önce");
                          // } else {
                          //   time = ("${difference.inMinutes} Dakika Önce");
                          // }
                          bool isType = questionModel?[index].type == "picture";

                          return Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: GestureDetector(
                              onTap: () {
                                if (questionModel?[index].isAnswer == "1") {
                                  if (isType) {
                                    context.route
                                        .navigateToPage(QuesDetailsView(
                                      quesId: questionModel?[index]
                                              .questionId
                                              .toString() ??
                                          "0",
                                      title: questionModel?[index].branchName ??
                                          "Veri Bulunamadı",
                                    ));
                                  } else {
                                    context.route
                                        .navigateToPage(VideoPlayerScreen(
                                      url:
                                          questionModel?[index].pictureAnswer ??
                                              "",
                                      quesId: questionModel?[index]
                                              .questionId
                                              .toString() ??
                                          "0",
                                    ));
                                  }
                                }
                              },
                              child: QuesListWidget(
                                desc:
                                    isType ? "Yazılı Cevap" : "Video İle Cevap",
                                title: questionModel?[index].branchName ??
                                    "Veri Bulunamadı",
                                time: "0",
                                buttonTitle: "Cevap Bekleniyor",
                                color: questionModel?[index].isAnswer == "0"
                                    ? Colors.redAccent
                                    : const Color.fromARGB(255, 0, 209, 108),
                              ),
                            ),
                          );
                        });
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
