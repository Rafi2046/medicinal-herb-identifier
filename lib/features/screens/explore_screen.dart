import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/features/screens/widgets/explore_screen_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Explore Herbs', style: AppTextStyles.confidenceName),

              Expanded(
                child: ListView.separated(
                  itemCount: 10,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return ExploreScreenWidget(
                      herbName: 'Moringa',
                      scientificName: 'Moringa oleifera',
                      imagePath: AppImages.exploreImage,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
