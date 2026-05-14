import 'package:flutter/material.dart';
import 'package:medical_herb/features/main/presentation/models/nav_item.dart';
import 'package:medical_herb/features/screens/bottom_nav_screen.dart';

/// Scaffold + [appBar] + [IndexedStack] of [tabBodies] + [BottomNavScreen].
///
/// Pass the same length for [navItems] and [tabBodies] (see [MainTabConfig]).
class MainShell extends StatefulWidget {
  const MainShell({
    super.key,
    required this.appBar,
    required this.navItems,
    required this.tabBodies,
  });

  final PreferredSizeWidget appBar;
  final List<NavItem> navItems;
  final List<Widget> tabBodies;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    assert(
      widget.tabBodies.length == widget.navItems.length,
      'tabBodies (${widget.tabBodies.length}) and navItems (${widget.navItems.length}) must match.',
    );

    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      extendBody: true,
      appBar: widget.appBar,
      body: IndexedStack(
        index: _currentIndex,
        children: widget.tabBodies,
      ),
      bottomNavigationBar: BottomNavScreen(
        items: widget.navItems,
        currentIndex: _currentIndex,
        bottomInset: bottomInset,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
