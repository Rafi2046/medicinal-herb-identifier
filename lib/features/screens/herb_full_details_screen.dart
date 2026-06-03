import 'package:flutter/material.dart';
import 'package:medical_herb/core/data/plant_database.dart';
import 'package:medical_herb/features/common_widgets/app_bar_widget.dart';
import 'package:medical_herb/features/common_widgets/benefits_tab.dart';
import 'package:medical_herb/features/common_widgets/custom_tab_bar_widget.dart';
import 'package:medical_herb/features/common_widgets/overview_tab.dart';
import 'package:medical_herb/features/common_widgets/precautions_tab.dart';

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

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF1F5F9),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : Colors.white,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
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
                const SizedBox(height: 12),
                CustomTabBarWidget(tabController: _tabController, tabs: _tabs),
              ],
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                    blurRadius: 12,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: [
                  OverviewTab(plant: plant),
                  BenefitsTab(plant: plant),
                  PrecautionsTab(plant: plant),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
