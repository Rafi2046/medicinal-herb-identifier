import 'package:flutter/material.dart';
import 'package:medical_herb/features/screens/bottom_nav_screen.dart';

/// Simple “coming soon” tab body; bottom inset matches the main bottom bar.
class MainTabPlaceholder extends StatelessWidget {
  const MainTabPlaceholder({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final bottomInset = BottomNavScreen.tabContentBottomInset(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(24, 0, 24, bottomInset),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.construction_outlined, size: 48, color: cs.primary),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: cs.onSurface,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: cs.onSurface.withOpacity(0.65),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
