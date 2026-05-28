import 'package:flutter/material.dart';
import 'package:medical_herb/core/data/plant_data.dart';
import 'package:medical_herb/core/data/plant_database.dart';
import 'package:medical_herb/features/common_widgets/app_bar_widget.dart';
import 'package:medical_herb/features/screens/widgets/bad_sides_widget.dart';
import 'package:medical_herb/features/screens/widgets/botanical_info_widget.dart';
import 'package:medical_herb/features/screens/widgets/characteristics_widget.dart';
import 'package:medical_herb/features/screens/widgets/description_widget.dart';
import 'package:medical_herb/features/screens/widgets/good_sides_widget.dart';
import 'package:medical_herb/features/screens/widgets/medicinal_uses_widget.dart';

class HerbFullDetailsScreen extends StatelessWidget {
  final String? herbName;

  const HerbFullDetailsScreen({super.key, this.herbName});

  @override
  Widget build(BuildContext context) {
    final plant = getPlantByName(herbName);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarWidget(
            title: herbName ?? 'Herb Details',
            subtitle: plant?.scientificName ?? 'Complete Botanical Information',
            backArrow: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DescriptionWidget(description: plant?.description ?? ''),
                  const SizedBox(height: 16),
                  MedicinalUsesWidget(uses: plant?.medicinalUses ?? []),
                  const SizedBox(height: 16),
                  GoodSidesWidget(sides: plant?.goodSides ?? []),
                  const SizedBox(height: 16),
                  BadSidesWidget(sides: plant?.badSides ?? []),
                  const SizedBox(height: 16),
                  CharacteristicsWidget(traits: _characteristicsFor(plant)),
                  const SizedBox(height: 16),
                  BotanicalInfoWidget(
                    scientificName: plant?.scientificName ?? '',
                    family: plant?.family ?? '',
                    region: plant?.region ?? '',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<String> _characteristicsFor(PlantData? plant) {
    if (plant == null) return [];
    final traits = <String>[];
    if (plant.scientificName.isNotEmpty &&
        !plant.scientificName.contains('To be')) {
      traits.add(plant.scientificName);
    }
    if (plant.family.isNotEmpty && !plant.family.contains('To be')) {
      traits.add('${plant.family} family');
    }
    if (plant.region.isNotEmpty && !plant.region.contains('To be')) {
      traits.add('Origin: ${plant.region}');
    }
    return traits;
  }
}
