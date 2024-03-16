import 'package:acik_soru/service/auth/login_service.dart';
import 'package:acik_soru/service/token_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:cherry_toast/cherry_toast.dart';

import '../../students/bottom_bar/bottom_bar_page.dart';
import '../../teacher/page/home/teacher_home_page.dart';
import '../register/student_register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController emailCont = TextEditingController();
    TextEditingController passwordCont = TextEditingController();

    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 500),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return const StudentRegisterPage();
                  },
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
                ),
                (route) => false);
          },
          label: const Text(
            "Kayıt Ol",
            style: TextStyle(color: Colors.white),
          ),
        ),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            'GİRİŞ YAP',
            style: context.general.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.general.colorScheme.onPrimary),
          ),
        ),
        body: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: context.general.colorScheme.background,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 22, top: 22, right: 16),
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        backgroundColor: context.general.colorScheme.onPrimary,
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              "assets/image/logo1.jpeg",
                              height: 180,
                            ),
                          ),
                          SizedBox(
                            height: context.general.mediaSize.height * 0.02,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: context.border.lowBorderRadius,
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      color: Colors.blueGrey.withOpacity(.1))
                                ]),
                            child: Column(
                              children: [
                                Text(
                                  "Giriş Yaparak Sorularını Çözdürmeyi Bıraktığın Yerden Devam Et 😎 ",
                                  style: context.general.textTheme.labelLarge
                                      ?.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      context.general.mediaSize.height * 0.02,
                                ),
                                SizedBox(
                                  height: 46,
                                  child: TextField(
                                    controller: emailCont,
                                    decoration: InputDecoration(
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            "assets/icon/icon_mail.svg",
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            top: 12, left: 12),
                                        focusedBorder: UnderlineInputBorder(
                                            borderRadius:
                                                context.border.lowBorderRadius,
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.blue)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderRadius:
                                                context.border.lowBorderRadius,
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Colors.blueGrey)),
                                        fillColor: Colors.white,
                                        hintText: "E-mail"),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      context.general.mediaSize.height * 0.015,
                                ),
                                SizedBox(
                                  height: 46,
                                  child: TextField(
                                    obscureText: true,
                                    controller: passwordCont,
                                    decoration: InputDecoration(
                                        suffixIcon: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: SvgPicture.asset(
                                            "assets/icon/icon_password.svg",
                                          ),
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            top: 12, left: 12),
                                        focusedBorder: UnderlineInputBorder(
                                            borderRadius:
                                                context.border.lowBorderRadius,
                                            borderSide: const BorderSide(
                                                width: 1, color: Colors.blue)),
                                        enabledBorder: UnderlineInputBorder(
                                            borderRadius:
                                                context.border.lowBorderRadius,
                                            borderSide: const BorderSide(
                                                width: 1,
                                                color: Colors.blueGrey)),
                                        fillColor: Colors.white,
                                        hintText: "Parola"),
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      context.general.mediaSize.height * 0.02,
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: context
                                                .border.lowBorderRadius)),
                                    onPressed: () {
                                      setState(() {
                                        isLoading = true;
                                      });

                                      loginService(
                                              email: emailCont.text,
                                              password: passwordCont.text)
                                          .then((value) {
                                        if (value?.success ?? false) {
                                          SharedService().saveloginKey("1");
                                          SharedService()
                                              .saveRole(value?.data?.role);

                                          if (value?.data?.role ==
                                              "\u00d6\u011frenci") {
                                            CherryToast.success(
                                                    title: const Text(
                                                        "Giriş Yapıldı"))
                                                .show(context);
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 500),
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return const StudentMyBottomBar();
                                                  },
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    const begin =
                                                        Offset(0.0, 0.0);
                                                    const end = Offset.zero;
                                                    const curve =
                                                        Curves.easeInOut;
                                                    var tween = Tween(
                                                            begin: begin,
                                                            end: end)
                                                        .chain(CurveTween(
                                                            curve: curve));
                                                    var offsetAnimation =
                                                        animation.drive(tween);
                                                    return SlideTransition(
                                                      position: offsetAnimation,
                                                      child: child,
                                                    );
                                                  },
                                                ),
                                                (route) => false);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          } else {
                                            CherryToast.success(
                                                    title: const Text(
                                                        "Giriş Yapıldı"))
                                                .show(context);
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 500),
                                                  pageBuilder: (context,
                                                      animation,
                                                      secondaryAnimation) {
                                                    return const TeacherHomePage();
                                                  },
                                                  transitionsBuilder: (context,
                                                      animation,
                                                      secondaryAnimation,
                                                      child) {
                                                    const begin =
                                                        Offset(0.0, 0.0);
                                                    const end = Offset.zero;
                                                    const curve =
                                                        Curves.easeInOut;
                                                    var tween = Tween(
                                                            begin: begin,
                                                            end: end)
                                                        .chain(CurveTween(
                                                            curve: curve));
                                                    var offsetAnimation =
                                                        animation.drive(tween);
                                                    return SlideTransition(
                                                      position: offsetAnimation,
                                                      child: child,
                                                    );
                                                  },
                                                ),
                                                (route) => false);
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }
                                        } else {
                                          CherryToast.info(
                                                  title: Text(value?.message ??
                                                      "Lütfen Bilgilerinizi Kontrol Ediniz"))
                                              .show(context);
                                          setState(() {
                                            isLoading = false;
                                          });
                                        }
                                      });
                                      // loginService(
                                      //         mail: emailCont.text,
                                      //         password: passwordCont.text)
                                      //     .then((value) async {
                                      //   if (value.success ?? false) {
                                      //     Config.isLogin = await true;

                                      //     Navigator.pushAndRemoveUntil(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //           builder: (context) => LearnPage(),
                                      //         ),
                                      //         (route) => false);
                                      //     setState(() {
                                      //       isLoading = false;
                                      //     });
                                      //   } else {
                                      //     QuickAlert.show(
                                      //         onConfirmBtnTap: () {
                                      //           setState(() {
                                      //             isLoading = false;
                                      //           });
                                      //           Navigator.pop(context);
                                      //         },
                                      //         context: context,
                                      //         type: QuickAlertType.error,
                                      //         title: "Giriş Yapılamadı",
                                      //         text: value.message,
                                      //         confirmBtnText: "Tamam");
                                      //   }
                                      // });
                                    },
                                    child: Text(
                                      "GİRİŞ YAP",
                                      style: context
                                          .general.textTheme.bodyMedium
                                          ?.copyWith(
                                              fontSize: 18,
                                              color: context.general.colorScheme
                                                  .onPrimary),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
            ),
          ),
        ));
  }
}
