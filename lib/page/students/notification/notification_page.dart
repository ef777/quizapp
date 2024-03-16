// ignore_for_file: deprecated_member_use, prefer_is_empty

import 'package:acik_soru/const/const.dart';
import 'package:acik_soru/model/notifi_model.dart';
import 'package:acik_soru/service/get_notifi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);
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
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<NotifiModel?>(
              future: getNotifi(id: Config.userId.toString()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data?.data?.response?.length == null &&
                      snapshot.data?.data?.response?.length == 0) {
                    return const Center(
                      child: Text("Bildirim Yok"),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data?.data?.response?.length,
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                              color: context.general.colorScheme.background,
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(32),
                                  topRight: Radius.circular(32))),
                          child: Column(
                            children: [
                              Padding(
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
                                              snapshot
                                                      .data
                                                      ?.data
                                                      ?.response?[index]
                                                      .title ??
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
                              ),
                            ],
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
              }),
        ));
  }
}
