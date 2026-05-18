import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/features/screens/widgets/explore_screen_widget.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return ExploreScreenWidget(
            herbName: 'Moringa',
            scientificName: 'Ocimum basilicum',
            imagePath: AppImages.exploreImage,
          );
        },
      ),
    );
  }
}