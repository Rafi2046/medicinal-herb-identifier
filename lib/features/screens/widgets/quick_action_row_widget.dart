import 'package:flutter/material.dart';
import 'package:medical_herb/core/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class QuickActionRowWidget extends StatelessWidget {
  final String primaryName;

  const QuickActionRowWidget({super.key, required this.primaryName});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonBg = isDark ? const Color(0xFF334155) : const Color(0xFFF1F5F9);
    final iconColor = isDark ? Colors.white : Colors.black87;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionColumn(
          context: context,
          icon: Icons.camera_alt_outlined,
          label: 'Retake',
          bgColor: buttonBg,
          iconColor: iconColor,
          onTap: () => Navigator.pop(context),
        ),
        Consumer<FavoritesProvider>(
          builder: (context, favs, _) {
            final isSaved = favs.isFavorite(primaryName);
            return _buildActionColumn(
              context: context,
              icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
              label: isSaved ? 'Saved' : 'Save',
              bgColor: isSaved ? const Color(0xFF13C366).withOpacity(0.15) : buttonBg,
              iconColor: isSaved ? const Color(0xFF13C366) : iconColor,
              onTap: () {
                favs.toggle(primaryName);
              },
            );
          },
        ),
        _buildActionColumn(
          context: context,
          icon: Icons.share_outlined,
          label: 'Share',
          bgColor: buttonBg,
          iconColor: iconColor,
          onTap: () {
            // Add share functionality later
          },
        ),
      ],
    );
  }

  Widget _buildActionColumn({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(shape: BoxShape.circle, color: bgColor),
            child: Icon(icon, color: iconColor, size: 28),
          ),
          const SizedBox(height: 8),
          Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Theme.of(context).textTheme.bodySmall?.color)),
        ],
      ),
    );
  }
}