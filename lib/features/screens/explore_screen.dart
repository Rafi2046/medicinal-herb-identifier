import 'package:flutter/material.dart';
import 'package:medical_herb/core/data/plant_database.dart';
import 'package:medical_herb/core/data/plant_images.dart';
import 'package:medical_herb/features/bottom_nav/bottom_nav_screen.dart';
import 'package:medical_herb/features/screens/herb_full_details_screen.dart';
import 'package:medical_herb/features/screens/widgets/tab_screen_header.dart';

class _PlantImage extends StatelessWidget {
  final String imagePath;
  final Color borderColor;

  const _PlantImage({required this.imagePath, required this.borderColor});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: borderColor),
        ),
        child: Image.asset(
          imagePath,
          width: 100,
          height: 100,
          fit: BoxFit.cover,
          errorBuilder: (context, _, _) => Container(
            width: 100,
            height: 100,
            color: Colors.grey.shade200,
            child: const Icon(Icons.image_not_supported, color: Colors.grey),
          ),
        ),
      ),
    );
  }
}

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInset = BottomNavScreen.tabContentBottomInset(context);
    final herbs = plantDatabase.keys.toList();
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark
        ? const Color(0xFF334155)
        : const Color(0xFFD6E2EF);

    return Scaffold(
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabScreenHeader(
              title: 'Explore Herbs',
              subtitle: '${herbs.length} herbs in database',
            ),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.fromLTRB(20, 16, 20, bottomInset + 20),
                itemCount: herbs.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final name = herbs[index];
                  final plant = plantDatabase[name];
                  return InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HerbFullDetailsScreen(herbName: name),
                      ),
                    ),
                    child: Card(
                      margin: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(color: borderColor),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            _PlantImage(
                              imagePath: imageForPlant(name),
                              borderColor: borderColor,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: '$name\n',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            color: isDark
                                                ? Colors.white
                                                : const Color(0xFF14532c),
                                          ),
                                    ),
                                    TextSpan(
                                      text: plant?.scientificName ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                            color: isDark
                                                ? Colors.white70
                                                : const Color(0xFF4b7c59),
                                          ),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: isDark ? Colors.white70 : borderColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
