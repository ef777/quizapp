import 'package:acik_soru/page/students/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import '../../../service/notifi_service.dart';
import '../notification/notification_page.dart';
import '../profile/profile_view.dart';
import '../ques_list/ques_list_page.dart';

class StudentMyBottomBar extends StatefulWidget {
  const StudentMyBottomBar({
    Key? key,
    this.index,
  }) : super(key: key);
  final int? index;
  @override
  State<StudentMyBottomBar> createState() => _StudentMyBottomBarState();
}

class _StudentMyBottomBarState extends State<StudentMyBottomBar> {
  late int _currentIndex;

  @override
  void initState() {
    FirebaseNotificationService().connectNotification();

    _currentIndex = widget.index ?? 0;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List screnens = [
      const HomePage(),
      // ListQuesView(
      // ),
      // const Text("Bildirim Ekranı"),
      // ProfileView(
      // )
      const QuesListPage(),

      const NotificationPage(),
      const ProfilPage()
    ];

    return Scaffold(
      body: screnens[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Anasayfa"),
            selectedColor: const Color.fromRGBO(77, 138, 240, 28),
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: const Icon(Icons.question_mark),
            title: const Text("Sorularım"),
            selectedColor: const Color.fromRGBO(77, 138, 240, 28),
          ),

          /// Search
          SalomonBottomBarItem(
            icon: const Icon(Icons.notifications_none_outlined),
            title: const Text("Bildirimler"),
            selectedColor: const Color.fromRGBO(77, 138, 240, 28),
          ),

          /// Profile
          SalomonBottomBarItem(
            // ignore: prefer_const_constructors
            icon: Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: const Color.fromRGBO(77, 138, 240, 28),
          ),
        ],
      ),
    );
  }
}
