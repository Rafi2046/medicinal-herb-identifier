import 'package:flutter/material.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';

class SideNavTile extends StatelessWidget {
  const SideNavTile({
    super.key,
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
    final inactive = Theme.of(
      context,
    ).colorScheme.onSurface.withValues(alpha: 0.4);
    final color = selected ? _active : inactive;

    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: _active.withValues(alpha: 0.1),
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

class ScanNavTile extends StatelessWidget {
  const ScanNavTile({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconColor = Theme.of(context).brightness == Brightness.dark
        ? const Color(0xFF1E1E1E)
        : Colors.white;

    return Container(
      // CRITICAL: Must be transparent to prevent the white box over the blue line
      color: Colors.transparent,
      width: 80, // Wide enough to hold the button and text comfortably
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Column(
          // Align to the START (top) so the button sits in the overhang area
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // The Floating Green Button
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 56, // Slightly larger, premium size
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.popupColor,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.popupColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(height: 6),
            // The Label Text
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.popupColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}