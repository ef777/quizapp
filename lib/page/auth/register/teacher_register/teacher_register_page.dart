import 'package:acik_soru/page/auth/register/student_register_page.dart';
import 'package:acik_soru/page/auth/register/teacher_register/teacher_register_page2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';

class TeacherRegisterPage extends StatefulWidget {
  const TeacherRegisterPage({Key? key}) : super(key: key);

  @override
  State<TeacherRegisterPage> createState() => _TeacherRegisterPageState();
}

class _TeacherRegisterPageState extends State<TeacherRegisterPage> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    TextEditingController nameCont = TextEditingController();
    TextEditingController surnameCont = TextEditingController();
    TextEditingController emailCont = TextEditingController();
    TextEditingController passwordCont = TextEditingController();
    TextEditingController cPasswordCont = TextEditingController();
    TextEditingController tCNumberCont = TextEditingController();
    TextEditingController phoneCont = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
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
                          const begin = Offset(-1.0, 1.0);
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
                child: const Text("Öğrenci Kaydı"))
          ],
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            'KAYIT OL',
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
                  : SafeArea(
                      child: SingleChildScrollView(
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
                                    "Öğretmen Kayıt Formu",
                                    style: context.general.textTheme.labelLarge
                                        ?.copyWith(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    "Lorem ipsum doler sit amet 😏",
                                    style: context.general.textTheme.labelLarge
                                        ?.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: context.general.mediaSize.height *
                                        0.005,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextField(
                                      controller: nameCont,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                                "assets/icon/icon_profile.svg"),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 12, left: 12),
                                          focusedBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blue)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blueGrey)),
                                          fillColor: Colors.white,
                                          hintText: "İsminizi giriniz"),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        context.general.mediaSize.height * 0.01,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextField(
                                      controller: surnameCont,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                                "assets/icon/icon_profile.svg"),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 12, left: 12),
                                          focusedBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blue)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blueGrey)),
                                          fillColor: Colors.white,
                                          hintText: "Soyisminizi giriniz"),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        context.general.mediaSize.height * 0.01,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextField(
                                      controller: phoneCont,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                                "assets/icon/icon_phone.svg"),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 12, left: 12),
                                          focusedBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blue)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blueGrey)),
                                          fillColor: Colors.white,
                                          hintText: "Telefon numarası"),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        context.general.mediaSize.height * 0.01,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextField(
                                      controller: tCNumberCont,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                                "assets/icon/icon_user.svg"),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 12, left: 12),
                                          focusedBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blue)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blueGrey)),
                                          fillColor: Colors.white,
                                          hintText: "TC Kimlik Numarası"),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        context.general.mediaSize.height * 0.01,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextField(
                                      controller: emailCont,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                                "assets/icon/icon_mail.svg"),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 12, left: 12),
                                          focusedBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blue)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blueGrey)),
                                          fillColor: Colors.white,
                                          hintText: "Email adresinizi giriniz"),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        context.general.mediaSize.height * 0.01,
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
                                                "assets/icon/icon_password.svg"),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 12, left: 12),
                                          focusedBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blue)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blueGrey)),
                                          fillColor: Colors.white,
                                          hintText: "Parolanızı giriniz"),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        context.general.mediaSize.height * 0.01,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextField(
                                      obscureText: true,
                                      controller: cPasswordCont,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                                "assets/icon/icon_password.svg"),
                                          ),
                                          contentPadding: const EdgeInsets.only(
                                              top: 12, left: 12),
                                          focusedBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blue)),
                                          enabledBorder: UnderlineInputBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius,
                                              borderSide: const BorderSide(
                                                  width: 1,
                                                  color: Colors.blueGrey)),
                                          fillColor: Colors.white,
                                          hintText: "Parolanızı doğrulayın"),
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
                                        context.route.navigateToPage(
                                            TeacherRegisterPage2(
                                          mail: emailCont.text,
                                          name: nameCont.text,
                                          password: passwordCont.text,
                                          paswordAgain: cPasswordCont.text,
                                          phone: phoneCont.text,
                                          surname: surnameCont.text,
                                          tcNumber: tCNumberCont.text,
                                        ));
                                      },
                                      child: Text(
                                        "DEVAM ET",
                                        style: context
                                            .general.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontSize: 18,
                                                color: context.general
                                                    .colorScheme.onPrimary),
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
          ),
        ));
  }
}
