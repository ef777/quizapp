import 'package:acik_soru/model/get_package_model.dart';
import 'package:acik_soru/page/students/profile/page/webview.dart';
import 'package:acik_soru/page/students/profile/widget/ques_packet_select.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import '../../../../const/const.dart';
import '../../../../service/students/get_package_service.dart';
import 'add_adress_page.dart';

class PacketListView extends StatelessWidget {
  const PacketListView({Key? key, required this.zipcode}) : super(key: key);
  final String zipcode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Soru Paketleri'),
        ),
        body: FutureBuilder<GetPackageModel>(
            future: getPackageService(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Response>? packageModel = snapshot.data?.data?.response;
                return ListView.builder(
                  itemCount: packageModel?.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        if (zipcode == "") {
                          context.route.navigateToPage(AddAddresPage(
                            packageID: packageModel?[index].id.toString() ?? "",
                          ));
                        } else {
                          context.route.navigateToPage(
                            IyzcoWebView(
                              url:
                                  "https://aciksoru.com.tr/packet_buy/${Config.userId}/${packageModel?[index].id}",
                            ),
                          );
                        }

                        // packageAdd(
                        //         packetId: packageModel?[index].id.toString() ??
                        //             "Açıklama Bulunamadı",
                        //         userId: Config.userId)
                        //     .then((value) {
                        //   if (value?.data?.status ?? false) {
                        //     QuickAlert.show(
                        //         confirmBtnText: "Tamam",
                        //         text: value?.message,
                        //         title: "Başarıyla Tanımlandı",
                        //         context: context,
                        //         type: QuickAlertType.success);
                        //   } else {
                        //     QuickAlert.show(
                        //         confirmBtnText: "Tamam",
                        //         text: value?.message,
                        //         title: "Tanımlama Başarısız",
                        //         context: context,
                        //         type: QuickAlertType.error);
                        //   }
                        // });
                      },
                      child: QuesPacketSelect(
                        price: packageModel?[index].price.toString() ??
                            "Açıklama Bulunamadı",
                        isPrice: true,
                        isPacket: true,
                        desc: packageModel?[index].description ??
                            "Açıklama Bulunamadı",
                        image: 'assets/image/start_icon.jpeg',
                        title:
                            packageModel?[index].name ?? "Açıklama Bulunamadı",
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            }));
  }
}
