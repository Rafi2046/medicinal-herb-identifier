import 'package:flutter/material.dart';
import 'package:medical_herb/core/data/plant_data.dart';
import 'package:medical_herb/core/data/plant_database.dart';
import 'package:medical_herb/features/common_widgets/app_bar_widget.dart';
import 'package:medical_herb/features/screens/widgets/bad_sides_widget.dart';
import 'package:medical_herb/features/screens/widgets/botanical_info_widget.dart';
import 'package:medical_herb/features/screens/widgets/characteristics_widget.dart';
import 'package:medical_herb/features/screens/widgets/description_widget.dart';
import 'package:medical_herb/features/screens/widgets/good_sides_widget.dart';
import 'package:medical_herb/features/screens/widgets/medicinal_disclaimer_widget.dart';
import 'package:medical_herb/features/screens/widgets/medicinal_uses_widget.dart';

class HerbFullDetailsScreen extends StatelessWidget {
  final String? herbName;

  const HerbFullDetailsScreen({super.key, this.herbName});

  @override
  Widget build(BuildContext context) {
    final plant = getPlantByName(herbName);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const primaryGreen = Color(0xFF13C366);

    return DefaultTabController(
      length: 3, // We have 3 tabs
      child: Scaffold(
        backgroundColor: isDark ? const Color(0xFF0F172A) : Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- HEADER SECTION ---
            Container(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2F6EB), // Match your app bar background
              child: Column(
                children: [
                  AppBarWidget(
                    title: herbName ?? 'Herb Details',
                    subtitle: plant?.scientificName ?? 'Botanical Profile',
                    backArrow: true,
                  ),
                  // The Premium Tab Bar
                  TabBar(
                    indicatorColor: primaryGreen,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: primaryGreen,
                    unselectedLabelColor: isDark ? Colors.white54 : Colors.grey.shade600,
                    labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                    dividerColor: isDark ? Colors.white10 : Colors.grey.shade200,
                    tabs: const [
                      Tab(text: 'Overview'),
                      Tab(text: 'Benefits'),
                      Tab(text: 'Precautions'),
                    ],
                  ),
                ],
              ),
            ),

            // --- TAB CONTENT SECTION ---
            Expanded(
              child: TabBarView(
                children: [
                  // TAB 1: OVERVIEW
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DescriptionWidget(description: plant?.description ?? ''),
                        const SizedBox(height: 32),
                        CharacteristicsWidget(traits: _characteristicsFor(plant)),
                        const SizedBox(height: 32),
                        BotanicalInfoWidget(
                          scientificName: plant?.scientificName ?? '',
                          family: plant?.family ?? '',
                          region: plant?.region ?? '',
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),

                  // TAB 2: BENEFITS
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MedicinalUsesWidget(uses: plant?.medicinalUses ?? []),
                        const SizedBox(height: 32),
                        GoodSidesWidget(sides: plant?.goodSides ?? []),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),

                  // TAB 3: PRECAUTIONS
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BadSidesWidget(sides: plant?.badSides ?? []),
                        const SizedBox(height: 40),
                        MedicalDisclaimerWidget()
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> _characteristicsFor(PlantData? plant) {
    if (plant == null) return [];
    final traits = <String>[];
    if (plant.scientificName.isNotEmpty && !plant.scientificName.contains('To be')) {
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