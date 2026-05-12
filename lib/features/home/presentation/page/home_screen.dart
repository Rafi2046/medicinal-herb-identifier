import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/home/presentation/widgets/option_widget.dart';
import 'package:medical_herb/features/home/presentation/widgets/quick_access_widget.dart';
import 'package:medical_herb/features/home/presentation/widgets/welcome_card.dart';
import 'package:medical_herb/features/home/presentation/widgets/featured_herbs_section.dart';

class HomeScreen extends StatelessWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;

  const HomeScreen({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset('assets/app_logo/logo2.webp', fit: BoxFit.cover),
        ),
        actions: [
          IconButton(
            icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: isDark ? Colors.white : Colors.black),
            onPressed: onThemeToggle,
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('MediLeaf', style: AppTextStyles.appBar.copyWith(color: isDark ? Colors.white : Colors.black)),
            Text(
              'Medicinal Herb Identifier',
              style: AppTextStyles.appBarSubTile?.copyWith(color: isDark ? Colors.grey[400] : Colors.grey[600]),
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
