import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/home/presentation/widgets/option_widget.dart';
import 'package:medical_herb/features/home/presentation/widgets/quick_access_widget.dart';
import 'package:medical_herb/features/home/presentation/widgets/welcome_card.dart';
import 'package:medical_herb/features/home/presentation/widgets/featured_herbs_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: AppColors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset('assets/app_logo/logo2.webp', fit: BoxFit.cover),
        ),

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MediLeaf', style: AppTextStyles.appBar),
            Text(
              'Medicinal Herb Identifier',
              style: AppTextStyles.appBarSubTile,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const WelcomeCard(),
            const SizedBox(height: AppSpacing.s8),
            Text('CHOOSE AN OPTION', style: AppTextStyles.optionText),
            const SizedBox(height: AppSpacing.s8),
            const OptionWidget(),
            const SizedBox(height: AppSpacing.s12),
            Text('QUICK ACCESS', style: AppTextStyles.optionText),
            const SizedBox(height: AppSpacing.s8),
            const QuickAccessWidget(),
            const SizedBox(height: AppSpacing.s16),
            FeaturedHerbsSection()
          ],
        ),
      ),
    );
  }
}
