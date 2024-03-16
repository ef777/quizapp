import 'package:acik_soru/model/auth/user_model.dart';
import 'package:acik_soru/page/students/profile/page/webview.dart';
import 'package:acik_soru/service/update_servide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kartal/kartal.dart';

import '../../../../const/const.dart';

class AddAddresPage extends StatelessWidget {
  const AddAddresPage({Key? key, required this.packageID}) : super(key: key);
  final String packageID;

  @override
  Widget build(BuildContext context) {
    TextEditingController countryCont = TextEditingController();
    TextEditingController addressCont = TextEditingController();
    TextEditingController cityCont = TextEditingController();
    TextEditingController zipcodeCont = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Fatura Bilgileri'),
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
              child: SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                              "Adres Formu",
                              style: context.general.textTheme.labelLarge
                                  ?.copyWith(
                                color: Colors.black54,
                              ),
                            ),
                            Text(
                              "Ödeme ve fatura bilgileri için gerekli adres bilgilerini doldurarak ödemeye devam edebilirsin",
                              style: context.general.textTheme.labelLarge
                                  ?.copyWith(
                                color: Colors.grey,
                              ),
                            ),
                            SizedBox(
                              height: context.general.mediaSize.height * 0.005,
                            ),
                            SizedBox(
                              height: 46,
                              child: TextField(
                                controller: countryCont,
                                decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          "assets/icon/icon_profile.svg"),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        top: 12, left: 12),
                                    focusedBorder: UnderlineInputBorder(
                                        borderRadius:
                                            context.border.lowBorderRadius,
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.blue)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderRadius:
                                            context.border.lowBorderRadius,
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.blueGrey)),
                                    fillColor: Colors.white,
                                    hintText: "Ülke"),
                              ),
                            ),
                            SizedBox(
                              height: context.general.mediaSize.height * 0.01,
                            ),
                            SizedBox(
                              height: 46,
                              child: TextField(
                                controller: cityCont,
                                decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          "assets/icon/icon_profile.svg"),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        top: 12, left: 12),
                                    focusedBorder: UnderlineInputBorder(
                                        borderRadius:
                                            context.border.lowBorderRadius,
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.blue)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderRadius:
                                            context.border.lowBorderRadius,
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.blueGrey)),
                                    fillColor: Colors.white,
                                    hintText: "Şehir"),
                              ),
                            ),
                            SizedBox(
                              height: context.general.mediaSize.height * 0.01,
                            ),
                            SizedBox(
                              height: 46,
                              child: TextField(
                                controller: addressCont,
                                decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          "assets/icon/icon_phone.svg"),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        top: 12, left: 12),
                                    focusedBorder: UnderlineInputBorder(
                                        borderRadius:
                                            context.border.lowBorderRadius,
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.blue)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderRadius:
                                            context.border.lowBorderRadius,
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.blueGrey)),
                                    fillColor: Colors.white,
                                    hintText: "Adres"),
                              ),
                            ),
                            SizedBox(
                              height: context.general.mediaSize.height * 0.01,
                            ),
                            SizedBox(
                              height: 46,
                              child: TextField(
                                controller: zipcodeCont,
                                decoration: InputDecoration(
                                    suffixIcon: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SvgPicture.asset(
                                          "assets/icon/icon_user.svg"),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        top: 12, left: 12),
                                    focusedBorder: UnderlineInputBorder(
                                        borderRadius:
                                            context.border.lowBorderRadius,
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.blue)),
                                    enabledBorder: UnderlineInputBorder(
                                        borderRadius:
                                            context.border.lowBorderRadius,
                                        borderSide: const BorderSide(
                                            width: 1, color: Colors.blueGrey)),
                                    fillColor: Colors.white,
                                    hintText: "Posta Kodu"),
                              ),
                            ),
                            SizedBox(
                              height: context.general.mediaSize.height * 0.01,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            context.border.lowBorderRadius)),
                                onPressed: () {
                                  userUpdate(Data(
                                          address: addressCont.text,
                                          country: countryCont.text,
                                          city: cityCont.text,
                                          zipcode: zipcodeCont.text))
                                      .then((value) {
                                    if (value?.success ?? false) {
                                      context.route.navigateToPage(
                                        IyzcoWebView(
                                          url:
                                              "https://aciksoru.com.tr/packet_buy/${Config.userId}/${packageID}",
                                        ),
                                      ); // 119 user 
                                    } else {}
                                  });
                                },
                                child: Text(
                                  "DEVAM ET",
                                  style: context.general.textTheme.bodyMedium
                                      ?.copyWith(
                                          fontSize: 18,
                                          color: context
                                              .general.colorScheme.onPrimary),
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
