import 'package:flutter/material.dart';

enum MainNavTabStyle { standard, centerFab }

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
