import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'botanical_info_details_widget.dart';

class BotanicalInfoWidget extends StatelessWidget {
  final String scientificName;
  final String family;
  final String region;

  const BotanicalInfoWidget({
    super.key,
    this.scientificName = '',
    this.family = '',
    this.region = '',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final customDivider = Divider(
      height: 0.5,
      thickness: 0.5,
      indent: 20,
      endIndent: 20,
      color: AppColors.borderColors,
    );

    return Card(
      color: isDark ? const Color(0xFF0F172A) : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: isDark ? const Color(0xFF1E293B) : AppColors.borderColors),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Image(
                  image: AssetImage(AppImages.botanicalInfoIcon),
                  width: 35,
                  height: 35,
                ),
                const SizedBox(width: 8),
                Text('Botanical Info', style: AppTextStyles.confidenceName.copyWith(
                  color: isDark ? Colors.white : AppColors.herbName,
                )),
              ],
            ),
          ),
          Divider(height: 0.5, thickness: 0.5, color: AppColors.borderColors),
          BotanicalInfoDetailsWidget(
            imagePath: AppImages.scientificIcon,
            title: 'SCIENTIFIC NAME',
            subtitle: scientificName,
          ),
          customDivider,
          BotanicalInfoDetailsWidget(
            imagePath: AppImages.plantFamilyIcon,
            title: 'PLANT FAMILY',
            subtitle: family,
          ),
          customDivider,
          BotanicalInfoDetailsWidget(
            imagePath: AppImages.nativeRegionIcon,
            title: 'NATIVE REGION',
            subtitle: region,
          ),
        ],
      ),
    );
  }
}
