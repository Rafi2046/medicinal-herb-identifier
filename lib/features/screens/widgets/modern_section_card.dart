import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class ModernSectionCard extends StatelessWidget {
  final String title;
  final String iconPath;
  final Widget child;
  final Color? iconColor;

  const ModernSectionCard({
    super.key,
    required this.title,
    required this.iconPath,
    required this.child,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Strictly enforcing your AppColors theme
    final cardColor = isDark ? const Color(0xFF1E293B) : AppColors.white;
    final borderColor = isDark ? const Color(0xFF334155) : AppColors.borderColors;
    final titleColor = isDark ? Colors.white : AppColors.herbName;
    final themeIconColor = iconColor ?? const Color(0xFF13C366);

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 0.8), // Very thin, elegant border
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeIconColor.withOpacity(0.12), // Soft tinted background for the icon
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image(
                    image: AssetImage(iconPath),
                    width: 24,
                    height: 24,
                    color: themeIconColor,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: AppTextStyles.confidenceName.copyWith(
                    color: titleColor,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1,
            thickness: 1,
            color: borderColor.withOpacity(0.5), // Softer divider line
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: child,
          ),
        ],
      ),
    );
  }
}