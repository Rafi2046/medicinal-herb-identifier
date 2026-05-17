import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class CharacterContainerWidget extends StatelessWidget {
  final String? title;

  const CharacterContainerWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppColors.containerColorGreen,
          border: Border.all(width: 1,color: AppColors.desText)
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(title ?? '', style: AppTextStyles.characterText),
        ),
      ),
    );
  }
}
