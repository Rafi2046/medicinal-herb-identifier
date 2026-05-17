import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

import 'botanical_info_details_widget.dart';

class BotanicalInfoWidget extends StatelessWidget {
  const BotanicalInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final customDivider = Divider(
      height: 0.5,
      thickness: 0.5,
      indent: 20,
      endIndent: 20,
      color: AppColors.borderColors,
    );

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
                  image: AssetImage(AppImages.botanicalInfoIcon),
                  width: 35,
                  height: 35,
                ),
                const SizedBox(width: 8),
                Text('Botanical Info', style: AppTextStyles.confidenceName),
              ],
            ),
          ),
          Divider(height: 0.5, thickness: 0.5, color: AppColors.borderColors),

          BotanicalInfoDetailsWidget(
            imagePath: AppImages.scientificIcon,
            title: 'SCIENTIFIC NAME',
            subtitle: 'Ocimum basilicum',
          ),

          customDivider,

          BotanicalInfoDetailsWidget(
            imagePath: AppImages.plantFamilyIcon,
            title: 'PLANT FAMILY',
            subtitle: 'Lamiaceae',
          ),

          customDivider,

          BotanicalInfoDetailsWidget(
            imagePath: AppImages.nativeRegionIcon,
            title: 'NATIVE REGION',
            subtitle: 'Central Africa to SE Asia',
          ),

          customDivider,

          BotanicalInfoDetailsWidget(
            imagePath: AppImages.confidenceIcon,
            title: 'CONFIDENCE SCORE',
            subtitle: '96% Match',
          ),
        ],
      ),
    );
  }
}
