import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/screens/history_screen.dart';

import 'package:medical_herb/features/screens/upload_screen.dart';
import 'package:medical_herb/features/screens/widgets/featured_herbs_section.dart';
import 'package:medical_herb/features/screens/widgets/herb_of_day_widget.dart';
import 'package:medical_herb/features/screens/widgets/option_widget.dart';
import 'package:medical_herb/features/screens/widgets/quick_access_widget.dart';
import 'package:medical_herb/features/screens/widgets/welcome_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom + 64 + 28;
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20, 20, 20, bottomInset + 20),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const WelcomeCardWidget(),
            const SizedBox(height: AppSpacing.h16),
            Text('CHOOSE AN OPTION', style: AppTextStyles.heading4),
            OptionWidget(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UploadScreen()),
                );
              },
            ),
            Text('QUICK ACCESS', style: AppTextStyles.heading4),
            const SizedBox(height: AppSpacing.h4),
            QuickAccessWidget(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HistoryScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: AppSpacing.h24),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('HERB OF THE DAY', style: AppTextStyles.heading4),
                    const SizedBox(width: 8),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: AppColors.herbProgressColors,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Daily Pick',
                          style: AppTextStyles.herbProgressScientific,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                HerbOfDayWidget(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
