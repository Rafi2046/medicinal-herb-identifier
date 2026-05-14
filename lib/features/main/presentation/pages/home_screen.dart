import 'package:flutter/material.dart';
import 'package:medical_herb/features/common_widgets/topbar_widget.dart';

class AppBarWidget extends StatelessWidget {
  final String title;

  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF27AE60),
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      extendBody: true,

      appBar: const TopBarWidget(
        title: 'MediLeaf',
        subtitle: 'Medicinal Herb Identifier',
        backArrow: false,
      ),

      body: const Center(child: Text('Content Area')),

      bottomNavigationBar: _CustomBottomNav(
        currentIndex: _currentIndex,
        bottomInset: bottomInset,
        onTap: (i) => setState(() => _currentIndex = i),
      ),
    );
  }
}

class _CustomBottomNav extends StatelessWidget {
  const _CustomBottomNav({
    required this.currentIndex,
    required this.bottomInset,
    required this.onTap,
  });

  final int currentIndex;
  final double bottomInset;
  final ValueChanged<int> onTap;

  static const double _barBodyHeight = 64;
  static const double _fabOverhang = 28;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final navBg = isDark ? const Color(0xFF1E1E1E) : Colors.white;
    final borderColor = isDark
        ? Colors.white.withOpacity(0.08)
        : Colors.black.withOpacity(0.04);
    final shadowColor = isDark
        ? Colors.black.withOpacity(0.3)
        : Colors.black.withOpacity(0.03);

    return Material(
      color: Colors.transparent,
      child: SizedBox(
        height: _barBodyHeight + bottomInset + _fabOverhang,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: _barBodyHeight + bottomInset,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: navBg,
                  border: Border(top: BorderSide(color: borderColor, width: 1)),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      offset: const Offset(0, -4),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(bottom: bottomInset),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: _SideNavTile(
                          label: 'Home',
                          icon: Icons.home_outlined,
                          selected: currentIndex == 0,
                          onTap: () => onTap(0),
                        ),
                      ),
                      Expanded(
                        child: _SideNavTile(
                          label: 'Explore',
                          icon: Icons.menu_book_outlined,
                          selected: currentIndex == 1,
                          onTap: () => onTap(1),
                        ),
                      ),
                      Expanded(child: _ScanNavTile(onTap: () => onTap(2))),
                      Expanded(
                        child: _SideNavTile(
                          label: 'Saved',
                          icon: Icons.favorite_border,
                          selected: currentIndex == 3,
                          onTap: () => onTap(3),
                        ),
                      ),
                      Expanded(
                        child: _SideNavTile(
                          label: 'History',
                          icon: Icons.schedule_outlined,
                          selected: currentIndex == 4,
                          onTap: () => onTap(4),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SideNavTile extends StatelessWidget {
  const _SideNavTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  static const Color _active = Color(0xFF27AE60);

  @override
  Widget build(BuildContext context) {
    final inactive = Theme.of(context).colorScheme.onSurface.withOpacity(0.4);
    final color = selected ? _active : inactive;

    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: _active.withOpacity(0.1),
      child: Container(
        height: 64, // Fills the available bar height
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanNavTile extends StatelessWidget {
  const _ScanNavTile({required this.onTap});

  final VoidCallback onTap;

  static const Color _scanGreen = Color(0xFF27AE60);
  static const double _fabSize = 52;

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1E1E1E)
        : Colors.white;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 64, // Matches the height of side tiles
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.only(bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 24,
              width: _fabSize,
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.bottomCenter,
                children: [
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: _fabSize,
                      height: _fabSize,
                      decoration: BoxDecoration(
                        color: _scanGreen,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: _scanGreen.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: iconColor,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Scan',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _scanGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
