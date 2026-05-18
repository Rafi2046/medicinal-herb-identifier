import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/screens/herb_full_details_screen.dart';

class SavedScreenItemsWidget extends StatelessWidget {
  const SavedScreenItemsWidget({super.key});

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
              borderRadius: BorderRadius.circular(2),
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
                  Text('Moringa', style: AppTextStyles.confidenceName),
                  Text('Ocimum basilicum', style: AppTextStyles.desText),
                  Row(
                    spacing: 8.0,
                    children: [
                      Image(
                        image: AssetImage(AppImages.tickSign),
                        width: 16,
                        height: 16,
                      ),
                      Expanded(
                        child: Text(
                          'Origanum vulgare',
                          style: AppTextStyles.savedText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text('•', style: AppTextStyles.savedText),
                      Text('2h ago', style: AppTextStyles.savedText),
                    ],
                  ),
                ],
              ),
            ),

            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HerbFullDetailsScreen(),
                  ),
                );
              },
              child: Image(
                image: AssetImage(AppImages.arrowForward),
                width: 24,
                height: 24,
              ),
            ),

            const SizedBox(width: AppSpacing.s4),
            Image(
              image: AssetImage(AppImages.deleteIcon),
              width: 24,
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
