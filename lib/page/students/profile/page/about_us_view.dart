import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:flutter_html/flutter_html.dart';

class DescripitonPage extends StatelessWidget {
  const DescripitonPage({Key? key, required this.text, required this.title})
      : super(key: key);
  final String text;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SafeArea(
              child: Column(
                children: [
                  Html(
                    data: text,
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
