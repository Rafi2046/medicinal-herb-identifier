import 'package:flutter/material.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = BottomNavScreen.tabContentBottomInset(context);
    return ColoredBox(
      color: const Color(0xFFF5F2F8),
      child: Padding(
        padding: EdgeInsets.only(bottom: p),
        child: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('hdgdsudfsuiuifadsuifadsui')
          ],
        ),
      ),
    );
  }
}