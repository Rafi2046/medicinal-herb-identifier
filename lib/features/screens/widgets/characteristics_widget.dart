import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

import 'character_container_widget.dart';

class CharacteristicsWidget extends StatelessWidget {
  const CharacteristicsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                  image: AssetImage(AppImages.characterIcon),
                  width: 35,
                  height: 35,
                ),
                const SizedBox(width: 8),
                Text('Characteristics', style: AppTextStyles.confidenceName.copyWith(
                  color: isDark ? Colors.white : AppColors.herbName,
                )),
              ],
            ),
          ),
          const Divider(height: 0.5, thickness: 0.5),

          Padding(
            padding: EdgeInsets.all(16),
            child: Wrap(

              children: [
                CharacterContainerWidget(title: 'Bright green oval leaves'),
                CharacterContainerWidget(title: 'Strong aromatic scent'),
                CharacterContainerWidget(title: 'White or purple flowers'),

                CharacterContainerWidget(title: 'Tender texture'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
