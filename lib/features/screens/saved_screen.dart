import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/features/screens/widgets/saved_screen_items_widget.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 10,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s8),
        itemBuilder: (context, index) {
          return const SavedScreenItemsWidget();
        },
      ),
    );
  }
}
