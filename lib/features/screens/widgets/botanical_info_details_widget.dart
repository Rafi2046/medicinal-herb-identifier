import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

class BotanicalInfoDetailsWidget extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final String? imagePath;

  const BotanicalInfoDetailsWidget({
    super.key,
    this.title,
    this.subtitle,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            spacing: 8,
            children: [
              Image.asset(
                imagePath ?? '',
                width: 35,
                height: 35,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(title ?? '', style: AppTextStyles.detailsText),
                  Text(subtitle ?? '', style: AppTextStyles.desText),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
