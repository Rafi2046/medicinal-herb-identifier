import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.borderColors),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Image(
                  image: AssetImage(AppImages.descriptionIcon),
                  width: 35,
                  height: 35,
                ),
                const SizedBox(width: 8),
                Text(
                  'Description',
                  style: AppTextStyles.confidenceName,
                ),
              ],
            ),
          ),
          const Divider(height: 0.5, thickness: 0.5),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Basil is a fragrant herb from the mint family. It has bright green, tender leaves and a sweet, slightly peppery flavor that transforms dishes.',
              style: AppTextStyles.desText,
            ),
          ),
        ],
      ),
    );
  }
}