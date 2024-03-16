// ignore_for_file: deprecated_member_use, unnecessary_null_comparison, use_build_context_synchronously

import 'package:acik_soru/model/auth/user_model.dart';
import 'package:acik_soru/model/student_model/get_user_package_model.dart';
import 'package:acik_soru/page/students/profile/page/account_details_page.dart';
import 'package:acik_soru/page/students/profile/page/packet_list_view.dart';
import 'package:acik_soru/page/students/profile/page/politiciy_page.dart';

import 'package:acik_soru/page/students/profile/widget/ques_packet_select.dart';

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../service/get_user_details.dart';
import '../../../service/students/get_my_package_service.dart';
import '../../../service/token_service.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/profil_avatar.dart';
import '../../../widget/profil_widget.dart';
import '../../auth/login/login_page.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({
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
                                    child: FutureBuilder<GetUserPackageModel>(
                                        future: getMyPackage(),
                                        builder: (context, snapshotPackage) {
                                          if (snapshotPackage.hasData) {
                                            Response? userGetPackage =
                                                snapshotPackage
                                                    .data?.data?.response;
                                            return Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: context.general
                                                          .mediaSize.height *
                                                      0.02,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Kullandığınız Paket",
                                                    style: context
                                                        .textTheme.bodyLarge,
                                                  ),
                                                ),
                                                userGetPackage == null
                                                    ? const Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: QuesPacketSelect(
                                                          isPacket: true,
                                                          desc:
                                                              "Paket satın alabilirsiniz",
                                                          image:
                                                              "assets/image/error.jpeg",
                                                          title:
                                                              "Bir Paketiniz Bulunmamakta",
                                                        ),
                                                      )
                                                    : ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            userGetPackage ==
                                                                    null
                                                                ? 0
                                                                : 1,
                                                        itemBuilder: (context,
                                                                index) =>
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  QuesPacketSelect(
                                                                isPacket: true,
                                                                desc: userGetPackage
                                                                        .packetDescription ??
                                                                    "",
                                                                image:
                                                                    "assets/image/video.jpeg",
                                                                title: userGetPackage
                                                                        .packetName ??
                                                                    "",
                                                              ),
                                                            )),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: CustomButton(
                                                    color: context.general
                                                        .colorScheme.primary,
                                                    onPressed: () {
                                                      context.navigateToPage(
                                                          PacketListView(
                                                        zipcode: snapshot
                                                                .data
                                                                ?.data
                                                                ?.zipcode ??
                                                            "",
                                                      ));
                                                    },
                                                    title:
                                                        "Diğer Paketlera Göz At",
                                                  ),
                                                )
                                              ],
                                            );
                                          } else {
                                            return const Center(
                                              child: CircularProgressIndicator
                                                  .adaptive(),
                                            );
                                          }
                                        }),
                                  ),
                                );
                              },
                            );
                          },
                          color: Colors.amberAccent,
                          icon: Icons.add_shopping_cart_outlined,
                          title: "Üyelik Paketleri",
                        ),
                        // ProfilWidget(
                        //   onTap: () {},
                        //   color: Colors.purpleAccent,
                        //   icon: Icons.question_mark,
                        //   title: "Sıkça Sorulan Sorular",
                        // ),
                        ProfilWidget(
                          onTap: () {
                            context.navigateToPage(const PoliticiyPage());
                          },
                          color: Colors.orangeAccent,
                          icon: Icons.policy,
                          title: "Politikalar",
                        ),
                        // ProfilWidget(
                        //   onTap: () {
                        //     context.navigateToPage(const AboutUsView());
                        //   },
                        //   color: Colors.blueAccent,
                        //   icon: Icons.info,
                        //   title: "Hakkımızda",
                        // ),
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
                            await SharedService().saveloginKey("0");

                            await SharedService().removeBarrerToken();

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
