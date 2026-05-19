import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class HistoryWidget extends StatelessWidget {
  final String? id;
  final String? herbName;
  final String? imagePath;
  final String? imagePath2;
  final String? imagePath3;
  final String? time;
  final String? confidence;
  final VoidCallback? onDelete;

  const HistoryWidget({
    super.key,
    this.id,
    this.herbName,
    this.imagePath,
    this.imagePath2,
    this.imagePath3,
    this.time,
    this.confidence,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;

    final borderColor = isDark
        ? const Color(0xFF334155)
        : AppColors.borderColor;

    final textColor = isDark ? Colors.white : Colors.black;

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

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: imagePath != null
                      ? DecorationImage(
                          image: AssetImage(imagePath!),
                          fit: BoxFit.cover,
                        )
                      : null,
                  color: Colors.grey.shade200,
                ),
              ),

              const SizedBox(width: 14),

              /// Text Section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    /// Herb Name
                    Text(
                      herbName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.confidenceName.copyWith(
                        color: titleColor,
                      ),
                    ),

                    const SizedBox(height: 8),

                    /// Time + Confidence
                    Row(
                      children: [
                        Image(
                          image: AssetImage(imagePath3 ?? AppImages.greenDot),
                          width: 18,
                          height: 18,
                          color: AppColors.green,
                        ),

                        const SizedBox(width: 6),

                        Expanded(
                          child: RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              style: TextStyle(fontSize: 14, color: textColor),
                              children: [
                                TextSpan(
                                  text: '${time ?? '00:00 AM'}  ●  ',
                                  style: TextStyle(
                                    color: isDark
                                        ? Colors.white60
                                        : AppColors.detailsText,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                TextSpan(
                                  text: confidence ?? '0%',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              /// Delete Button
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
    );
  }
}
