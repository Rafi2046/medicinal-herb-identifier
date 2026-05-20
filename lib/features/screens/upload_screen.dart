import 'dart:io';
import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/common_widgets/app_bar_widget.dart';
import 'package:medical_herb/features/common_widgets/custom_button.dart';
import 'package:medical_herb/features/screens/widgets/confidence_score_card_widget.dart';

import 'herb_full_details_screen.dart';

class UploadScreen extends StatelessWidget {
  final String? imagePath;
  final PredictionResult? predictionResult;

  const UploadScreen({
    super.key,
    this.imagePath,
    this.predictionResult,
  });

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

    final primaryName = predictionResult?.primaryPrediction ?? 'Unknown';
    final confidence = predictionResult?.primaryConfidence ?? 0.0;
    final otherPredictions = predictionResult?.allPredictions ?? [];

    return Scaffold(
      appBar: const AppBarWidget(
        title: 'Details Screen',
        backArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (imagePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(imagePath!),
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              if (imagePath != null) const SizedBox(height: 12),
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
                              Text(
                                primaryName,
                                style: AppTextStyles.herbName.copyWith(color: titleColor),
                              ),
                              Text(
                                'Confidence: ${confidence.toStringAsFixed(1)}%',
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
                              '${confidence.toStringAsFixed(0)}%',
                              style: AppTextStyles.herbNameScientific.copyWith(
                                color: isDark ? Colors.white70 : null,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              ConfidenceScoreCardWidget(
                confidence: confidence,
                showDetailedMetrics: false,
              ),
              if (otherPredictions.length > 1) ...[
                SizedBox(height: 8),
                Card(
                  color: cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: BorderSide(color: borderColor),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Other Predictions',
                          style: AppTextStyles.confidenceName.copyWith(color: titleColor),
                        ),
                        const SizedBox(height: 12),
                        ...otherPredictions
                            .where((p) => p.className != predictionResult?.primaryPrediction)
                            .map((p) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.circle,
                                        size: 8,
                                        color: isDark ? Colors.white54 : AppColors.keyTraits,
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          p.className,
                                          style: AppTextStyles.keyTraits.copyWith(
                                            color: isDark ? Colors.white70 : AppColors.keyTraits,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${p.confidence.toStringAsFixed(1)}%',
                                        style: AppTextStyles.keyTraits.copyWith(
                                          color: isDark ? Colors.white54 : AppColors.desText,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                      ],
                    ),
                  ),
                ),
              ],
              SizedBox(height: 8),
              CustomButton(
                text: 'View Full Details',
                trailIcon: true,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HerbFullDetailsScreen(
                        herbName: primaryName,
                      ),
                    ),
                  );
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
                      onPressed: () => Navigator.pop(context),
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
      ),
    );
  }
}
