import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/providers/scan_provider.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/main/presentation/widgets/main_app_top_bar.dart';
import 'package:medical_herb/features/screens/history_screen.dart';
import 'package:medical_herb/features/screens/upload_screen.dart';
import 'package:medical_herb/features/screens/widgets/herb_of_day_widget.dart';
import 'package:medical_herb/features/screens/widgets/option_widget.dart';
import 'package:medical_herb/features/screens/widgets/quick_access_widget.dart';
import 'package:medical_herb/features/screens/widgets/welcome_card_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _scanHerb(BuildContext context) async {
    final provider = context.read<ScanProvider>();
    final result = await provider.processImage(ImageSource.camera);
    if (!context.mounted || result == null) return;
    _handleResult(context, provider, result);
  }

  Future<void> _uploadImage(BuildContext context) async {
    final provider = context.read<ScanProvider>();
    final result = await provider.processImage(ImageSource.gallery);
    if (!context.mounted || result == null) return;
    _handleResult(context, provider, result);
  }

  void _handleResult(BuildContext context, ScanProvider provider, Map<String, dynamic> result) {
    if (result['success'] == true) {
      final imagePath = result['imagePath'] as String;
      final predictionResult = result['predictionResult'];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UploadScreen(
            imagePath: imagePath,
            predictionResult: predictionResult,
          ),
        ),
      );
    } else {
      final message = result['message'] as String? ?? 'Failed to identify plant.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom + 64 + 28;
    return Scaffold(
      appBar: const MainAppTopBar(),
      body: SafeArea(
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
                onPressed: () => _scanHerb(context),
                onUploadPressed: () => _uploadImage(context),
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
      ),
    );
  }
}
