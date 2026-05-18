import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class SavedScreenItemsWidget extends StatelessWidget {
  final String herbName;
  final String scientificName;
  final String family;
  final String imagePath;
  final VoidCallback onDelete;

  const SavedScreenItemsWidget({
    super.key,
    required this.herbName,
    required this.scientificName,
    required this.family,
    required this.imagePath,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(color: AppColors.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: AppColors.borderColor),
                ),
                child: Image(
                  image: AssetImage(AppImages.exploreImage),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.s8),
            Expanded(
              child: Column(
                spacing: AppSpacing.s4,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(herbName, style: AppTextStyles.confidenceName),
                  Text(scientificName, style: AppTextStyles.desText),
                  Row(
                    children: [
                      Image(image: AssetImage(AppImages.tickSign), width: 16, height: 16),
                      const SizedBox(width: 4),
                      Expanded(child: Text(family, style: AppTextStyles.savedText, maxLines: 1, overflow: TextOverflow.ellipsis)),
                      Text('•', style: AppTextStyles.savedText),
                      const SizedBox(width: 4),
                      Text('2h ago', style: AppTextStyles.savedText),
                    ],
                  ),
                ],
              ),
            ),
            Image(image: AssetImage(AppImages.arrowForward), width: 24, height: 24),
            const SizedBox(width: AppSpacing.s4),
            GestureDetector(
              onTap: onDelete,
              child: Image(image: AssetImage(AppImages.deleteIcon), width: 24, height: 24),
            ),
          ],
        ),
      ),
    );
  }
}