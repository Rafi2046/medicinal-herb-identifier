import 'package:flutter/material.dart';
import 'package:medical_herb/features/favorites/presentation/pages/favorites_screen.dart';
import 'package:medical_herb/features/history/presentation/pages/history_screen.dart';
import 'package:medical_herb/features/home/presentation/page/home_screen.dart';

class MainScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onThemeToggle;

  const MainScreen({
    super.key,
    required this.isDark,
    required this.onThemeToggle,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  List<Widget> get _pages => [
        HomeScreen(
          isDark: widget.isDark,
          onThemeToggle: widget.onThemeToggle,
        ),
        const FavoritesScreen(),
        const HistoryScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        height: 72,
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        indicatorColor: const Color(0xFFE6F7EC),
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: isDark ? Colors.white : Colors.black),
            selectedIcon: Icon(Icons.home_rounded, color: isDark ? Colors.white : Colors.black),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border_rounded, color: isDark ? Colors.white : Colors.black),
            selectedIcon: Icon(Icons.favorite_rounded, color: isDark ? Colors.white : Colors.black),
            label: 'Favorites',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_rounded, color: isDark ? Colors.white : Colors.black),
            selectedIcon: Icon(Icons.history_toggle_off_rounded, color: isDark ? Colors.white : Colors.black),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
