// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class SearchLessonAppBar extends StatelessWidget {
  const SearchLessonAppBar({
    super.key,
    this.title,
    this.desc,
    this.onChanged,
  });
  final String? title;
  final String? desc;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
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
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40,
                height: 40,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color.fromARGB(112, 255, 255, 255)),
                child: const Center(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: context.height * 0.01,
            ),
            Text(
              title ?? "Dersi seç ve sorunu yükle 😏",
              style: context.textTheme.titleSmall
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            SizedBox(
              height: 44,
              child: TextField(
                onChanged: onChanged,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 16, right: 32),
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    hintText: desc ?? "Bir ders ara ...",
                    labelStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: context.normalBorderRadius),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: context.normalBorderRadius),
                    filled: true,
                    fillColor: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
