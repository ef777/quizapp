// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../../../model/student_model/lesson_model.dart';
import '../../teacher_list/teacher_list_page.dart';

class LessonWidget extends StatelessWidget {
  const LessonWidget({
    super.key,
    required this.lessonsModel,
  });
  final Data? lessonsModel;
  // final String desc;
  // final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      height: 80,
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
          SizedBox(
            width: context.width * 0.01,
          ),
          SizedBox(
            width: 110,
            child: Text(
              lessonsModel?.name ?? "",
            ),
          ),
          const Spacer(),
          Align(
            alignment: Alignment.bottomRight,
            child: ElevatedButton(
                onPressed: () => context.navigateToPage((TeacherListView(
                      lessonName: lessonsModel?.name ?? "",
                      lessonID: lessonsModel?.id ?? 0,
                    ))),
                child: const Text("Dersi Seç")),
          )
        ],
      ),
    );
  }
}
