import 'package:flutter/material.dart';
import 'package:medical_herb/features/main/presentation/models/nav_item.dart';
import 'package:medical_herb/features/main/presentation/widgets/main_tab_pages.dart';
import 'package:medical_herb/features/main/presentation/widgets/main_tab_placeholder.dart';
import 'package:medical_herb/features/screens/home_screen.dart';

/// Central place to wire bottom navigation: **same order and count** for both lists.
///
/// Paste your screens into [tabBodies] like:
/// `static const List<Widget> tabBodies = [ HomeScreen(), ... ];`
class MainTabConfig {
  MainTabConfig._();

  static const List<NavItem> navItems = [
    NavItem(title: 'Home', icon: Icons.home_outlined),
    NavItem(title: 'Explore', icon: Icons.menu_book_outlined),
    NavItem(
      title: 'Scan',
      icon: Icons.camera_alt_outlined,
      style: MainNavTabStyle.centerFab,
    ),
    NavItem(title: 'Saved', icon: Icons.favorite_border),
    NavItem(title: 'History', icon: Icons.schedule_outlined),
  ];

  static const List<Widget> tabBodies = [
    HomeScreen(),
    MainTabPlaceholder(
      title: 'Explore',
      subtitle: 'Herb library coming soon.',
    ),
    MainTabPlaceholder(
      title: 'Scan',
      subtitle: 'Point the camera at a herb to identify it.',
    ),
    MainSavedTab(),
    MainHistoryTab(),
  ];
}
