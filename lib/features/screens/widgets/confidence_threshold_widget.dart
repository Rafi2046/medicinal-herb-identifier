import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class ConfidenceThresholdWidget extends StatelessWidget {
  final double threshold;
  final ValueChanged<double> onChanged;
  final ValueChanged<double> onChangeEnd;

  const ConfidenceThresholdWidget({
    super.key,
    required this.threshold,
    required this.onChanged,
    required this.onChangeEnd,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final borderColor = isDark ? const Color(0xFF334155) : AppColors.borderColors;
    final titleColor = isDark ? Colors.white : AppColors.herbName;
    final subtitleColor = isDark ? Colors.white70 : AppColors.desText;
    final accentColor = isDark ? const Color(0xFF4ADE80) : const Color(0xFF27AE60);

    return Card(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Confidence Threshold', style: AppTextStyles.confidenceName.copyWith(color: titleColor)),
                Text('${threshold.toStringAsFixed(0)}%', style: AppTextStyles.herbNameScientific.copyWith(color: accentColor)),
              ],
            ),
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: accentColor,
                thumbColor: accentColor,
                inactiveTrackColor: borderColor,
                overlayColor: accentColor.withValues(alpha: 0.12),
              ),
              child: Slider(
                value: threshold,
                min: 0,
                max: 100,
                divisions: 100,
                onChanged: onChanged,
                onChangeEnd: onChangeEnd,
              ),
            ),
            Text(
              'Adjust threshold and the API will re-evaluate',
              style: AppTextStyles.detailsText.copyWith(color: subtitleColor, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
