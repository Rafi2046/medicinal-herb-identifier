import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/providers/favorites_provider.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/screens/saved_screen.dart';

class QuickAccessWidget extends StatelessWidget {
  final VoidCallback? onHistoryPressed;

  const QuickAccessWidget({super.key, this.onHistoryPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Expanded(
          child: Consumer<FavoritesProvider>(
            builder: (context, favs, _) {
              final count = favs.items.length;
              return Material(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const SavedScreen(showBackButton: true)),
                  ),
                  child: Container(
                    height: 80,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2, color: Colors.teal),
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        spacing: AppSpacing.s8,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Image(
                            image: AssetImage(AppImages.favoriteIcon),
                            width: AppSpacing.w40,
                            height: AppSpacing.h40,
                          ),
                          Column(
                            spacing: AppSpacing.s2,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Favorites', style: AppTextStyles.uploadText),
                              SizedBox(height: AppSpacing.s4),
                              Text(
                                count == 0 ? 'No saved herbs' : '$count saved herb${count > 1 ? 's' : ''}',
                                style: AppTextStyles.quickSubTile,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Expanded(
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onHistoryPressed,
              child: Container(
                height: 80,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  border: Border.all(width: 2, color: Colors.teal),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    spacing: AppSpacing.s8,
                    children: [
                      Image(
                        image: AssetImage(AppImages.historyIcon),
                        width: AppSpacing.w40,
                        height: AppSpacing.h40,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('History', style: AppTextStyles.uploadText),
                          SizedBox(height: AppSpacing.s4),
                          Text(
                            'Recent scans',
                            style: AppTextStyles.quickSubTile,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
