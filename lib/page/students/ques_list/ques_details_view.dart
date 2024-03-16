// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:acik_soru/const/const.dart';
import 'package:acik_soru/model/student_model/single_ques_model.dart';
import 'package:acik_soru/page/students/bottom_bar/bottom_bar_page.dart';
import 'package:acik_soru/page/students/widget/info_widget.dart';
import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:cherry_toast/cherry_toast.dart';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kartal/kartal.dart';

import 'package:http/http.dart' as http;
import 'package:photo_view/photo_view.dart';

import '../../../model/teacher/single_ques.dart';
import '../../../service/teacher/add_rating.dart';
import '../../../widget/custom_button.dart';

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
  if (response.statusCode == 200) {
    return SingleQuestionModel.fromJson(jsonDecode(response.body));
    // Başarılı yanıt işleme
  }
  throw Exception("Kademe Bulunamadı");
}

class QuesDetailsView extends StatefulWidget {
  const QuesDetailsView({Key? key, required this.quesId, required this.title})
      : super(key: key);
  final String quesId;
  final String title;
  @override
  State<QuesDetailsView> createState() => _QuesDetailsViewState();
}

class _QuesDetailsViewState extends State<QuesDetailsView> {
  late VideoPlayerController _videoPlayerController,
      _videoPlayerController2,
      _videoPlayerController3;

  late CustomVideoPlayerController _customVideoPlayerController;

  final CustomVideoPlayerSettings _customVideoPlayerSettings =
      const CustomVideoPlayerSettings();

  @override
  void initState() {
    super.initState();

    _videoPlayerController = VideoPlayerController.network(
      longVideo,
    )..initialize().then((value) => setState(() {}));
    _videoPlayerController2 = VideoPlayerController.network(video240);
    _videoPlayerController3 = VideoPlayerController.network(video480);
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: _videoPlayerController,
      customVideoPlayerSettings: _customVideoPlayerSettings,
      additionalVideoSources: {
        "240p": _videoPlayerController2,
        "480p": _videoPlayerController3,
        "720p": _videoPlayerController,
      },
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  bool kIsWeb = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Soru Cevabım")),
      body: SafeArea(
        child: FutureBuilder<SingleQuestionModel?>(
            future: getQuestion(widget.quesId),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool isType = snapshot.data?.data?.questions?.type == "picture";

                return ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () => _showFullImage(
                                context,
                                snapshot.data?.data?.questions?.pictureAnswer
                                        .toString() ??
                                    "https://i.pinimg.com/originals/00/d9/49/00d949ab8dd9f210128dfa543c5ac810.jpg"),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.network(snapshot
                                      .data?.data?.questions?.pictureAnswer ??
                                  ""),
                            ), // Buraya kendi asset yolunuzu ekleyin.
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          InfoWidget(
                            title: isType ? "Yazı ile Cevap" : "Videolu cevap",
                            isTeac: false,
                            image: isType
                                ? "assets/image/text.jpeg"
                                : "assets/image/video.jpeg",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          InfoWidget(
                            title: snapshot.data?.data?.questions?.branchName
                                    .toString() ??
                                "",
                            isTeac: false,
                            image: "assets/image/math.jpeg",
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          InfoWidget(
                            rating: int.parse(snapshot
                                        .data?.data?.questions?.teacherReview ==
                                    null
                                ? "4"
                                : snapshot.data?.data?.questions?.teacherReview
                                        .toString() ??
                                    "4"),
                            title: snapshot.data?.data?.questions?.teacherName
                                    .toString() ??
                                "0",
                            isTeac: true,
                            image: "assets/image/user2.png",
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                              color: context.general.colorScheme.primary,
                              title: "Öğretmen Değerlendir",
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    int ratingTeacher = 4;

                                    return StatefulBuilder(
                                      builder: (context, setState) => SizedBox(
                                        height:
                                            context.general.mediaSize.height *
                                                0.3,
                                        width: double.infinity,
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Center(
                                                  child: RatingBar.builder(
                                                initialRating: 3,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  ratingTeacher =
                                                      rating.toInt();
                                                },
                                              )),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 22.0,
                                                        horizontal: 32),
                                                child: CustomButton(
                                                  color: context.general
                                                      .colorScheme.primary,
                                                  onPressed: () {
                                                    ratingService(
                                                            questionId:
                                                                widget.quesId,
                                                            rating: int.parse(
                                                                ratingTeacher
                                                                    .toString()),
                                                            teacherId: "27")
                                                        //snapshot
                                                        // .data
                                                        // ?.data
                                                        // ?.questions
                                                        // ?.
                                                        // .toString(),)
                                                        .then((value) {
                                                      if (value?.data?.status ??
                                                          false) {
                                                        CherryToast.success(
                                                                title: const Text(
                                                                    "Başarıyla değerlendirilme gönderildi"))
                                                            .show(context);
                                                        Navigator
                                                            .pushAndRemoveUntil(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const StudentMyBottomBar(),
                                                                ),
                                                                (route) =>
                                                                    false);
                                                      }
                                                    });
                                                  },
                                                  title:
                                                      "Değerlendirmeyi Gönder",
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
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

String videoUrlLandscape =
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
String videoUrlPortrait =
    'https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4';
String longVideo =
    "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4";

String video720 =
    "https://www.sample-videos.com/video123/mp4/720/big_buck_bunny_720p_10mb.mp4";

String video480 =
    "https://www.sample-videos.com/video123/mp4/480/big_buck_bunny_480p_10mb.mp4";

String video240 =
    "https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_10mb.mp4";
