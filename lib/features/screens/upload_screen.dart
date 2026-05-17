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
    return Scaffold(
      appBar: AppBarWidget(title: 'Details Screen'),
      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: AppColors.borderColors),
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
                              style: AppTextStyles.detailsText,
                            ),
                            Text('Akando ', style: AppTextStyles.herbName),
                            Text(
                              'Origanum vulgare ',
                              style: AppTextStyles.detailsTextT,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 45,
                        decoration: BoxDecoration(
                          color: AppColors.herbColorsName,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Text(
                            'Lamiaceae',
                            style: AppTextStyles.herbNameScientific,
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
                    backgroundColor: Colors.white,
                    showBorder: true,
                    borderColor: AppColors.borderColors,
                    text: 'Favorite',
                    textColor: AppColors.herbScientific,
                    onPressed: () {},
                    leading: Image.asset(
                      AppImages.favorites,
                      height: AppSpacing.h16,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                Expanded(
                  child: CustomButton(
                    backgroundColor: Colors.white,
                    showBorder: true,
                    borderColor: AppColors.borderColors,
                    text: 'Scan Again',
                    textColor: AppColors.herbScientific,
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
