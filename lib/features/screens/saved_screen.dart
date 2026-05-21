import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/providers/favorites_provider.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';
import 'package:medical_herb/features/screens/widgets/saved_screen_items_widget.dart';
import 'package:medical_herb/features/screens/widgets/tab_screen_header.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = BottomNavScreen.tabContentBottomInset(context);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Consumer<FavoritesProvider>(
          builder: (context, favs, _) {
            final items = favs.items;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TabScreenHeader(
                  title: 'Saved',
                  subtitle: '${items.length} herbs in your collection',
                ),
                Expanded(
                  child: items.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.favorite_border,
                                size: 64,
                                color: Colors.grey[400],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No saved herbs yet',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Save herbs you identify to find them later',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset + 20),
                          itemCount: items.length,
                          separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.s8),
                          itemBuilder: (context, index) {
                            final item = items[index];
                            return SavedScreenItemsWidget(
                              herbName: item.name,
                              onDelete: () => favs.removeAt(index),
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
