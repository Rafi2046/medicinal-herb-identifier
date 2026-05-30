import 'package:flutter/material.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';
import 'package:medical_herb/features/common_widgets/first_launch_guide_wrapper.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FirstLaunchGuideWrapper(
      child: Scaffold(body: BottomNavScreen()),
    );
  }
}
