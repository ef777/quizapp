// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class PackageWidget extends StatelessWidget {
  const PackageWidget({
    super.key,
    required this.title,
    required this.image,
    required this.desc,
    this.isPacket,
    this.isPrice,
    this.price,
  });
  final String title;
  final String desc;
  final bool? isPacket;
  final String image;
  final bool? isPrice;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          borderRadius: context.normalBorderRadius,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.blueGrey.withOpacity(.1),
                blurRadius: 20,
                spreadRadius: 7)
          ]),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(35),
            child: Image.asset(
              image,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            width: context.width * 0.03,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w600),
                ),
                Text(desc)
              ],
            ),
          ),
          isPrice ?? false
              ? Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color.fromARGB(109, 105, 240, 175)),
                    child: Text(
                      "$price ₺",
                      style: context.textTheme.bodyMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
