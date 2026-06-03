import 'package:flutter/material.dart';
import 'package:medical_herb/core/data/plant_data.dart';
import 'package:medical_herb/features/screens/widgets/bad_sides_widget.dart';
import 'package:medical_herb/features/screens/widgets/medicinal_disclaimer_widget.dart';

class PrecautionsTab extends StatelessWidget {
  final PlantData? plant;
  const PrecautionsTab({super.key, required this.plant});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BadSidesWidget(sides: plant?.badSides ?? []),
          const SizedBox(height: 16),
          const MedicalDisclaimerWidget(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}