import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class OptionWidget extends StatelessWidget {
  final VoidCallback? onPressed;
  final VoidCallback? onUploadPressed;

  const OptionWidget({super.key, this.onPressed, this.onUploadPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final cardBgColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final cardBorderColor =
    isDark ? const Color(0xFF334155) : AppColors.borderColors;

    return Row(
      children: [
        // ── Scan Herb card ──────────────────────────────────────────────
        Expanded(
          child: SizedBox(
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background image fills completely
                  Image(
                    image: AssetImage(AppImages.herbBanner),
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                  // Ripple effect on top
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: onPressed,
                      child: Column(
                        spacing: AppSpacing.s4,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage(AppImages.cameraIcon),
                            width: 48,
                            height: 48,
                          ),
                          Text('Scan Herb', style: AppTextStyles.scanText),
                          Text('Use camera', style: AppTextStyles.uploadCameraText),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        const SizedBox(width: AppSpacing.w12),

        // ── Upload Image card ───────────────────────────────────────────
        Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 150,
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: cardBorderColor, width: 1.2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: onUploadPressed,
                child: Column(
                  spacing: AppSpacing.s4,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(AppImages.uploadIcon),
                      width: 48,
                      height: 48,
                    ),
                    Text('Upload Image', style: AppTextStyles.uploadText),
                    Text('Form gallery',
                        style: AppTextStyles.uploadCameraText),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}