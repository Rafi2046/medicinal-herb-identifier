import 'package:flutter/material.dart';
import 'package:medical_herb/core/data/plant_database.dart';
import 'package:medical_herb/core/data/plant_images.dart';
import 'package:medical_herb/features/screens/herb_full_details_screen.dart';

class HerbOfDayWidget extends StatelessWidget {
  const HerbOfDayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final herbs = plantDatabase.keys.toList();
    final dayOfYear = DateTime.now().difference(
      DateTime(DateTime.now().year, 1, 1),
    ).inDays;
    final index = dayOfYear % herbs.length;
    final herbName = herbs[index];
    final plant = plantDatabase[herbName];

    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HerbFullDetailsScreen(herbName: herbName),
        ),
      ),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 220, // Slightly taller for a premium feel
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Image
            Image.asset(
              imageForPlant(herbName),
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, _, _) => Container(color: Colors.green.shade100),
            ),

            // Dark Gradient for text readability
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.85), // Darker at bottom
                      Colors.black.withOpacity(0.0),  // Clear at top
                    ],
                    stops: const [0.0, 0.7],
                  ),
                ),
              ),
            ),

            // NEW: The "Daily Pick" badge moved inside the card!
            Positioned(
              top: 16,
              right: 16,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4), // Sleek translucent pill
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Daily Pick',
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),

            // Text Content
            Positioned(
              left: 20,
              bottom: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    herbName,
                    style: const TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.w800, height: 1.1),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    plant?.scientificName ?? '',
                    style: const TextStyle(color: Color(0xFF13C366), fontSize: 14, fontWeight: FontWeight.w600, fontStyle: FontStyle.italic),
                  ),
                  const SizedBox(height: 8),
                  if (plant != null && plant.description.isNotEmpty)
                    Text(
                      plant.description,
                      style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 13, height: 1.4),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}