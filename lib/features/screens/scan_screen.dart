import 'package:flutter/material.dart';
import 'package:medical_herb/features/screens/bottom_nav_screen.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = BottomNavScreen.tabContentBottomInset(context);
    return ColoredBox(
      color: const Color(0xFFF5F2F8),
      child: Padding(
        padding: EdgeInsets.only(bottom: p),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.camera_alt_outlined, size: 64, color: Color(0xFF2D9E61)),
              const SizedBox(height: 16),
              Text('Scan', style: AppTextStyles.heading2),
              const SizedBox(height: 8),
              Text('Point the camera at a herb to identify it.', style: AppTextStyles.body3),
            ],
          ),
        ),
      ),
    );
  }
}