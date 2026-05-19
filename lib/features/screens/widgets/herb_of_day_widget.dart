import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

class HerbOfDayWidget extends StatelessWidget {
  const HerbOfDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: Stack(
        children: [
          Image.asset(
            AppImages.herbOfDay,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
          ),

          Positioned(
            left: 10,
            bottom: 50,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mint', style: AppTextStyles.herbDay),

                const SizedBox(height: 4),

                Text('Mentha', style: AppTextStyles.herbDaySub),

                const SizedBox(height: 8),

                Text(
                  'Italian cuisine (pesto, tomato dishes)',
                  style: AppTextStyles.herbDaySub2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
