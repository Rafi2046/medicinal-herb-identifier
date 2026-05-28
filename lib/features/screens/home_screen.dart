import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:medical_herb/core/providers/history_provider.dart';
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

  void _handleResult(
    BuildContext context,
    Map<String, dynamic> result,
    ScanSource source,
  ) {
    if (result['success'] == true) {
      final imagePath = result['imagePath'] as String;
      final predictionResult = result['predictionResult'] as PredictionResult;
      final herbName = predictionResult.primaryPrediction;
      final confidence = predictionResult.primaryConfidence;
      context.read<HistoryProvider>().addScan(herbName, confidence, source);
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
      final message =
          result['message'] as String? ?? 'Failed to identify plant.';
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> _pickAndProcess(BuildContext context, ImageSource source) async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: source);
    if (image == null || !context.mounted) return;

    final provider = context.read<ScanProvider>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    final result = await provider.processPickedImage(image.path);

    if (!context.mounted) return;
    Navigator.pop(context);

    final scanSource =
        source == ImageSource.camera ? ScanSource.camera : ScanSource.gallery;
    _handleResult(context, result, scanSource);
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
                onPressed: () => _pickAndProcess(context, ImageSource.camera),
                onUploadPressed: () =>
                    _pickAndProcess(context, ImageSource.gallery),
              ),
              Text('QUICK ACCESS', style: AppTextStyles.heading4),
              const SizedBox(height: AppSpacing.h4),
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
