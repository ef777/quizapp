import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ProfilAvatar extends StatelessWidget {
  const ProfilAvatar({
    super.key,
    required this.name,
    required this.levelName,
    required this.image,
  });
  final String name;
  final String levelName;
  final ImageProvider<Object>? image;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        child: Row(
          children: [
            CircleAvatar(
              radius: 45,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: CircleAvatar(radius: 40, backgroundImage: image),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: context.general.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    levelName,
                    style: context.general.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
