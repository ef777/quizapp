// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:acik_soru/model/auth/user_model.dart';
import 'package:acik_soru/model/teacher/teacher_eraning_model.dart';
import 'package:acik_soru/page/students/profile/page/politiciy_page.dart';
import 'package:acik_soru/page/teacher/page/profile/account_details_page.dart';
import 'package:acik_soru/service/get_user_details.dart';
import 'package:acik_soru/service/teacher/get_teacher_earning.dart';
import 'package:acik_soru/service/token_service.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../widget/profil_avatar.dart';
import '../../../../widget/profil_widget.dart';
import '../../../auth/login/login_page.dart';
import '../../../students/profile/widget/ques_packet_select.dart';

class TeacherProfilePage extends StatelessWidget {
  const TeacherProfilePage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profilim'),
        ),
        body: FutureBuilder<UserModel?>(
            future: getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userModel = snapshot.data?.data;

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        userModel!.picture == null
                            ? ProfilAvatar(
                                image: const AssetImage(
                                    "assets/image/student.jpeg"),
                                levelName: userModel.levelName ?? "",
                                name: userModel.name ?? "İsim bulunamadı",
                              )
                            : ProfilAvatar(
                                image:
                                    NetworkImage(userModel.picture.toString()),
                                levelName: userModel.levelName ?? "",
                                name: userModel.name ?? "İsim bulunamadı",
                              ),
                        const SizedBox(
                          height: 12,
                        ),
                        ProfilWidget(
                          onTap: () {
                            context.route
                                .navigateToPage(const AccountDetailsPage());
                          },
                          color: Colors.pinkAccent,
                          icon: Icons.person,
                          title: "Hesap Bilgileri",
                        ),
                        ProfilWidget(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(
                                  builder: (context, setState) => Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    height: 480,
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FutureBuilder<
                                              TeacherEarningModel?>(
                                          future: getTeacherEarning(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              return Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Text(
                                                      "Kazançlarım",
                                                      style: context
                                                          .textTheme.bodyLarge,
                                                    ),
                                                  ),
                                                  QuesPacketSelect(
                                                    isPacket: true,
                                                    desc: "Bu ay toplam kazanç",
                                                    image:
                                                        "assets/image/mondey2.png",
                                                    title:
                                                        "${snapshot.data?.thisMonthEarnings} ₺",
                                                  ),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  QuesPacketSelect(
                                                    isPacket: true,
                                                    desc: "Toplam kazanç",
                                                    image:
                                                        "assets/image/mondey2.png",
                                                    title:
                                                        "${snapshot.data?.pastMonthsEarnings} ₺",
                                                  ),
                                                  // Padding(
                                                  //   padding:
                                                  //       const EdgeInsets.all(
                                                  //           8.0),
                                                  //   child: CustomButton(
                                                  //     color: context.general
                                                  //         .colorScheme.primary,
                                                  //     onPressed: () {
                                                  //       context.navigateToPage(
                                                  //           const EarningView());
                                                  //     },
                                                  //     title:
                                                  //         "Eski Kazançlara Göz At",
                                                  //   ),
                                                  // )
                                                ],
                                              );
                                            } else {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator
                                                          .adaptive());
                                            }
                                          }),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          color: Colors.amberAccent,
                          icon: Icons.add_shopping_cart_outlined,
                          title: "Kazancım",
                        ),
                        ProfilWidget(
                          onTap: () {
                            context.route.navigateToPage(const PoliticiyPage());
                          },
                          color: Colors.orangeAccent,
                          icon: Icons.policy,
                          title: "Kurumsal",
                        ),
                        ProfilWidget(
                          onTap: () async {
                            await SharedService().removeToken();
                            await SharedService().removeBarrerToken();
                            await SharedService().saveloginKey("0");

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false);
                          },
                          color: Colors.redAccent,
                          icon: Icons.exit_to_app,
                          title: "Çıkış Yap",
                        ),
                        ProfilWidget(
                          onTap: () async {
                            await SharedService().removeToken();
                            await SharedService().removeBarrerToken();

                            await SharedService().saveloginKey("0");

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                                (route) => false);
                          },
                          color: const Color.fromARGB(255, 255, 0, 0),
                          icon: Icons.delete,
                          title: "Hesabı Sil",
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
            }));
  }
}
