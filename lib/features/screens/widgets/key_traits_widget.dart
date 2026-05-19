import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class KeyTraitsWidget extends StatelessWidget {
  const KeyTraitsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final borderColor = isDark ? const Color(0xFF334155) : AppColors.borderColors;
    final titleColor = isDark ? Colors.white : AppColors.herbName;
    final textColor = isDark ? Colors.white70 : AppColors.keyTraits;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Key Traits', style: AppTextStyles.confidenceName.copyWith(color: titleColor)),

            Row(
              spacing: AppSpacing.s8,
              children: [
                Image(
                  image: AssetImage(AppImages.tickSign),
                  height: 20,
                  width: 20,
                  color: isDark ? Colors.white : null,
                ),
                Text('Bright green color', style: AppTextStyles.keyTraits.copyWith(color: textColor)),
              ],
            ),
            Row(
              spacing: AppSpacing.s8,
              children: [
                Image(
                  image: AssetImage(AppImages.tickSign),
                  height: 20,
                  width: 20,
                  color: isDark ? Colors.white : null,
                ),
                Text('Bright green color', style: AppTextStyles.keyTraits.copyWith(color: textColor)),
              ],
            ),
            Row(
              spacing: AppSpacing.s8,
              children: [
                Image(
                  image: AssetImage(AppImages.tickSign),
                  height: 20,
                  width: 20,
                  color: isDark ? Colors.white : null,
                ),
                Text('Bright green color', style: AppTextStyles.keyTraits.copyWith(color: textColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
