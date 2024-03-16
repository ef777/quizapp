// ignore_for_file: deprecated_member_use, unrelated_type_equality_checks

import 'package:acik_soru/model/notifi_model.dart';
import 'package:acik_soru/service/get_notifi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';

import '../../../../const/const.dart';

class TeacherNotificationPage extends StatelessWidget {
  const TeacherNotificationPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            'BİLDİRİMLER',
            style: context.general.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
                color: context.general.colorScheme.onPrimary),
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
              color: context.general.colorScheme.background,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32), topRight: Radius.circular(32))),
          child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: FutureBuilder<NotifiModel?>(
                  future: getNotifi(id: "27"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data?.data?.response?.length == null &&
                          snapshot.data?.data?.response?.length == "0") {
                        return const Text("Bildirim Yok");
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data?.data?.response?.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: context.normalBorderRadius,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Colors.blueGrey.withOpacity(.1),
                                          blurRadius: 20,
                                          spreadRadius: 7)
                                    ]),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.blueAccent),
                                          child: SvgPicture.asset(
                                            "assets/icon/icon_notifi.svg",
                                            color: Colors.white,
                                          )),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            snapshot.data?.data
                                                    ?.response?[index].title ??
                                                "",
                                            style: context.textTheme.bodyLarge
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                          Text(
                                            snapshot
                                                    .data
                                                    ?.data
                                                    ?.response?[index]
                                                    .description ??
                                                "",
                                            style: context.textTheme.bodyLarge
                                                ?.copyWith(
                                                    fontWeight:
                                                        FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Color.fromARGB(
                                                52, 225, 225, 225)),
                                        child: const Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    } else {
                      return const Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                  })),
        ));
  }
}
