import 'package:acik_soru/page/students/profile/page/about_us_view.dart';
import 'package:acik_soru/widget/profil_widget.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../service/get_polititicy_service.dart';

class PoliticiyPage extends StatelessWidget {
  const PoliticiyPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Politikalar'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<dynamic>?>(
            future: getPoliticiy(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data?.length != null &&
                    snapshot.data!.isNotEmpty) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: GestureDetector(
                                onTap: () => context.route
                                    .navigateToPage(DescripitonPage(
                                  text: snapshot.data?[index]["content"] ?? "",
                                  title: snapshot.data?[index]["name"] ?? "",
                                )),
                                child: ProfilWidget(
                                    icon: Icons.policy,
                                    title: snapshot.data?[index]["name"] ?? "",
                                    color: Colors.black),
                              ),
                            );
                          },
                        ),
                        Image.asset("assets/image/logo_band_colored@3x.png")
                      ],
                    ),
                  );
                } else {
                  return const Text("Veri Bulunamadı");
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
        ));
  }
}
