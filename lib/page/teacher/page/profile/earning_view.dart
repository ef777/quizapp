import 'package:acik_soru/page/students/profile/widget/ques_packet_select.dart';
import 'package:flutter/material.dart';

class EarningView extends StatelessWidget {
  const EarningView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Eski Kazançlarım'),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              QuesPacketSelect(
                price: "3020",
                isPrice: true,
                isPacket: true,
                desc: "Mayıs Ayı Toplam Kazanç",
                image: "assets/image/may.jpeg",
                title: "2023 - Mayıs ",
              ),
              SizedBox(
                height: 8,
              ),
            ],
          ),
        ));
  }
}
