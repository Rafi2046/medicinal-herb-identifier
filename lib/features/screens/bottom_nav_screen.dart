import 'package:flutter/material.dart';
import 'package:medical_herb/features/main/presentation/models/nav_item.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.bottomInset,
    required this.onTap,
  });

  final List<NavItem> items;
  final int currentIndex;
  final double bottomInset;
  final ValueChanged<int> onTap;

  static const double barBodyHeight = 64;
  static const double fabOverhang = 28;

  static double tabContentBottomInset(BuildContext context) {
    return MediaQuery.paddingOf(context).bottom + barBodyHeight + fabOverhang;
  }

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
        height: barBodyHeight + bottomInset + fabOverhang,
        child: Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomCenter,
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: barBodyHeight + bottomInset,
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
                      for (var i = 0; i < items.length; i++)
                        Expanded(
                          child: _navEntry(context, item: items[i], index: i),
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

  Widget _navEntry(
    BuildContext context, {
    required NavItem item,
    required int index,
  }) {
    final selected = currentIndex == index;
    if (item.style == MainNavTabStyle.centerFab) {
      return _ScanNavTile(
        label: item.title,
        icon: item.icon,
        selected: selected,
        onTap: () => onTap(index),
      );
    }
    return _SideNavTile(
      label: item.title,
      icon: item.icon,
      selected: selected,
      onTap: () => onTap(index),
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
        height: BottomNavScreen.barBodyHeight,
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
  const _ScanNavTile({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  static const Color _scanGreen = Color(0xFF27AE60);
  static const double _fabSize = 52;

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1E1E1E)
        : Colors.white;
    final labelWeight = selected ? FontWeight.w700 : FontWeight.w600;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: BottomNavScreen.barBodyHeight,
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
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      width: _fabSize,
                      height: _fabSize,
                      decoration: BoxDecoration(
                        color: _scanGreen,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: selected ? Colors.white : Colors.transparent,
                          width: selected ? 2 : 0,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: _scanGreen.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Icon(icon, color: iconColor, size: 26),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: labelWeight,
                color: _scanGreen,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
