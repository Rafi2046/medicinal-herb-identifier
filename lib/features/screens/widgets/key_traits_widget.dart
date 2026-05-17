import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class KeyTraitsWidget extends StatelessWidget {
  const KeyTraitsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.borderColors),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 8,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Key Traits', style: AppTextStyles.confidenceName),

            Row(
              spacing: AppSpacing.s8,
              children: [
                Image(
                  image: AssetImage(AppImages.tickSign),
                  height: 20,
                  width: 20,
                ),
                Text('Bright green color', style: AppTextStyles.keyTraits),
              ],
            ),
            Row(
              spacing: AppSpacing.s8,
              children: [
                Image(
                  image: AssetImage(AppImages.tickSign),
                  height: 20,
                  width: 20,
                ),
                Text('Bright green color', style: AppTextStyles.keyTraits),
              ],
            ),
            Row(
              spacing: AppSpacing.s8,
              children: [
                Image(
                  image: AssetImage(AppImages.tickSign),
                  height: 20,
                  width: 20,
                ),
                Text('Bright green color', style: AppTextStyles.keyTraits),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
