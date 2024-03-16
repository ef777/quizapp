// ignore_for_file: depend_on_referenced_packages, prefer_is_empty

import 'dart:io';
import 'package:acik_soru/model/student_model/lesson_model.dart';
import 'package:acik_soru/service/students/get_lessons_service.dart';
import 'package:file_picker/file_picker.dart'
    as file_picker; // Rename the import using 'as'

import 'package:image/image.dart' as img;
import 'package:acik_soru/page/auth/register/student_register_page.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kartal/kartal.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../model/student_model/level_model.dart';
import '../../../../service/auth/teacher_register_service.dart';
import '../../../../service/students/get_level_service.dart';
import '../../login/login_page.dart';
// ignore_for_file: avoid_print

class TeacherRegisterPage2 extends StatefulWidget {
  const TeacherRegisterPage2(
      {Key? key,
      required this.name,
      required this.password,
      required this.tcNumber,
      required this.surname,
      required this.phone,
      required this.mail,
      required this.paswordAgain})
      : super(key: key);
  final String name;
  final String password;
  final String tcNumber;
  final String surname;
  final String phone;
  final String mail;
  final String paswordAgain;

  @override
  State<TeacherRegisterPage2> createState() => _TeacherRegisterPage2State();
}

class _TeacherRegisterPage2State extends State<TeacherRegisterPage2> {
  File? _image;
  bool isLoading = false;
  int? levelsId;
  TextEditingController ibanCont = TextEditingController();
  TextEditingController bankNameCont = TextEditingController();

  TextEditingController yearCont = TextEditingController();
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

  String? _pdfPath;

  void _openFileExplorer() async {
    file_picker.FilePickerResult? result =
        await file_picker.FilePicker.platform.pickFiles(
      // Use the alias to access FileType
      type: file_picker.FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfPath = result.files.single.path;
      });
    }
  }

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
          automaticallyImplyLeading: false,
          centerTitle: false,
          title: Text(
            'KAYIT DEVAM EDİYOR',
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
                                      controller: ibanCont,
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
                                          hintText: "Iban bilgisi"),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        context.general.mediaSize.height * 0.01,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextField(
                                      controller: bankNameCont,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                                "assets/icon/icon_bank.svg"),
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
                                          hintText: "Banka İsmi"),
                                    ),
                                  ),
                                  SizedBox(
                                    height:
                                        context.general.mediaSize.height * 0.01,
                                  ),
                                  SizedBox(
                                    height: 46,
                                    child: TextField(
                                      controller: yearCont,
                                      decoration: InputDecoration(
                                          suffixIcon: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: SvgPicture.asset(
                                                "assets/icon/icon_user2.svg"),
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
                                          hintText: "Deneyim Yılı"),
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
                                    height: context.general.mediaSize.height *
                                        0.005,
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: context
                                                  .border.lowBorderRadius)),
                                      onPressed: () {
                                        _openFileExplorer();
                                      },
                                      child: Text(
                                        "Cv Ekle",
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
                                    height: context.general.mediaSize.height *
                                        0.005,
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
                                                                            setState(
                                                                              () {
                                                                                levelsId = lessonModel?.id ?? 1;
                                                                              },
                                                                            );
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child: LevelWidget(
                                                                              isImage: lessonModel?.picture == null ? false : true,
                                                                              desc: '(${lessonModel?.name})',
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
                                        "Kademe Seç",
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
                                                              LessonsModel?>(
                                                            future:
                                                                getLessonsService(
                                                                    name: "",
                                                                    id: levelsId ??
                                                                        1),
                                                            builder: (context,
                                                                snapshot) {
                                                              if (snapshot
                                                                  .hasData) {
                                                                if (snapshot
                                                                            .data
                                                                            ?.data
                                                                            ?.length ==
                                                                        null &&
                                                                    snapshot
                                                                            .data
                                                                            ?.data
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
                                                                        ?.length,
                                                                    itemBuilder:
                                                                        (context,
                                                                            index) {
                                                                      var lessonModel = snapshot
                                                                          .data
                                                                          ?.data![index];
                                                                      return InkWell(
                                                                          onTap:
                                                                              () {
                                                                            print(lessonModel?.id ??
                                                                                "");
                                                                            registerTeacher(cv: _pdfPath, levelsId: levelsId.toString(), mail: widget.mail, name: widget.name, password: widget.password, paswordAgain: widget.paswordAgain, path: _image?.path, surname: widget.surname, phone: widget.phone, tcNumber: widget.tcNumber, bankName: bankNameCont.text, branchId: lessonModel?.id.toString() ?? "1", experienceYear: yearCont.text, iban: ibanCont.text).then((value) {
                                                                              if (value) {
                                                                                CherryToast.success(title: const Text("Hesabınız onay aşamasına alındı")).show(context);
                                                                                Navigator.pop(context);
                                                                              } else {
                                                                                CherryToast.error(title: const Text("Lütfen Bilgileri Eksiz Ve Doğru Doldurun")).show(context);
                                                                                Navigator.pop(context);
                                                                              }
                                                                            });
                                                                          },
                                                                          child: LevelWidget(
                                                                              isImage: false,
                                                                              desc: '(${lessonModel?.name})',
                                                                              image: "",
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
                                        "Bölüm Seç",
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
                                    height: context.general.mediaSize.height *
                                        0.005,
                                  ),
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
