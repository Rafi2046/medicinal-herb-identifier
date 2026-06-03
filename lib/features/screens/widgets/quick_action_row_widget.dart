import 'package:flutter/material.dart';
import 'package:medical_herb/core/providers/favorites_provider.dart';
import 'package:provider/provider.dart';

class QuickActionRowWidget extends StatelessWidget {
  final String primaryName;

  const QuickActionRowWidget({super.key, required this.primaryName});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final buttonBg = isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9);
    final iconColor = isDark ? Colors.white : const Color(0xFF1E293B);
    const primaryGreen = Color(0xFF13C366);

    return Padding(
      // Standard screen margin
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          // 1. RETAKE BUTTON (Modern Horizontal Layout)
          Expanded(
            child: _buildModernButton(
              context: context,
              icon: Icons.camera_alt_outlined,
              label: 'Retake',
              bgColor: buttonBg,
              textColor: iconColor,
              onTap: () => Navigator.pop(context),
            ),
          ),

          const SizedBox(width: 16), // Sleek, clean gap

          // 2. SAVE BUTTON (Modern Horizontal Layout)
          Expanded(
            child: Consumer<FavoritesProvider>(
              builder: (context, favs, _) {
                final isSaved = favs.isFavorite(primaryName);
                return _buildModernButton(
                  context: context,
                  icon: isSaved ? Icons.bookmark : Icons.bookmark_border,
                  label: isSaved ? 'Saved' : 'Save',
                  // Green tint when saved!
                  bgColor: isSaved ? primaryGreen.withOpacity(0.12) : buttonBg,
                  textColor: isSaved ? primaryGreen : iconColor,
                  onTap: () {
                    favs.toggle(primaryName);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // The NEW Modern Horizontal Button Builder
  Widget _buildModernButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color bgColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: bgColor,
      borderRadius: BorderRadius.circular(16), // Matches your bottom 'View Full Details' curve
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 56, // Standard modern premium touch-target height
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Icon and text side-by-side!
            children: [
              Icon(icon, color: textColor, size: 22),
              const SizedBox(width: 8), // Small gap between icon and text
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}