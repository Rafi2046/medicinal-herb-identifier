import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';


class ScanGuideBottomSheet {
  static void show(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;

    showModalBottomSheet(
      context: context,
      backgroundColor: bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.h20),

              Text(
                'How to get accurate results?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: AppSpacing.h8),
              Text(
                'Follow these simple steps for the best predictions.',
                style: TextStyle(fontSize: 14, color: subTextColor),
              ),
              const SizedBox(height: AppSpacing.h24),

              _buildGuideItem(
                icon: Icons.check_circle_rounded,
                iconColor: Colors.green,
                title: 'Scan a single, clear leaf',
                subtitle: 'Ensure the whole leaf, including edges, is visible.',
                textColor: textColor,
                subTextColor: subTextColor,
              ),
              const SizedBox(height: AppSpacing.h16),
              _buildGuideItem(
                icon: Icons.wb_sunny_rounded,
                iconColor: Colors.green,
                title: 'Use natural lighting',
                subtitle: 'Avoid extreme shadows or pitch-black darkness.',
                textColor: textColor,
                subTextColor: subTextColor,
              ),
              const SizedBox(height: AppSpacing.h16),
              _buildGuideItem(
                icon: Icons.cancel_rounded,
                iconColor: Colors.redAccent,
                title: 'Avoid fruits or flowers',
                subtitle: 'Focus only on the leaves, hide extra objects.',
                textColor: textColor,
                subTextColor: subTextColor,
              ),
              const SizedBox(height: AppSpacing.h16),
              _buildGuideItem(
                icon: Icons.zoom_out_map_rounded,
                iconColor: Colors.redAccent,
                title: 'Do not over-zoom',
                subtitle: 'Do not zoom so much that the leaf boundaries are cut off.',
                textColor: textColor,
                subTextColor: subTextColor,
              ),
              const SizedBox(height: AppSpacing.h24),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Got it!',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildGuideItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required Color textColor,
    required Color subTextColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(fontSize: 13, color: subTextColor),
              ),
            ],
          ),
        ),
      ],
    );
  }
}