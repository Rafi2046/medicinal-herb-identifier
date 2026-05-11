import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

class OptionWidget extends StatelessWidget {
  const OptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.containerImage),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
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

        const SizedBox(width: AppSpacing.w12),

        Expanded(
          child: Container(
            height: 155,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.containerWhite),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(AppImages.uploadIcon),
                  width: 48,
                  height: 48,
                ),
                Text('Upload', style: AppTextStyles.uploadText),
                Text('From gallery', style: AppTextStyles.uploadText),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
