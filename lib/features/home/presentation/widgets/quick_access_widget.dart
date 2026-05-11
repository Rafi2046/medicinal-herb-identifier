import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

class QuickAccessWidget extends StatelessWidget {
  const QuickAccessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [


        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  AppImages.favoriteIcon,
                  height: 40,
                  width: 40,
                ),

                const SizedBox(width: AppSpacing.w12),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Favorites",
                      style: AppTextStyles.buttonText,
                    ),
                    Text(
                      "0 Saved herbs",
                      style: AppTextStyles.quickSubTile,

                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        const SizedBox(width: AppSpacing.w12),

        Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  AppImages.historyIcon,
                  height: 40,
                  width: 40,
                ),

                const SizedBox(width: AppSpacing.w12),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "History",style: AppTextStyles.buttonText,

                    ),
                    Text(
                      "Recent scans",
                      style: AppTextStyles.quickSubTile,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}