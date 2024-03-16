import 'package:acik_soru/widget/custom_button.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:kartal/kartal.dart';
import 'package:video_player/video_player.dart';

import '../../../service/teacher/add_rating.dart';
import '../bottom_bar/bottom_bar_page.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.url, required this.quesId});
  final String url;
  final String quesId;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.url)
      ..initialize().then((_) {
        // Video başarıyla yüklendikten sonra oynatmayı başlat
        setState(() {
          _controller?.play();
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.black,
        // s    title: const Text('Soru Çözümü'),
        actions: [
          TextButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    int ratingTeacher = 4;

                    return StatefulBuilder(
                      builder: (context, setState) => SizedBox(
                        height: context.general.mediaSize.height * 0.3,
                        width: double.infinity,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                  child: RatingBar.builder(
                                initialRating: 3,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    const EdgeInsets.symmetric(horizontal: 4.0),
                                itemBuilder: (context, _) => const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  ratingTeacher = rating.toInt();
                                },
                              )),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 22.0, horizontal: 32),
                                child: CustomButton(
                                  color: context.general.colorScheme.primary,
                                  onPressed: () {
                                    ratingService(
                                            questionId: widget.quesId,
                                            rating: int.parse(
                                                ratingTeacher.toString()),
                                            teacherId: "27")
                                        //snapshot
                                        // .data
                                        // ?.data
                                        // ?.questions
                                        // ?.
                                        // .toString(),)
                                        .then((value) {
                                      if (value?.data?.status ?? false) {
                                        CherryToast.success(
                                                title: const Text(
                                                    "Başarıyla değerlendirilme gönderildi"))
                                            .show(context);
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const StudentMyBottomBar(),
                                            ),
                                            (route) => false);
                                      }
                                    });
                                  },
                                  title: "Değerlendirmeyi Gönder",
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
              child: const Text(
                "Öğretmeni Değerlendir",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ))
        ],
      ),
      body: Center(
        child: _controller!.value.isInitialized
            ? AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: Positioned.fill(child: VideoPlayer(_controller!)),
              )
            : const CircularProgressIndicator(), // Video yüklenene kadar dönme çemberi göster
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          setState(() {
            if (_controller!.value.isPlaying) {
              _controller?.pause();
            } else {
              _controller?.play();
            }
          });
        },
        child: Icon(
          _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.blue,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }
}
