import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
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
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  source == ScanSource.camera
                      ? Icons.camera_alt_rounded
                      : Icons.photo_library_rounded,
                  color: source == ScanSource.camera
                      ? const Color(0xFF27AE60)
                      : Colors.blue,
                  size: 22,
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        herbName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.confidenceName.copyWith(
                          color: titleColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            '${time ?? '00:00 AM'}',
                            style: TextStyle(
                              fontSize: 14,
                              color: isDark ? Colors.white60 : AppColors.detailsText,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '  ●  ${confidence ?? '0%'}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                GestureDetector(
                  onTap: onDelete,
                  child: Image(
                    image: AssetImage(AppImages.deleteIcon),
                    width: 40,
                    height: 40,
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
