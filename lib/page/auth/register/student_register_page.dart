// ignore_for_file: prefer_is_empty

import 'dart:io';
import 'package:acik_soru/model/student_model/level_model.dart';
import 'package:acik_soru/service/students/get_level_service.dart';
import 'package:image/image.dart' as img;

import 'package:acik_soru/page/auth/register/teacher_register/teacher_register_page.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:path_provider/path_provider.dart';

import '../../../service/auth/register_service.dart';
import '../login/login_page.dart';

class StudentRegisterPage extends StatefulWidget {
  const StudentRegisterPage({Key? key}) : super(key: key);

  @override
  State<StudentRegisterPage> createState() => _StudentRegisterPageState();
}

class _StudentRegisterPageState extends State<StudentRegisterPage> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File tempFile = File(pickedFile.path);

      img.Image? image = img.decodeImage(tempFile.readAsBytesSync());
      img.Image resizedImg = img.copyResize(image!, width: 500);

      final tempDir = await getTemporaryDirectory();
      var newPath = '${tempDir.path}/resized_image.jpg';

      File newFile = File(newPath)..writeAsBytesSync(img.encodeJpg(resizedImg));

      setState(() {
        _image = newFile;
      });
    }
  }

  bool isLoading = false;
  TextEditingController nameCont = TextEditingController();
  TextEditingController surnameCont = TextEditingController();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passwordCont = TextEditingController();
  TextEditingController cPasswordCont = TextEditingController();
  TextEditingController tCNumberCont = TextEditingController();
  TextEditingController phoneCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) {
                  return const LoginPage();
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
            );
          },
          label: const Text(
            "Giriş Yap",
            style: TextStyle(color: Colors.white),
          ),
        ),
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 500),
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return const TeacherRegisterPage();
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
                child: const Text("Öğretmen Kaydı"))
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Öğrenci Kayıt Formu",
                                    style: context.general.textTheme.labelLarge
                                        ?.copyWith(
                                      color: Colors.black54,
                                    ),
                                  ),
                                  Text(
                                    "Kayıt Olarak Sorularının Çözümlerine Ulaşabilirsin 😏",
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
                                          hintText: "İsim"),
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
                                          hintText: "Soyisim"),
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
                                          hintText: "Telefon"),
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
                                          hintText: "TC"),
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
                                          hintText: "Mail"),
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
                                          hintText: "Parola"),
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
                                          hintText: "Parola Yeniden"),
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
                                        _pickImage();
                                      },
                                      child: Text(
                                        "Profil Resmi Seç",
                                        style: context
                                            .general.textTheme.bodyMedium
                                            ?.copyWith(
                                                fontSize: 18,
                                                color: context.general
                                                    .colorScheme.onPrimary),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        context.general.mediaSize.height * 0.01,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius)),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return StatefulBuilder(
                                                builder:
                                                    (context, setState) =>
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical:
                                                                      12.0,
                                                                  horizontal:
                                                                      12),
                                                          child: FutureBuilder<
                                                              LevelModel?>(
                                                            future:
                                                                getLevelService(
                                                                    name: ""),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                if (snapshot
                                                                            .data
                                                                            ?.data
                                                                            ?.response
                                                                            ?.length ==
                                                                        null &&
                                                                    snapshot
                                                                            .data
                                                                            ?.data
                                                                            ?.response
                                                                            ?.length ==
                                                                        0) {
                                                                  return const Text(
                                                                      "Veri Kaydı Yok");
                                                                } else {
                                                                  return ListView
                                                                      .builder(
                                                                    itemCount: snapshot
                                                                        .data
                                                                        ?.data
                                                                        ?.response
                                                                        ?.length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      var lessonModel = snapshot
                                                                          .data
                                                                          ?.data!
                                                                          .response?[index];
                                                                      return GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            registerStudentService(levelsId: snapshot.data?.data?.response?[index].id.toString() ?? "1", mail: emailCont.text, name: nameCont.text, password: passwordCont.text, paswordAgain: cPasswordCont.text, path: _image?.path, surname: surnameCont.text, phone: phoneCont.text, tcNumber: tCNumberCont.text).then((value) {
                                                                              if (value) {
                                                                                CherryToast.success(title: const Text("Giriş Yapabilirsiniz")).show(context);
                                                                                Navigator.pop(context);
                                                                              } else {
                                                                                CherryToast.error(title: const Text("Lütfen Bilgileri Eksiz Ve Doğru Doldurun")).show(context);
                                                                                Navigator.pop(context);
                                                                              }
                                                                            });
                                                                          },
                                                                          child: LevelWidget(
                                                                              isImage: lessonModel?.picture == null ? false : true,
                                                                              desc: '${lessonModel?.name} Öğrencisiyim',
                                                                              image: lessonModel?.picture ?? "",
                                                                              title: lessonModel?.name ?? ""));
                                                                    },
                                                                  );
                                                                }
                                                              } else {
                                                                return const Center(
                                                                  child: CircularProgressIndicator
                                                                      .adaptive(),
                                                                );
                                                              }
                                                            },
                                                          ),
                                                        ));
                                          },
                                        );
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

class LevelWidget extends StatelessWidget {
  const LevelWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.image,
    required this.isImage,
  });
  final String title;
  final String desc;
  final String image;
  final bool isImage;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                borderRadius: context.border.normalBorderRadius,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.blueGrey.withOpacity(.1),
                      blurRadius: 20,
                      spreadRadius: 7)
                ]),
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(35),
                    child: isImage
                        ? Image.asset(
                            "assets/image/math.jpeg",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/image/math.jpeg",
                            height: 70,
                            width: 70,
                            fit: BoxFit.cover,
                          )
                    // Image.network(
                    //     image,
                    //     height: 70,
                    //     width: 70,
                    //     fit: BoxFit.cover,
                    //   ),
                    ),
                SizedBox(
                  width: context.general.mediaSize.width * 0.03,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: context.textTheme.bodyMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      Text(desc)
                    ],
                  ),
                ),
                const Icon(Icons.arrow_forward_ios),
                SizedBox(
                  width: context.general.mediaSize.width * 0.03,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
