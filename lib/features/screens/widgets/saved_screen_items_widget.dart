import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/data/plant_database.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/screens/herb_full_details_screen.dart';

class SavedScreenItemsWidget extends StatelessWidget {
  final String herbName;
  final VoidCallback onDelete;

  const SavedScreenItemsWidget({
    super.key,
    required this.herbName,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final borderColor = isDark ? const Color(0xFF334155) : AppColors.borderColor;
    final titleColor = isDark ? Colors.white : AppColors.herbName;
    final subtitleColor = isDark ? Colors.white70 : AppColors.desText;
    final smallTextColor = isDark ? Colors.white60 : AppColors.savedText;

    final plant = plantDatabase[herbName];
    final sciName = plant?.scientificName ?? '';
    final family = plant?.family ?? '';

    void _openDetails() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HerbFullDetailsScreen(herbName: herbName),
        ),
      );
    }

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: borderColor),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _openDetails,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: borderColor),
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
                    Text(herbName, style: AppTextStyles.confidenceName.copyWith(color: titleColor)),
                    if (sciName.isNotEmpty)
                      Text(sciName, style: AppTextStyles.desText.copyWith(color: subtitleColor)),
                    if (sciName.isEmpty)
                      Text('Tap to view details', style: AppTextStyles.desText.copyWith(color: subtitleColor)),
                    if (family.isNotEmpty)
                      Row(
                        children: [
                          Image(
                            image: AssetImage(AppImages.tickSign),
                            width: 16,
                            height: 16,
                            color: isDark ? Colors.white : null,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              family,
                              style: AppTextStyles.savedText.copyWith(color: smallTextColor),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              InkWell(
                onTap: _openDetails,
                child: Image(
                  image: AssetImage(AppImages.arrowForward),
                  width: 30,
                  height: 30,
                ),
              ),
              const SizedBox(width: AppSpacing.s4),
              InkWell(
                onTap: onDelete,
                child: Image(
                  image: AssetImage(AppImages.deleteIcon),
                  width: 30,
                  height: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
