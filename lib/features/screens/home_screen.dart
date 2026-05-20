import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/network/api_services.dart';
import 'package:medical_herb/core/network/prediction_model.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/main/presentation/widgets/main_app_top_bar.dart';
import 'package:medical_herb/features/screens/history_screen.dart';
import 'package:medical_herb/features/screens/upload_screen.dart';
import 'package:medical_herb/features/screens/widgets/herb_of_day_widget.dart';
import 'package:medical_herb/features/screens/widgets/option_widget.dart';
import 'package:medical_herb/features/screens/widgets/quick_access_widget.dart';
import 'package:medical_herb/features/screens/widgets/welcome_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _scanHerb() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    await _predictAndNavigate(File(image.path));
  }

  Future<void> _uploadImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    await _predictAndNavigate(File(image.path));
  }

  Future<void> _predictAndNavigate(File imageFile) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final result = await ApiService.uploadAndPredict(imageFile);

    if (!mounted) return;
    Navigator.pop(context);

    if (result != null) {
      final predictionResult = PredictionResult.fromJson(result);
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => UploadScreen(
            imagePath: imageFile.path,
            predictionResult: predictionResult,
          ),
        ),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to identify plant. Please try again.')),
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
                onPressed: _scanHerb,
                onUploadPressed: _uploadImage,
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
