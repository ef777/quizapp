import 'package:acik_soru/page/teacher/page/home/teacher_home_page.dart';
import 'package:acik_soru/widget/custom_button.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../model/auth/user_model.dart';
import '../../../../service/get_user_details.dart';
import '../../../../service/update_servide.dart';

class AccountDetailsPage extends StatelessWidget {
  const AccountDetailsPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController nameCont = TextEditingController();
    TextEditingController mailCont = TextEditingController();
    TextEditingController phoneCont = TextEditingController();
    TextEditingController passwordCont = TextEditingController();
    TextEditingController ibanCont = TextEditingController();
    TextEditingController bankNameCont = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Hesap Bilgileri'),
        ),
        body: FutureBuilder<UserModel?>(
            future: getUserDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var userModel = snapshot.data?.data;
                nameCont.text = userModel?.name ?? "";
                mailCont.text = userModel?.email ?? "";
                phoneCont.text = userModel?.phone ?? "";
                passwordCont.text = "*******";
                ibanCont.text = userModel?.iban ?? "";
                bankNameCont.text = userModel?.bankName ?? "";
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      AccountWidget(
                        nameCont: nameCont,
                        color: Colors.pinkAccent,
                        icon: Icons.person,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AccountWidget(
                        nameCont: mailCont,
                        color: Colors.amber,
                        icon: Icons.mail,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AccountWidget(
                        nameCont: phoneCont,
                        color: Colors.blueAccent,
                        icon: Icons.phone,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AccountWidget(
                        nameCont: ibanCont,
                        color: const Color.fromARGB(255, 0, 229, 8),
                        icon: Icons.monetization_on,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      AccountWidget(
                        nameCont: bankNameCont,
                        color: Colors.deepPurpleAccent,
                        icon: Icons.width_normal_outlined,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomButton(
                          color: context.general.colorScheme.primary,
                          onPressed: () {
                            userUpdate(Data(
                                    bankName: bankNameCont.text,
                                    iban: ibanCont.text,
                                    name: nameCont.text,
                                    email: mailCont.text,
                                    phone: phoneCont.text))
                                .then((value) => {
                                      if (value?.success ?? false)
                                        {
                                          CherryToast.success(
                                                  title: const Text(
                                                      "Bilgilerin Güncellendi"))
                                              .show(context),
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const TeacherHomePage(),
                                              ),
                                              (route) => false)
                                        }
                                    });
                          },
                          title: "Bilgileri Güncelle",
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              }
            }));
  }
}

class AccountWidget extends StatelessWidget {
  const AccountWidget({
    super.key,
    required this.nameCont,
    required this.color,
    required this.icon,
  });

  final TextEditingController nameCont;
  final Color color;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      height: 80,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(shape: BoxShape.circle, color: color),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: nameCont,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.only(left: 0),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  border: OutlineInputBorder(borderSide: BorderSide.none)),
            ),
          ),
          // Padding(
          //   padding:
          //       const EdgeInsets.symmetric(horizontal: 12),
          //   child: Container(
          //     padding: const EdgeInsets.all(8),
          //     decoration: const BoxDecoration(
          //         shape: BoxShape.circle,
          //         color: Color.fromARGB(52, 225, 225, 225)),
          //     child: const Icon(
          //       Icons.arrow_forward_ios,
          //       color: Colors.grey,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
