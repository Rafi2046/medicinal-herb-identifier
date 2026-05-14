import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

class WelcomeCardWidget extends StatelessWidget {
  const WelcomeCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppSpacing.h150,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppSpacing.br30),
        image: DecorationImage(
          image: AssetImage(AppImages.herbBanner),
          fit: BoxFit.cover,
        ),
        border: Border.all(
          color: Theme.of(context).colorScheme.surface,
          width: 1,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.p12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: AppSpacing.s4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Good Evening', style: AppTextStyles.welcomeText),
            Text(
              'What herb do you want to identify?',
              style: AppTextStyles.identifyText,
            ),
          ],
        ),
      ),
    );
  }
}
