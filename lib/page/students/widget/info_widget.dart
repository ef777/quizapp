// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class InfoWidget extends StatelessWidget {
  const InfoWidget({
    super.key,
    required this.image,
    required this.title,
    required this.isTeac,
    this.rating,
    this.imageNetwork,
  });
  final String image;
  final String title;
  final bool isTeac;
  final int? rating;
  final String? imageNetwork;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      height: 80,
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
          isTeac
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: imageNetwork == "" && imageNetwork == null
                      ? Image.asset(
                          image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          imageNetwork ??
                              "https://i.pinimg.com/originals/e3/5d/48/e35d4830a57eca2184871e41ce2a1b18.jpg",
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    image,
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
          SizedBox(
            width: context.width * 0.03,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
              ),
              isTeac
                  ? Row(
                      children: List.generate(
                          rating ?? 1,
                          (index) =>
                              const Icon(Icons.star, color: Colors.amber)),
                    )
                  : const SizedBox.shrink()
            ],
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
