import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/data/plant_images.dart';
import 'package:medical_herb/core/providers/history_provider.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class HistoryWidget extends StatelessWidget {
  final String? id;
  final String? herbName;
  final String? time;
  final String? confidence;
  final ScanSource? source;
  final VoidCallback? onDelete;
  final VoidCallback? onTap;

  const HistoryWidget({
    super.key,
    this.id,
    this.herbName,
    this.time,
    this.confidence,
    this.source,
    this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final borderColor = isDark ? const Color(0xFF334155) : AppColors.borderColor;
    final titleColor = isDark ? Colors.white : AppColors.herbName;

    final plantName = herbName ?? 'Unknown';

    return Dismissible(
      key: Key(id ?? herbName ?? UniqueKey().toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.delete, color: Colors.white, size: 30),
      ),
      onDismissed: (_) => onDelete?.call(),
      child: Card(
        color: cardColor,
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderColor),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ClipRRect(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: borderColor),
                    ),
                    child: Image(
                      image: AssetImage(imageForPlant(plantName)),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.s8),
                Expanded(
                  child: Column(
                    spacing: AppSpacing.s4,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        plantName,
                        style: AppTextStyles.confidenceName.copyWith(color: titleColor),
                      ),
                      Row(
                        children: [
                          Icon(
                            source == ScanSource.camera
                                ? Icons.camera_alt_rounded
                                : Icons.photo_library_rounded,
                            color: source == ScanSource.camera
                                ? const Color(0xFF27AE60)
                                : Colors.blue,
                            size: 16,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              '${time ?? '00:00 AM'}  ●  ${confidence ?? '0%'}',
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark ? Colors.white60 : AppColors.detailsText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppSpacing.s4),
                GestureDetector(
                  onTap: onDelete,
                  child: Image(
                    image: AssetImage(AppImages.deleteIcon),
                    width: 30,
                    height: 30,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
