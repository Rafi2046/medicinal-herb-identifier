import 'package:flutter/material.dart';

/// How a bottom-nav entry is drawn.
enum MainNavTabStyle {
  /// Normal row tile (icon + label).
  standard,

  /// Raised center action (e.g. Scan).
  centerFab,
}

/// One bottom navigation tab: label + [IconData] (same order/length as your tab screen list).
class NavItem {
  const NavItem({
    required this.title,
    required this.icon,
    this.style = MainNavTabStyle.standard,
  });

  final String title;
  final IconData icon;
  final MainNavTabStyle style;
}
