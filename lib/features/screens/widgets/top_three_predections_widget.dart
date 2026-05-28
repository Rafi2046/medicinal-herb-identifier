import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
class TopThreePredictionsWidget extends StatelessWidget {
  final List<Prediction> predictions;
  final double threshold;
  final int totalCount;
  final bool isLoading;

  const TopThreePredictionsWidget({
    super.key,
    required this.predictions,
    required this.threshold,
    required this.totalCount,
    required this.isLoading,
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
                Text('Top Predictions', style: AppTextStyles.confidenceName.copyWith(color: titleColor)),
                Text('Total: $totalCount', style: AppTextStyles.detailsText.copyWith(color: subtitleColor, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 12),
            ...predictions.map((p) {
              final pConfidence = p.confidence * 100;
              if (pConfidence < threshold) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    Icon(Icons.circle, size: 8, color: isDark ? Colors.white54 : AppColors.keyTraits),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        p.className,
                        style: AppTextStyles.keyTraits.copyWith(color: isDark ? Colors.white70 : AppColors.keyTraits),
                      ),
                    ),
                    Text(
                      '${pConfidence.toStringAsFixed(1)}%',
                      style: AppTextStyles.keyTraits.copyWith(color: isDark ? Colors.white54 : AppColors.desText, fontWeight: FontWeight.w600),
                    ),
                    if (predictions.indexOf(p) == 0)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: accentColor.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(4)),
                        child: Text('TOP', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: accentColor)),
                      ),
                  ],
                ),
              );
            }),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))),
              ),
          ],
        ),
      ),
    );
  }
}
