// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:acik_soru/page/students/home/page/lessons/widgets/lesson_widget.dart';
import 'package:acik_soru/page/students/home/page/lessons/widgets/search_lesson_bar.dart';

import '../../../../../model/student_model/lesson_model.dart';
import '../../../../../service/students/get_lessons_service.dart';

class LessonsPage extends StatefulWidget {
  final int id;
  const LessonsPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<LessonsPage> createState() => _LessonsPageState();
}

class _LessonsPageState extends State<LessonsPage> {
  String lessonName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchLessonAppBar(),
            const SizedBox(
              height: 12,
            ),
            const Text("Dersler"),
            const SizedBox(
              height: 12,
            ),
            FutureBuilder<LessonsModel?>(
                future: getLessonsService(id: widget.id, name: lessonName),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data?.data?.isEmpty ?? true) {
                      return const Center(child: Text("Veri Bulunamadı"));
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data?.data?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 3),
                              child: LessonWidget(
                                lessonsModel: snapshot.data?.data?[index],
                              ),
                            );
                          },
                        ),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  }
                })
          ],
        ),
      ),
    ));
  }
}

Map<String?, String?> parseTitle(String text) {
  int startIndex = text.indexOf("(");
  int endIndex = text.indexOf(")");

  if (startIndex != -1 && endIndex != -1) {
    String kpss = text.substring(0, startIndex).trim();
    String sinav = text.substring(startIndex + 1, endIndex).trim();

    return {'title': kpss, 'desc': sinav};
  } else {
    return {'title': "", 'desc': ""};
  }
}
