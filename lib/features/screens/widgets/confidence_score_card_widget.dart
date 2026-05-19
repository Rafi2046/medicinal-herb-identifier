import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ConfidenceScoreCardWidget extends StatelessWidget {
  const ConfidenceScoreCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const Color primaryGreen = Color(0xFF13C366);
    const Color lightGreenBg = Color(0xFFE2F6EB);
    const Color greyText = Color(0xFF8E9E96);

    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final borderColor = isDark ? const Color(0xFF334155) : AppColors.borderColors;
    final pillColor = isDark ? const Color(0xFF334155) : AppColors.herbProgressColors;
    final titleColor = isDark ? Colors.white : AppColors.herbName;
    final subtitleColor = isDark ? Colors.white70 : AppColors.desText;
    final darkSubtitleColor = isDark ? Colors.white54 : const Color(0xFF8E9E96);
    final dividerColor = isDark ? const Color(0xFF334155) : const Color(0xFFE8ECE9);

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: borderColor),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Row(
              children: [
                Text('Confidence Score', style: AppTextStyles.confidenceName.copyWith(color: titleColor)),
                Spacer(),
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: pillColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Very High',
                      style: AppTextStyles.herbProgressScientific.copyWith(color: isDark ? Colors.white : null),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text('91%', style: AppTextStyles.progressName.copyWith(color: isDark ? Colors.white : null)),
              ],
            ),

            SizedBox(height: 12),
            LinearPercentIndicator(
              lineHeight: 14.0,
              percent: 0.75,
              backgroundColor: isDark ? const Color(0xFF334155) : lightGreenBg,
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
                      style: TextStyle(
                        color: isDark ? Colors.white54 : greyText,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            Divider(color: dividerColor, thickness: 1.5),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text('91%', style: AppTextStyles.progressName2.copyWith(color: isDark ? Colors.white : null)),
                    Text('Visual Match', style: AppTextStyles.detailsText2.copyWith(color: darkSubtitleColor)),
                  ],
                ),

                Column(
                  children: [
                    Text('91%', style: AppTextStyles.progressName2.copyWith(color: isDark ? Colors.white : null)),
                    Text('Leaf Shape', style: AppTextStyles.detailsText2.copyWith(color: darkSubtitleColor)),
                  ],
                ),
                Column(
                  children: [
                    Text('91%', style: AppTextStyles.progressName2.copyWith(color: isDark ? Colors.white : null)),
                    Text('Color Match', style: AppTextStyles.detailsText2.copyWith(color: darkSubtitleColor)),
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
