import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';

import 'package:medical_herb/features/screens/bottom_nav_screen.dart';
import 'package:medical_herb/features/screens/widgets/featured_herbs_section.dart';
import 'package:medical_herb/features/screens/widgets/option_widget.dart';
import 'package:medical_herb/features/screens/widgets/quick_access_widget.dart';
import 'package:medical_herb/features/screens/widgets/welcome_card.dart';

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
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WelcomeCard(),
          SizedBox(height: AppSpacing.h16),
          QuickAccessWidget(),
          SizedBox(height: AppSpacing.h16),
          OptionWidget(),
          SizedBox(height: AppSpacing.h24),
          FeaturedHerbsSection(),
        ],
      ),
    );
  }
}
