import 'package:flutter/material.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';
import 'package:medical_herb/features/main/presentation/widgets/main_app_top_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MainAppTopBar(),
      body: const BottomNavScreen(),
    );
  }
}