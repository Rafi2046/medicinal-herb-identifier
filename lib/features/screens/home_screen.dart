import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/features/common_widgets/scan_helper.dart';
import 'package:medical_herb/features/main/presentation/widgets/main_app_top_bar.dart';
import 'package:medical_herb/features/screens/history_screen.dart';
import 'package:medical_herb/features/screens/widgets/herb_of_day_widget.dart';
import 'package:medical_herb/features/screens/widgets/option_widget.dart';
import 'package:medical_herb/features/screens/widgets/quick_access_widget.dart';
import 'package:medical_herb/features/screens/widgets/welcome_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom + 64 + 28;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0F172A)
          : const Color(0xFFF8FAFC),
      appBar: const MainAppTopBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 20, 20, bottomInset + 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const WelcomeCardWidget(),

              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'CHOOSE AN OPTION',
                  style: AppTextStyles.option,
                ),
              ),

              OptionWidget(
                onPressed: () =>
                    ScanHelper.pickAndProcess(context, ImageSource.camera),
                onUploadPressed: () =>
                    ScanHelper.pickAndProcess(context, ImageSource.gallery),
              ),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'QUICK ACCESS',
                  style: AppTextStyles.option,
                ),
              ),
              QuickAccessWidget(
                onHistoryPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  'HERB OF THE DAY',
                  style: AppTextStyles.option,
                ),
              ),
              const HerbOfDayWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
