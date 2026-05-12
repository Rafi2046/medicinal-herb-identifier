import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/features/main/presentation/pages/main_screen.dart';

class SplashScreen extends StatefulWidget {
  final void Function() onThemeToggle;
  final bool isDark;

  const SplashScreen({
    super.key,
    required this.onThemeToggle,
    required this.isDark,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image(
              image: AssetImage(AppImages.splashImage),
              fit: BoxFit.cover,
            ),
          ),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  image: const AssetImage(AppImages.splashLogo),
                  width: 100,
                  height: 100,
                ),

                Text('MediLeaf', style: AppTextStyles.heading2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
