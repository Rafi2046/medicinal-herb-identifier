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
    final borderColor = isDark
        ? const Color(0xFF334155)
        : AppColors.borderColors;
    final titleColor = isDark ? Colors.white : AppColors.herbName;
    final subtitleColor = isDark ? Colors.white70 : AppColors.desText;
    final _ = isDark
        ? const Color(0xFF4ADE80)
        : const Color(0xFF27AE60);

    final secondaryColor = const Color(0xFFF28A21);

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
                Text(
                  'Top Predictions',
                  style: AppTextStyles.confidenceName.copyWith(
                    color: titleColor,
                  ),
                ),
                Text(
                  'Total: $totalCount',
                  style: AppTextStyles.detailsText.copyWith(
                    color: subtitleColor,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...predictions.map((p) {
              final isZeroToOne = p.confidence <= 1.0;
              final pConfidence = (isZeroToOne ? p.confidence * 100 : p.confidence).clamp(0.0, 100.0);
              final progressValue = (isZeroToOne ? p.confidence : p.confidence / 100).clamp(0.0, 1.0);
              if (pConfidence < threshold) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          size: 8,
                          color: AppColors.progressColor,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            p.className,
                            style: AppTextStyles.keyTraits.copyWith(
                              color: isDark
                                  ? Colors.white70
                                  : AppColors.keyTraits,
                            ),
                          ),
                        ),
                        Text(
                          '${pConfidence.toStringAsFixed(1)}%',
                          style: AppTextStyles.keyTraits.copyWith(
                            color: isDark ? Colors.white54 : AppColors.desText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progressValue.clamp(0.0, 1.0),
                        minHeight: 6,
                        backgroundColor: secondaryColor.withValues(alpha: 0.15),
                        valueColor: AlwaysStoppedAnimation<Color>(
                          secondaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            if (isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
