import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class ExploreScreenWidget extends StatelessWidget {
  const ExploreScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.borderColor),
      ),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                spacing: AppSpacing.s8,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: AppColors.borderColor,
                        ),
                      ),
                      child: Image(
                        image: AssetImage(AppImages.exploreImage),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Column(
                    spacing: AppSpacing.s4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Moringa', style: AppTextStyles.confidenceName),
                      Text('Ocimum basilicum', style: AppTextStyles.desText),
                    ],
                  ),

                  Expanded(child: Icon(Icons.arrow_forward_ios, size: 16,color: AppColors.borderColor,)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
