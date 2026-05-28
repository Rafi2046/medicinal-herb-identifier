import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/providers/favorites_provider.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/common_widgets/custom_button.dart';
import 'package:provider/provider.dart';

class ButtonActionButtonWidget extends StatelessWidget {
  final String? primaryName;

  const ButtonActionButtonWidget({super.key, this.primaryName});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? const Color(0xFF334155)
        : AppColors.borderColors;
    final buttonBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final buttonTextColor = isDark ? Colors.white : AppColors.herbScientific;

    return Row(
      children: [
        Expanded(
          child: Consumer<FavoritesProvider>(
            builder: (context, favs, _) {
              final saved = favs.isFavorite(primaryName!);
              return CustomButton(
                backgroundColor: saved ? const Color(0xFFE2F6EB) : buttonBg,
                showBorder: true,
                borderColor: borderColor,
                text: saved ? 'Saved' : 'Favorite',
                textColor: saved ? const Color(0xFF13C366) : buttonTextColor,
                onPressed: () {
                  favs.toggle(primaryName!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        saved
                            ? 'Removed from favorites'
                            : '$primaryName saved to favorites',
                      ),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                leading: Image.asset(
                  AppImages.favorites,
                  height: AppSpacing.h16,
                  color: saved
                      ? const Color(0xFF13C366)
                      : (isDark ? Colors.white : null),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomButton(
            backgroundColor: buttonBg,
            showBorder: true,
            borderColor: borderColor,
            text: 'Scan Again',
            textColor: buttonTextColor,
            onPressed: () => Navigator.pop(context),
            leading: Image.asset(
              AppImages.cameraIcon,
              height: AppSpacing.h16,
              color: Colors.green,
            ),
          ),
        ),
      ],
    );
  }
}
