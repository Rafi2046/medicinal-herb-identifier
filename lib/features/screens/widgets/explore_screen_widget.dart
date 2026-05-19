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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final borderColor = isDark ? const Color(0xFF334155) : AppColors.borderColor;
    final titleColor = isDark ? Colors.white : AppColors.herbName;
    final subtitleColor = isDark ? Colors.white70 : AppColors.desText;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: borderColor),
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
                      style: AppTextStyles.confidenceName.copyWith(color: titleColor),
                    ),
                    TextSpan(
                      text: scientificName ?? 'Ocimum basilicum',
                      style: AppTextStyles.desText.copyWith(color: subtitleColor),
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
                color: isDark ? Colors.white70 : AppColors.borderColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
