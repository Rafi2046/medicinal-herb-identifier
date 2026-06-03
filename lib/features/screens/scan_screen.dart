

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/providers/scan_provider.dart';
import 'package:medical_herb/features/common_widgets/custom_button.dart';
import 'package:medical_herb/features/common_widgets/toast_utils.dart';
import 'package:medical_herb/features/screens/upload_screen.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});


  Future<void> _handleScan(BuildContext context, ImageSource source) async {
    final provider = context.read<ScanProvider>();
    final result = await provider.processImage(source);

    if (context.mounted) {
      if (result['success'] == true) {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UploadScreen(
              imagePath: result['imagePath'],
              predictionResult: result['predictionResult'],
            ),
          ),
        );
      } else {

        ToastUtils.error(result['message']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = BottomNavScreen.tabContentBottomInset(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;


    final isLoading = context.watch<ScanProvider>().isLoading;

    return ColoredBox(
      color: isDark ? const Color(0xFF0F172A) : const Color(0xFFF5F2F8),
      child: Padding(
        padding: EdgeInsets.only(bottom: p),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  size: 80,
                  color: isDark ? const Color(0xFF4b7c60) : const Color(0xFF2D9E61),
                ),
                const SizedBox(height: AppSpacing.h16),
                Text('Scan Herb', style: AppTextStyles.heading2.copyWith(
                  color: isDark ? Colors.white : null,
                )),
                const SizedBox(height: AppSpacing.h8),
                Text(
                  'Point the camera at a herb to identify it.',
                  style: AppTextStyles.body3.copyWith(
                    color: isDark ? Colors.white70 : null,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.h32),


                isLoading
                    ? const CircularProgressIndicator(color: Color(0xFF2D9E61))
                    : CustomButton(
                  text: 'Open Camera',
                  onPressed: () => _handleScan(context, ImageSource.camera),
                ),

                const SizedBox(height: AppSpacing.h16),


                if (!isLoading)
                  OutlinedButton.icon(
                    onPressed: () => _handleScan(context, ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Upload from Gallery'),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}