import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/common_widgets/app_bar_widget.dart';
import 'package:medical_herb/features/common_widgets/custom_button.dart';
import 'package:medical_herb/features/screens/widgets/confidence_score_card_widget.dart';
import 'package:medical_herb/features/screens/widgets/key_traits_widget.dart';

import 'herb_full_details_screen.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final borderColor = isDark ? const Color(0xFF334155) : AppColors.borderColors;
    final pillColor = isDark ? const Color(0xFF334155) : AppColors.herbColorsName;
    final titleColor = isDark ? Colors.white : AppColors.herbName;
    final subtitleColor = isDark ? Colors.white70 : AppColors.desText;
    final buttonBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final buttonTextColor = isDark ? Colors.white : AppColors.herbScientific;

    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Details Screen',
        backArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Card(
              color: cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: borderColor),
              ),
              child: SizedBox(
                height: 135,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'IDENTIFIED AS ',
                              style: AppTextStyles.detailsText.copyWith(color: subtitleColor),
                            ),
                            Text('Akando ', style: AppTextStyles.herbName.copyWith(color: titleColor)),
                            Text(
                              'Origanum vulgare ',
                              style: AppTextStyles.detailsTextT.copyWith(color: subtitleColor),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: pillColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Lamiaceae',
                            style: AppTextStyles.herbNameScientific.copyWith(color: isDark ? Colors.white70 : null),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            const ConfidenceScoreCardWidget(),
            SizedBox(height: 8),
            KeyTraitsWidget(),
            SizedBox(height: 8),
            CustomButton(
              text: 'View Full Details',
              trailIcon: true,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  HerbFullDetailsScreen() ));
              },
            ),
            SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    backgroundColor: buttonBg,
                    showBorder: true,
                    borderColor: borderColor,
                    text: 'Favorite',
                    textColor: buttonTextColor,
                    onPressed: () {},
                    leading: Image.asset(
                      AppImages.favorites,
                      height: AppSpacing.h16,
                      color: isDark ? Colors.white : null,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: CustomButton(
                    backgroundColor: buttonBg,
                    showBorder: true,
                    borderColor: borderColor,
                    text: 'Scan Again',
                    textColor: buttonTextColor,
                    onPressed: () {},
                    leading: Image.asset(
                      AppImages.cameraIcon,
                      height: AppSpacing.h16,
                      color: Colors.green,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
