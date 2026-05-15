import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

import 'package:medical_herb/features/screens/bottom_nav_screen.dart';
import 'package:medical_herb/features/screens/widgets/featured_herbs_section.dart';
import 'package:medical_herb/features/screens/widgets/option_widget.dart';
import 'package:medical_herb/features/screens/widgets/quick_access_widget.dart';
import 'package:medical_herb/features/screens/widgets/welcome_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.w16,
        AppSpacing.h8,
        AppSpacing.w16,
        16 + BottomNavScreen.tabContentBottomInset(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const WelcomeCardWidget(),
          const SizedBox(height: AppSpacing.h16),
          Text('CHOOSE AN OPTION', style: AppTextStyles.heading4),

          const OptionWidget(),
          const SizedBox(height: AppSpacing.h16),
          Text('QUICK ACCESS', style: AppTextStyles.heading4),
          const QuickAccessWidget(),
          const SizedBox(height: AppSpacing.h24),
          const FeaturedHerbsSection(),
        ],
      ),
    );
  }
}
