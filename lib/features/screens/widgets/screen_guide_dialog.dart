import 'package:flutter/material.dart';

class ScanGuideDialog {
  static void show(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.white70 : Colors.black54;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.document_scanner_rounded,
                      size: 36,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Text(
                    'How to get accurate results?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Follow these simple steps for the best AI predictions.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: subTextColor),
                  ),
                  const SizedBox(height: 24),

                  _buildGuideItem(
                    icon: Icons.check_circle_rounded,
                    iconColor: Colors.green,
                    title: 'Scan a single, clear leaf',
                    textColor: textColor,
                  ),
                  const SizedBox(height: 12),
                  _buildGuideItem(
                    icon: Icons.wb_sunny_rounded,
                    iconColor: Colors.green,
                    title: 'Use natural lighting',
                    textColor: textColor,
                  ),
                  const SizedBox(height: 12),
                  _buildGuideItem(
                    icon: Icons.cancel_rounded,
                    iconColor: Colors.redAccent,
                    title: 'Avoid fruits, flowers or white bg',
                    textColor: textColor,
                  ),
                  const SizedBox(height: 12),
                  _buildGuideItem(
                    icon: Icons.zoom_out_map_rounded,
                    iconColor: Colors.redAccent,
                    title: 'Do not over-zoom the leaf',
                    textColor: textColor,
                  ),
                  const SizedBox(height: 12),

                  _buildGuideItem(
                    icon: Icons.brightness_low_rounded,
                    iconColor: Colors.redAccent,
                    title: 'Avoid pitch-black or empty photos',
                    textColor: textColor,
                  ),
                  const SizedBox(height: 24),

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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Widget _buildGuideItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required Color textColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: 22),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
