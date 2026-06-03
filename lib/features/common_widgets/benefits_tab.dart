import 'package:flutter/material.dart';
import 'package:medical_herb/core/data/plant_data.dart';
import 'package:medical_herb/features/screens/widgets/good_sides_widget.dart';
import 'package:medical_herb/features/screens/widgets/medicinal_uses_widget.dart';

class BenefitsTab extends StatelessWidget {
  final PlantData? plant;
  const BenefitsTab({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
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
}