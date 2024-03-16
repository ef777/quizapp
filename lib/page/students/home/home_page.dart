// ignore_for_file: deprecated_member_use

import 'package:acik_soru/page/students/home/widget/branch_widget.dart';
import 'package:acik_soru/page/students/home/widget/search_app_var.dart';
import 'package:acik_soru/page/students/home/page/lessons/lessons_page.dart';
import 'package:acik_soru/service/token_service.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../model/student_model/level_model.dart';
import '../../../service/students/get_level_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String examString = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchAppBar(
                onChanged: (value) {
                  setState(() {
                    examString = value;
                  });
                },
              ),
              SizedBox(
                height: context.height * 0.01,
              ),
              const Text("Sınav ve kademeler"),
              SizedBox(
                height: context.height * 0.01,
              ),
              Expanded(
                child: FutureBuilder<LevelModel?>(
                    future: getLevelService(name: examString),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Response>? levelModel =
                            snapshot.data?.data?.response;
                        return GridView.builder(
                            itemCount: levelModel?.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // İzgara sütun sayısı
                              mainAxisSpacing:
                                  7.0, // Ana eksen aralığı (dikey aralık)

                              crossAxisSpacing: 7.0, // Yatay eksen aralığı
                              childAspectRatio:
                                  1 / 1.01, // Öğelerin en boy oranı
                            ),
                            itemBuilder: (context, index) {
                              var result = parseTitle(
                                  snapshot.data?.data?.response?[index].name ??
                                      "");
                              print(snapshot.data?.data?.response?[index]);
                              return BranchWidget(
                                title2: levelModel?[index].name ?? "",
                                onTap: () => context.navigateToPage(LessonsPage(
                                  id: levelModel?[index].id ?? 0,

                                  //exammodel: examModelList[index],
                                )),
                                image: levelModel?[index].picture == null
                                    ? Image.asset(
                                        "assets/image/math.jpeg",
                                      )
                                    : Image.network(
                                        levelModel?[index].picture ?? ""),
                                title: result["title"] ?? "Veri Bulunamadı",
                                desc: result["desc"] ?? "Veri yok",
                              );
                            });
                      } else {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      }
                    }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
