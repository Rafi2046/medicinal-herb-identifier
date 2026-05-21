import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class BadSidesWidget extends StatelessWidget {
  final List<String> sides;
  const BadSidesWidget({super.key, this.sides = const []});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? const Color(0xFF0F172A) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: isDark ? const Color(0xFF1E293B) : AppColors.borderColors),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              spacing: 8,
              children: [
                Image(
                  image: AssetImage(AppImages.detailsTickIcon),
                  width: 28,
                  height: 28,
                  color: Colors.orange,
                ),
                Text(
                  'Bad Sides',
                  style: AppTextStyles.confidenceName.copyWith(
                    color: isDark ? Colors.white : AppColors.herbName,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 0.5, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 8,
              children: sides.map((side) {
                return Row(
                  spacing: 8,
                  children: [
                    Image(
                      image: AssetImage(AppImages.detailsTickIcon),
                      height: 20,
                      width: 20,
                      color: Colors.orange,
                    ),
                    Expanded(
                      child: Text(
                        side,
                        style: AppTextStyles.desText.copyWith(
                          color: isDark ? Colors.white70 : AppColors.desText,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
