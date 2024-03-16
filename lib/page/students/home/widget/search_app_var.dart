// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    this.onChanged,
  });
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 205,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 205,
            decoration: BoxDecoration(
                borderRadius: context.normalBorderRadius,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey.withOpacity(.3),
                      spreadRadius: 3,
                      blurRadius: 2)
                ],
                color: const Color.fromRGBO(78, 116, 249, 1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Merhaba 👋",
                        style: context.textTheme.titleLarge?.copyWith(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                      Container(
                        width: 41,
                        height: 41,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(112, 255, 255, 255)),
                        child: const Icon(
                          Icons.notifications_active,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "Gireceğin sınavı veya kademeyi seçerek sorularını sorabilirsin 😏",
                    style: context.textTheme.titleSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Image.asset("assets/image/circle.png"),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 44,
                child: TextField(
                  onChanged: onChanged,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      contentPadding:
                          const EdgeInsets.only(right: 12, left: 12),
                      hintText: "Bir ders ara ...",
                      labelStyle: const TextStyle(color: Colors.grey),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: context.border.normalBorderRadius),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: context.border.normalBorderRadius),
                      filled: true,
                      fillColor: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
