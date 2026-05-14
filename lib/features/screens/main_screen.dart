import 'package:flutter/material.dart';
import 'package:medical_herb/features/main/presentation/config/main_tab_config.dart';
import 'package:medical_herb/features/main/presentation/widgets/main_app_top_bar.dart';
import 'package:medical_herb/features/main/presentation/widgets/main_shell.dart';

/// Root shell after splash: top bar + tab stack + bottom nav.
///
/// To add tabs, edit [MainTabConfig] (`navItems` + `tabBodies`).
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainShell(
      appBar: const MainAppTopBar(),
      navItems: MainTabConfig.navItems,
      tabBodies: MainTabConfig.tabBodies,
    );
  }
}
