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
    return Dismissible(
      key: Key(id ?? ''),
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
      color: AppColors.white,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.borderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image(image: AssetImage(imagePath ?? ''), width: 8, height: 8),

            const SizedBox(width: 12),

            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: AssetImage(imagePath2 ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(herbName ?? '', style: AppTextStyles.confidenceName),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Image(
                        image: AssetImage(imagePath3 ?? ''),
                        width: 18,
                        height: 18,
                        color: AppColors.green,
                      ),

                      const SizedBox(width: 6),

                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: '${time ?? '00:00 AM'}  ●  ',
                              style: TextStyle(
                                color: AppColors.detailsText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: confidence ?? '0%',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
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
    );
  }
}
