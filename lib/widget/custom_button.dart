import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onPressed,
    this.title,
    this.color,
    this.textColor,
    this.radius,
  });
  final void Function()? onPressed;
  final String? title;
  final Color? color;
  final Color? textColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      width: double.infinity,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius ?? 8)),
              backgroundColor: color),
          onPressed: onPressed,
          child: Text(
            title ?? "Hadi Başlıyalım",
            style: TextStyle(color: textColor ?? Colors.white),
          )),
    );
  }
}
