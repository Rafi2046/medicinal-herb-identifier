import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ConfidenceScoreCardWidget extends StatelessWidget {
  const ConfidenceScoreCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    const Color darkGreenText = Color(0xFF0F3D26);
    const Color primaryGreen = Color(0xFF13C366);
    const Color lightGreenBg = Color(0xFFE2F6EB);
    const Color greyText = Color(0xFF8E9E96);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: AppColors.borderColors),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Row(
              children: [
                Text('Confidence Score', style: AppTextStyles.confidenceName),
                Spacer(),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: AppColors.herbProgressColors,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Very High',
                      style: AppTextStyles.herbProgressScientific,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text('91%', style: AppTextStyles.progressName),
              ],
            ),

            SizedBox(height: 12),
            LinearPercentIndicator(
              lineHeight: 14.0,
              percent: 0.75,
              backgroundColor: lightGreenBg,
              progressColor: primaryGreen,

              barRadius: const Radius.circular(20),
              padding: EdgeInsets.zero,
              animation: true,
              animationDuration: 1000,
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["0%", "25%", "50%", "75%", "100%"]
                  .map(
                    (text) => Text(
                      text,
                      style: const TextStyle(
                        color: greyText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Divider(color: Color(0xFFE8ECE9), thickness: 1.5),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('91%', style: AppTextStyles.progressName2),
                    Text('Visual Match', style: AppTextStyles.detailsText2),
                  ],
                ),

                Column(
                  children: [
                    Text('91%', style: AppTextStyles.progressName2),
                    Text('Leaf Shape', style: AppTextStyles.detailsText2),
                  ],
                ),
                Column(
                  children: [
                    Text('91%', style: AppTextStyles.progressName2),
                    Text('Color Match', style: AppTextStyles.detailsText2),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
