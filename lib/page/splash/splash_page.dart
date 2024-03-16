// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:acik_soru/const/const.dart';
import 'package:acik_soru/page/auth/login/login_page.dart';
import 'package:acik_soru/page/students/bottom_bar/bottom_bar_page.dart';
import 'package:acik_soru/page/teacher/page/home/teacher_home_page.dart';
import 'package:acik_soru/service/token_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    //SharedService().saveloginKey("0");

    super.initState();
    _loginKey();
  }

  void _loginKey() {
    Future.delayed(const Duration(seconds: 2), () async {
      await getUserInfo();
      _loginControll();
    });
  }

  Future<void> getUserInfo() async {
    Config.bareerToken = await SharedService().getBareerToken();
    Config.userId = int.parse(await SharedService().getUserId() ?? "0");
    Config.login = await SharedService().getloginKey();
    final prefs = await SharedPreferences.getInstance();

    Config.role = prefs.getString("rolemm");
  }

  Future<dynamic> _loginControll() {
    if (Config.login == "0") {
      return Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginPage(),
          ),
          (route) => false);
    } else {
      if (Config.role == "Öğrenci") {
        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentMyBottomBar(),
            ),
            (route) => false);
      } else {
        return Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const TeacherHomePage(),
            ),
            (route) => false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      body: Center(
        child: Image.asset("assets/image/logo1.jpeg"),
      ),
    );
  }
}
