import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          height: AppSpacing.h130,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(AppImages.cardImage, fit: BoxFit.cover),
              ),

              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Good Evening', style: AppTextStyles.subtitle12),
                    Text(
                      'What herb do you want to identify?',
                      style: AppTextStyles.title,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
