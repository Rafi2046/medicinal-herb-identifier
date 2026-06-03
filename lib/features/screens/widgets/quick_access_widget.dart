import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/providers/favorites_provider.dart';
import 'package:medical_herb/features/screens/saved_screen.dart';

class QuickAccessWidget extends StatelessWidget {
  final VoidCallback? onHistoryPressed;

  const QuickAccessWidget({super.key, this.onHistoryPressed});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      children: [
        // --- FAVORITES CARD ---
        Expanded(
          child: Consumer<FavoritesProvider>(
            builder: (context, favs, _) {
              final count = favs.items.length;
              return _buildPremiumCard(
                context: context,
                isDark: isDark,
                title: 'Favorites',
                subtitle: count == 0 ? 'No saved herbs' : '$count saved',
                // Using Flutter's built-in icon fixes the "solid dot" issue perfectly
                iconData: Icons.favorite_rounded,
                iconTint: const Color(0xFF13C366), // Green
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SavedScreen(showBackButton: true)),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        // --- HISTORY CARD ---
        Expanded(
          child: _buildPremiumCard(
            context: context,
            isDark: isDark,
            title: 'History',
            subtitle: 'Recent scans',
            iconData: Icons.history_rounded, // Built-in icon
            iconTint: const Color(0xFF3B82F6), // Blue
            onTap: onHistoryPressed,
          ),
        ),
      ],
    );
  }

  Widget _buildPremiumCard({
    required BuildContext context,
    required bool isDark,
    required String title,
    required String subtitle,
    required IconData iconData,
    required Color iconTint,
    required VoidCallback? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4), // Much softer, tighter shadow
            ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            // Changed from Row to Column so text never squishes!
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Soft tinted circular icon background
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: iconTint.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(iconData, color: iconTint, size: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xFF1A3B28),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: isDark ? Colors.white54 : const Color(0xFF64748B),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}