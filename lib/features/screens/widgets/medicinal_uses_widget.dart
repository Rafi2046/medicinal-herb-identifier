import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class MedicinalUsesWidget extends StatelessWidget {
  const MedicinalUsesWidget({super.key});

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
                  image: AssetImage(AppImages.medicinalIcon),
                  width: 35,
                  height: 35,
                ),

                Text(' Medicinal Uses', style: AppTextStyles.confidenceName.copyWith(
                  color: isDark ? Colors.white : AppColors.herbName,
                )),
              ],
            ),
          ),
          const Divider(height: 0.5, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              spacing: 8,
              children: [
                Row(
                  spacing: 8,
                  children: [
                    Image(
                      image: AssetImage(AppImages.detailsTickIcon),
                      height: 20,
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        'Italian cuisine (pesto, tomato dishes)',
                        style: AppTextStyles.desText.copyWith(
                          color: isDark ? Colors.white70 : AppColors.desText,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    Image(
                      image: AssetImage(AppImages.detailsTickIcon),
                      height: 20,
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        'Asian cooking (Thai basil)',
                        style: AppTextStyles.desText.copyWith(
                          color: isDark ? Colors.white70 : AppColors.desText,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    Image(
                      image: AssetImage(AppImages.detailsTickIcon),
                      height: 20,
                      width: 20,
                    ),
                    Expanded(
                      child: Text('Herbal tea', style: AppTextStyles.desText.copyWith(
                        color: isDark ? Colors.white70 : AppColors.desText,
                      )),
                    ),
                  ],
                ),
                Row(
                  spacing: 8,
                  children: [
                    Image(
                      image: AssetImage(AppImages.detailsTickIcon),
                      height: 20,
                      width: 20,
                    ),
                    Expanded(
                      child: Text(
                        'Anti-inflammatory properties',
                        style: AppTextStyles.desText.copyWith(
                          color: isDark ? Colors.white70 : AppColors.desText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
