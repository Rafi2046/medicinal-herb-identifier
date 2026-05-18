import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/screens/herb_full_details_screen.dart';

class ExploreScreenWidget extends StatelessWidget {
  final String? herbName;
  final String? scientificName;
  final String? imagePath;

  const ExploreScreenWidget({
    super.key,
    this.herbName,
    this.scientificName,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: AppColors.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2, color: AppColors.borderColor),
                ),
                child: Image(
                  image: AssetImage(imagePath ?? AppImages.exploreImage),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.s8),
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${herbName ?? 'Moringa'}\n',
                      style: AppTextStyles.confidenceName,
                    ),
                    TextSpan(
                      text: scientificName ?? 'Ocimum basilicum',
                      style: AppTextStyles.desText,
                    ),
                  ],
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
              child: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: AppColors.borderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
