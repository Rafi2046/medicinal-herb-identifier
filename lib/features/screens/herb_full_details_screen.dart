import 'package:flutter/material.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/common_widgets/app_bar_widget.dart';
import 'package:medical_herb/features/screens/widgets/botanical_info_widget.dart' show BotanicalInfoWidget;
import 'package:medical_herb/features/screens/widgets/characteristics_widget.dart';
import 'package:medical_herb/features/screens/widgets/description_widget.dart';
import 'package:medical_herb/features/screens/widgets/medicinal_uses_widget.dart';

class HerbFullDetailsScreen extends StatelessWidget {
  const HerbFullDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const AppBarWidget(
            title: 'Herb Details',
            subtitle: 'Complete Botanical Information',
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  DescriptionWidget(),
                  SizedBox(height: 16),
                  MedicinalUsesWidget(),
                  SizedBox(height: 16),
                  CharacteristicsWidget(),
                  SizedBox(height: 16),
                  BotanicalInfoWidget()

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
