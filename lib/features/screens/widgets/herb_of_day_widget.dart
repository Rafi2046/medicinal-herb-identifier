import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/data/plant_database.dart';
import 'package:medical_herb/core/data/plant_images.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/screens/herb_full_details_screen.dart';

class HerbOfDayWidget extends StatelessWidget {
  const HerbOfDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final herbs = plantDatabase.keys.toList();
    final dayOfYear = DateTime.now().difference(
      DateTime(DateTime.now().year, 1, 1),
    ).inDays;
    final index = dayOfYear % herbs.length;
    final herbName = herbs[index];
    final plant = plantDatabase[herbName];

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HerbFullDetailsScreen(herbName: herbName),
        ),
      ),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: Stack(
        children: [
          Image.asset(
            imageForPlant(herbName),
            fit: BoxFit.cover,
            width: double.infinity,
            height: 200,
            errorBuilder: (context, _, _) => Container(
              height: 200,
              color: Colors.green.shade100,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            bottom: 50,
            right: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(herbName, style: AppTextStyles.herbDay),
                const SizedBox(height: 4),
                Text(
                  plant?.scientificName ?? '',
                  style: AppTextStyles.herbDaySub.copyWith(color: AppColors.secondaryColor),
                ),
                const SizedBox(height: 8),
                if (plant != null && plant.description.isNotEmpty)
                  Text(
                    plant.description.length > 60
                        ? '${plant.description.substring(0, 60)}...'
                        : plant.description,
                    style: AppTextStyles.herbDaySub2,
                  ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
