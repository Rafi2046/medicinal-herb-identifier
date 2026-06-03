import 'package:flutter/material.dart';
import 'package:medical_herb/core/data/plant_data.dart';
import 'package:medical_herb/features/screens/widgets/botanical_info_widget.dart';
import 'package:medical_herb/features/screens/widgets/characteristics_widget.dart';
import 'package:medical_herb/features/screens/widgets/description_widget.dart';

class OverviewTab extends StatelessWidget {
  final PlantData? plant;
  const OverviewTab({super.key, required this.plant});

  List<String> _characteristicsFor(PlantData? plant) {
    if (plant == null) return [];
    final traits = <String>[];
    if (plant.scientificName.isNotEmpty && !plant.scientificName.contains('To be')) traits.add(plant.scientificName);
    if (plant.family.isNotEmpty && !plant.family.contains('To be')) traits.add('${plant.family} family');
    if (plant.region.isNotEmpty && !plant.region.contains('To be')) traits.add('Origin: ${plant.region}');
    return traits;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DescriptionWidget(description: plant?.description ?? ''),
          const SizedBox(height: 28),
          CharacteristicsWidget(traits: _characteristicsFor(plant)),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: isDark ? Colors.white10 : const Color(0xFFE2E8F0)),
            ),
            child: BotanicalInfoWidget(
              scientificName: plant?.scientificName ?? '',
              family: plant?.family ?? '',
              region: plant?.region ?? '',
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}