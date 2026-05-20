import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/common_widgets/custom_button.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();

  Future<void> _openCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image captured: ${image.path}')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Camera error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = BottomNavScreen.tabContentBottomInset(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
                CustomButton(
                  text: 'Open Camera',
                  onPressed: _openCamera,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
