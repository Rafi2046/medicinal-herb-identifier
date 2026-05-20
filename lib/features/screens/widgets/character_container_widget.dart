import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class CharacterContainerWidget extends StatelessWidget {
  final String? title;

  const CharacterContainerWidget({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark ? const Color(0xFF1E3A2A) : AppColors.containerColorGreen,
          border: Border.all(width: 1,color: isDark ? const Color(0xFF2D5A3A) : AppColors.desText)
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(title ?? '', style: AppTextStyles.characterText.copyWith(
            color: isDark ? const Color(0xFF70e59c) : AppColors.characterName,
          )),
        ),
      ),
    );
  }
}
