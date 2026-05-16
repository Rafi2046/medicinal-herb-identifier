import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

class OptionWidget extends StatelessWidget {
  final VoidCallback? onPressed;

  const OptionWidget({super.key, this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: onPressed,
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.herbBanner),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                ),
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
          ),
        ),

        const SizedBox(width: AppSpacing.w12),

        Expanded(
          child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: SizedBox(
              height: 150,
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
                  Text('Form gallery', style: AppTextStyles.uploadCameraText),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
