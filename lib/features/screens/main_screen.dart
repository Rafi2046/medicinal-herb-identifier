import 'package:flutter/material.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BottomNavScreen(),
    );
  }
}