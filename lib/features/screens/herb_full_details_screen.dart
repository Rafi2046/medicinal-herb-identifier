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

class HerbFullDetailsScreen extends StatefulWidget {
  final String? herbName;

  const HerbFullDetailsScreen({super.key, this.herbName});

  @override
  State<HerbFullDetailsScreen> createState() => _HerbFullDetailsScreenState();
}

class _HerbFullDetailsScreenState extends State<HerbFullDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final _tabs = const ['Overview', 'Benefits', 'Precautions'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final plant = getPlantByName(widget.herbName);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    const green = Color(0xFF13C366);

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF8FAFC),
      body: Column(
        children: [
          _buildHeader(plant, isDark, green),
          Expanded(child: _buildTabContent(plant, isDark)),
        ],
      ),
    );
  }

  Widget _buildHeader(PlantData? plant, bool isDark, Color green) {
    return Container(
      decoration: BoxDecoration(

        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          AppBarWidget(
            title: widget.herbName ?? 'Herb Details',
            subtitle: plant?.scientificName ?? 'Botanical Profile',
            backArrow: true,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 16),
            child: ListenableBuilder(
              listenable: _tabController,
              builder: (_, _) {
                return Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(

                    color: isDark
                        ? const Color(0xFF0F172A)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: List.generate(_tabs.length, (i) {
                      final selected = _tabController.index == i;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => _tabController.animateTo(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            padding: const EdgeInsets.symmetric(vertical: 11),
                            decoration: BoxDecoration(
                              color: selected ? green : Colors.transparent,
                              borderRadius: BorderRadius.circular(11),
                              boxShadow: selected
                                  ? [
                                      BoxShadow(
                                        color: green.withValues(alpha: 0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 2),
                                      ),
                                    ]
                                  : null,
                            ),
                            child: Text(
                              _tabs[i],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: selected
                                    ? Colors.white
                                    : (isDark
                                          ? Colors.white54
                                          : const Color(0xFF94A3B8)),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabContent(PlantData? plant, bool isDark) {
    return TabBarView(
      controller: _tabController,
      physics: const BouncingScrollPhysics(),
      children: [
        _buildOverviewTab(plant, isDark),
        _buildBenefitsTab(plant, isDark),
        _buildPrecautionsTab(plant, isDark),
      ],
    );
  }

  Widget _buildOverviewTab(PlantData? plant, bool isDark) {
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
          _buildInfoCard(
            isDark: isDark,
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

  Widget _buildBenefitsTab(PlantData? plant, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MedicinalUsesWidget(uses: plant?.medicinalUses ?? []),
          const SizedBox(height: 28),
          GoodSidesWidget(sides: plant?.goodSides ?? []),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildPrecautionsTab(PlantData? plant, bool isDark) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BadSidesWidget(sides: plant?.badSides ?? []),
          const SizedBox(height: 28),
          MedicalDisclaimerWidget(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildInfoCard({required bool isDark, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
        ),
      ),
      child: child,
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
