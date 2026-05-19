import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';
import 'package:medical_herb/features/screens/widgets/saved_screen_items_widget.dart';
import 'package:medical_herb/features/screens/widgets/tab_screen_header.dart';

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
  List<SavedHerb> _savedItems = [
    SavedHerb(
      herbName: 'Moringa',
      scientificName: 'Ocimum basilicum',
      family: 'Origanum vulgare',
      imagePath: '',
    ),
    SavedHerb(
      herbName: 'Neem',
      scientificName: 'Azadirachta indica',
      family: 'Meliaceae',
      imagePath: '',
    ),
    SavedHerb(
      herbName: 'Joba',
      scientificName: 'Hibiscus rosa-sinensis',
      family: 'Malvaceae',
      imagePath: '',
    ),
  ];

  void _removeItem(int index) {
    setState(() {
      _savedItems.removeAt(index);
    });
  }

  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      if (_savedItems.isEmpty) {
        _savedItems = [
          SavedHerb(
            herbName: 'Moringa',
            scientificName: 'Ocimum basilicum',
            family: 'Origanum vulgare',
            imagePath: '',
          ),
          SavedHerb(
            herbName: 'Mint',
            scientificName: 'Ocimum basilicum',
            family: 'Origanum vulgare',
            imagePath: '',
          ),
        ];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = BottomNavScreen.tabContentBottomInset(context);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabScreenHeader(
              title: 'Saved',
              subtitle: '${_savedItems.length} herbs in your collection',
              actions: const [

              ],
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: _handleRefresh,
                child: _savedItems.isEmpty
                    ? SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset + 20),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          alignment: Alignment.center,
                          child: const Text('No saved items'),
                        ),
                      )
                    : ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset + 20),
                        itemCount: _savedItems.length,
                        separatorBuilder: (_, _) => const SizedBox(height: AppSpacing.s8),
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
