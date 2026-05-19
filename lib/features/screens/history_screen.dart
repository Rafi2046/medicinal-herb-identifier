import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/features/screens/widgets/history_widget.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('TODAY', style: AppTextStyles.heading4),
              HistoryWidget(
                imagePath: AppImages.greenDot,
                herbName: 'Mint',
                imagePath2: 'assets/background_image/joba.webp',
                imagePath3: AppImages.upload,
              ),
              HistoryWidget(
                imagePath: AppImages.yellowDot,
                herbName: 'Mint',
                imagePath2: 'assets/background_image/joba.webp',
                imagePath3: AppImages.upload,
              ),
              Text('YESTERDAY', style: AppTextStyles.heading4),
              HistoryWidget(
                imagePath: AppImages.greenDot,
                herbName: 'Mint',
                imagePath2: 'assets/background_image/joba.webp',
                imagePath3: AppImages.camara,
              ),
              HistoryWidget(
                imagePath: AppImages.yellowDot,
                herbName: 'Mint',
                imagePath2: 'assets/background_image/joba.webp',
                imagePath3: AppImages.camara,
              ),
              Text('THIS WEEK', style: AppTextStyles.heading4),
              HistoryWidget(
                imagePath: AppImages.greenDot,
                herbName: 'Mint',
                imagePath2: 'assets/background_image/joba.webp',
                imagePath3: AppImages.upload,
              ),
              HistoryWidget(
                imagePath: AppImages.yellowDot,
                herbName: 'Mint',
                imagePath2: 'assets/background_image/joba.webp',
                imagePath3: AppImages.camara,
              ),
              HistoryWidget(
                imagePath: AppImages.yellowDot,
                herbName: 'Mint',
                imagePath2: 'assets/background_image/joba.webp',
                imagePath3: AppImages.upload,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
