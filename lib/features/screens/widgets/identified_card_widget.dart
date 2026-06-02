import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class IdentifiedCardWidget extends StatelessWidget {
  final String? primaryName;
  final double? confidence;

  const IdentifiedCardWidget({super.key, this.confidence, this.primaryName});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final borderColor = isDark
        ? const Color(0xFF334155)
        : AppColors.borderColors;
    final pillColor = isDark
        ? const Color(0xFF334155)
        : AppColors.herbColorsName;
    final titleColor = isDark ? Colors.white : AppColors.herbName;
    final subtitleColor = isDark ? Colors.white70 : AppColors.desText;

    return Card(
      color: cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: borderColor),
      ),
      child: SizedBox(
        height: 145,
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
                      style: AppTextStyles.detailsText.copyWith(
                        color: subtitleColor,
                      ),
                    ),
                    Text(
                      primaryName!,
                      style: AppTextStyles.herbName.copyWith(color: titleColor),
                    ),
                    Text(
                      'Confidence: ${confidence?.toStringAsFixed(1)}%',
                      style: AppTextStyles.detailsTextT.copyWith(
                        color: subtitleColor,
                      ),
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
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      '${confidence?.toStringAsFixed(0)}%',
                      style: AppTextStyles.herbNameScientific.copyWith(
                        color: isDark ? Colors.white70 : null,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
