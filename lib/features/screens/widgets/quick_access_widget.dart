import 'package:flutter/material.dart';

import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class QuickAccessWidget extends StatelessWidget {
  const QuickAccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Container(
            height: 80,
            clipBehavior: Clip.antiAlias,

            decoration: BoxDecoration(
              border: Border.all(width: 2, color: Colors.teal),
              borderRadius: BorderRadius.circular(20),
              color: AppColors.white,
            ),

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: AppSpacing.s8,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage(AppImages.favoriteIcon),
                    width: AppSpacing.w40,
                    height: AppSpacing.h40,
                  ),

                  Column(
                    spacing: AppSpacing.s2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Favorites', style: AppTextStyles.uploadText),

                      SizedBox(height: AppSpacing.s4),

                      Text('0 saved herbs', style: AppTextStyles.quickSubTile),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        Expanded(
          child: Container(
            height: 80,
            clipBehavior: Clip.antiAlias,

            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(width: 2, color: Colors.teal),
              borderRadius: BorderRadius.circular(20),
            ),

            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: AppSpacing.s8,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image(
                    image: AssetImage(AppImages.historyIcon),
                    width: AppSpacing.w40,
                    height: AppSpacing.h40,
                  ),

                  Column(
                    spacing: AppSpacing.s2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('History', style: AppTextStyles.uploadText),

                      SizedBox(height: AppSpacing.s4),

                      Text('Recent scans', style: AppTextStyles.quickSubTile),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
