import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/features/screens/widgets/saved_screen_items_widget.dart';

class SavedHerb {
  final String herbName;
  final String scientificName;
  final String family;
  final String imagePath;

  const SavedHerb({
    required this.herbName,
    required this.scientificName,
    required this.family,
    required this.imagePath,
  });
}

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final List<SavedHerb> _savedItems = [
    SavedHerb(herbName: 'Moringa', scientificName: 'Ocimum basilicum', family: 'Origanum vulgare', imagePath: ''),
    SavedHerb(herbName: 'Neem', scientificName: 'Azadirachta indica', family: 'Meliaceae', imagePath: ''),
    SavedHerb(herbName: 'Joba', scientificName: 'Hibiscus rosa-sinensis', family: 'Malvaceae', imagePath: ''),
  ];

  void _removeItem(int index) {
    setState(() {
      _savedItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _savedItems.isEmpty
          ? const Center(child: Text('No saved items'))
          : ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: _savedItems.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.s8),
              itemBuilder: (context, index) {
                final item = _savedItems[index];
                return SavedScreenItemsWidget(
                  herbName: item.herbName,
                  scientificName: item.scientificName,
                  family: item.family,
                  imagePath: item.imagePath,
                  onDelete: () => _removeItem(index),
                );
              },
            ),
    );
  }
}