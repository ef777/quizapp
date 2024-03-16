// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class BranchWidget extends StatelessWidget {
  const BranchWidget({
    super.key,
    required this.title,
    required this.image,
    required this.desc,
    this.onTap,
    required this.title2,
  });
  final String title;
  final String title2;
  final Widget image;
  final String desc;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: context.normalBorderRadius,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(.2),
                  blurRadius: 4,
                  spreadRadius: 2)
            ]),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: context.general.mediaSize.width / 4,
                height: context.general.mediaSize.width / 4,
                child: Center(
                  child: ClipRRect(
                      borderRadius: context.border.lowBorderRadius,
                      child: image),
                ),
              ),
              SizedBox(
                height: context.general.mediaSize.height * 0.01,
              ),
              Text(
                title,
                style: context.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                desc,
                style:
                    context.textTheme.bodySmall?.copyWith(color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
