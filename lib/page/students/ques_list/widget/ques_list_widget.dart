import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class QuesListWidget extends StatelessWidget {
  const QuesListWidget({
    super.key,
    required this.title,
    required this.desc,
    required this.time,
    required this.color,
    required this.buttonTitle,
    this.onPressed,
  });
  final String title;
  final String desc;
  final String time;
  final Color color;

  final String buttonTitle;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
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
        children: [
          Image.asset(
            "assets/image/question.jpeg",
            height: 70,
          ),
          SizedBox(
            width: context.general.mediaSize.width * 0.03,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.general.textTheme.bodyLarge,
                ),
                Text(
                  desc,
                ),
                // Text(
                //   time,
                //   style: context.general.textTheme.bodySmall,
                // ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  height: 10,
                  width: 10,
                  decoration:
                      BoxDecoration(color: color, shape: BoxShape.circle),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(6)),
                child: Text(
                  color == Colors.redAccent ? "Bekleniyor" : "Cevaplandı",
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
