import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';
import 'package:medical_herb/features/screens/widgets/explore_screen_widget.dart';
import 'package:medical_herb/features/screens/widgets/tab_screen_header.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = BottomNavScreen.tabContentBottomInset(context);
    const herbCount = 10;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabScreenHeader(
              title: 'Explore Herbs',
              subtitle: '$herbCount herbs in database',
              actions: const [],
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset + 20),
                itemCount: herbCount,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
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
    );
  }
}
