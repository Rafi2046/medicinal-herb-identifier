import 'package:flutter/material.dart';
import 'package:medical_herb/features/screens/favorites_screen.dart';
import 'package:medical_herb/features/screens/history_screen.dart';
import 'package:medical_herb/features/screens/bottom_nav_screen.dart';

/// Saved tab inside the main shell (light panel + list).
class MainSavedTab extends StatelessWidget {
  const MainSavedTab({super.key});

  @override
  Widget build(BuildContext context) {
    final p = BottomNavScreen.tabContentBottomInset(context);
    return ColoredBox(
      color: const Color(0xFFF5F2F8),
      child: Padding(
        padding: EdgeInsets.only(bottom: p),
        child: const FavoritesBody(),
      ),
    );
  }
}

/// History tab inside the main shell.
class MainHistoryTab extends StatelessWidget {
  const MainHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    final p = BottomNavScreen.tabContentBottomInset(context);
    return ColoredBox(
      color: const Color(0xFFF5F2F8),
      child: Padding(
        padding: EdgeInsets.only(bottom: p),
        child: const HistoryBody(),
      ),
    );
  }
}
