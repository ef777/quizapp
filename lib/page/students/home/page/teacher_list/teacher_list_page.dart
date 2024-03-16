// ignore_for_file: deprecated_member_use, depend_on_referenced_packages, prefer_is_empty, prefer_if_null_operators

import 'dart:io';

import 'package:acik_soru/model/student_model/active_teacher_model.dart';
import 'package:acik_soru/service/students/get_active_teacher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../../../widget/info_widget.dart';
import '../display/display_page.dart';

class TeacherListView extends StatefulWidget {
  final int lessonID;
  final String lessonName;

  const TeacherListView(
      {Key? key, required this.lessonID, required this.lessonName})
      : super(key: key);

  @override
  State<TeacherListView> createState() => _TeacherListViewState();
}

class _TeacherListViewState extends State<TeacherListView> {
  Future getImage(
      String teacherName, teacherId, teacherImage, teacherRating) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DisplayImage(
                teacherId: teacherId,
                image: _image!,
                lessonName: widget.lessonName.toString(),
                teacherName: teacherName,
                teacherImage: teacherImage,
                teacherRating: teacherRating),
          ),
        );
      } else {
        print('No image selected.');
      }
    });
  }

  File? _image;

  Future<void> _pickImage(
      {required String teacherName,
      required String teacherId,
      required String teacherImage,
      required String teacherRating}) async {
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
        // ignore: unnecessary_null_comparison
        if (pickedFile != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DisplayImage(
                  teacherId: teacherId,
                  image: _image!,
                  lessonName: widget.lessonName.toString(),
                  teacherName: teacherName,
                  teacherImage: teacherImage,
                  teacherRating: teacherRating),
            ),
          );
        } else {
          print('No image selected.');
        }
      });
    }
  }

  var searchText;
  TextEditingController searchCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Öğretmen Listesi")),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset("assets/icon/icon_search.svg"),
                  Flexible(
                      child: TextField(
                    onChanged: (deger) {},
                    decoration: const InputDecoration(
                        hintText: "Öğretmen ara ...",
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder:
                            OutlineInputBorder(borderSide: BorderSide.none),
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                  ))
                ],
              ),
              FutureBuilder<ActiveTeacherModel?>(
                future: getActiveTeacher(id: widget.lessonID),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data?.data == null &&
                        snapshot.data?.data?.length == 0) {
                      return const Text("Öğretmen Bulunamadı");
                    } else {
                      return Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data?.data?.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                _pickImage(
                                  teacherId: snapshot.data?.data?[index].id
                                          .toString() ??
                                      "",
                                  teacherImage: snapshot
                                          .data?.data?[index].picture
                                          .toString() ??
                                      "",
                                  teacherName: snapshot.data?.data?[index].name
                                          .toString() ??
                                      "",
                                  teacherRating: snapshot
                                          .data?.data?[index].rating
                                          .toString() ??
                                      "",
                                );

                                // showModalBottomSheet(
                                //   context: context,
                                //   builder: (BuildContext context) {
                                //     return StatefulBuilder(
                                //       builder: (context, setState) => Container(
                                //         decoration: BoxDecoration(
                                //             borderRadius:
                                //                 BorderRadius.circular(16)),
                                //         height: 480,
                                //         width: double.infinity,
                                //         child: Padding(
                                //           padding: const EdgeInsets.all(8.0),
                                //           child: Column(
                                //             crossAxisAlignment:
                                //                 CrossAxisAlignment.start,
                                //             children: [
                                //               const SizedBox(
                                //                 height: 8,
                                //               ),
                                //               Padding(
                                //                 padding:
                                //                     const EdgeInsets.all(8.0),
                                //                 child: Text(
                                //                   "Soruyu Yükle",
                                //                   style: context
                                //                       .textTheme.bodyLarge,
                                //                 ),
                                //               ),
                                //               GestureDetector(
                                //                 onTap: () {
                                //                   getImage(
                                //                       snapshot
                                //                               .data
                                //                               ?.data?[index]
                                //                               .name ??
                                //                           "",
                                //                       snapshot.data
                                //                               ?.data?[index].id
                                //                               .toString() ??
                                //                           "",
                                //                       snapshot
                                //                               .data
                                //                               ?.data?[index]
                                //                               .picture
                                //                               .toString() ??
                                //                           "",
                                //                       snapshot
                                //                                   .data
                                //                                   ?.data?[index]
                                //                                   .rating ==
                                //                               null
                                //                           ? "4"
                                //                           : snapshot
                                //                               .data
                                //                               ?.data?[index]
                                //                               .rating
                                //                               .toString());
                                //                 },
                                //                 child: const PackageWidget(
                                //                   isPacket: true,
                                //                   desc: "Soruyu Kameradan Ekle",
                                //                   image:
                                //                       "assets/image/video.jpeg",
                                //                   title: "Kamerayı Aç",
                                //                 ),
                                //               ),
                                //               const SizedBox(
                                //                 height: 8,
                                //               ),
                                //               GestureDetector(
                                //                 onTap: () {
                                //                   _pickImage(
                                //                       snapshot
                                //                               .data
                                //                               ?.data?[index]
                                //                               .name ??
                                //                           "",
                                //                       snapshot.data
                                //                               ?.data?[index].id
                                //                               .toString() ??
                                //                           "",
                                //                       snapshot
                                //                               .data
                                //                               ?.data?[index]
                                //                               .picture
                                //                               .toString() ??
                                //                           "",
                                //                       snapshot
                                //                                   .data
                                //                                   ?.data?[index]
                                //                                   .rating ==
                                //                               null
                                //                           ? "4"
                                //                           : snapshot
                                //                               .data
                                //                               ?.data?[index]
                                //                               .rating
                                //                               .toString());

                                //                 },
                                //                 child: const PackageWidget(
                                //                   isPacket: true,
                                //                   desc: "Soruyu Galeriden Ekle",
                                //                   image:
                                //                       "assets/image/gallery.jpeg",
                                //                   title: "Galeriyi Aç",
                                //                 ),
                                //               ),
                                //             ],
                                //           ),
                                //         ),
                                //       ),
                                //     );
                                //   },
                                // );
                              },
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: InfoWidget(
                                  imageNetwork:
                                      snapshot.data?.data?[index].picture ?? "",
                                  rating: int.parse(
                                      snapshot.data?.data?[index].rating == null
                                          ? "4"
                                          : snapshot.data?.data?[index].rating
                                                  .toString() ??
                                              "4"),
                                  title: snapshot.data?.data?[index].name ?? "",
                                  isTeac: true,
                                  image: "assets/image/user2.png",
                                ),
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
                },
              ),
            ],
          ),
        ));
  }
}
