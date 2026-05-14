import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

/// History list for embedding in the main bottom navigation (no app bar).
class HistoryBody extends StatelessWidget {
  const HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FEATURED HERBS',
                style: AppTextStyles.optionText.copyWith(
                  color: const Color(0xFF0F9A4C),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
              Text(
                'See all  >',
                style: AppTextStyles.body3.copyWith(
                  color: const Color(0xFF0F9A4C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return _HistoryHerbCard(item: _items[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2F8),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F2F8),
        elevation: 0,
        centerTitle: false,
        title: Text(
          'Scan History',
          style: AppTextStyles.appBar.copyWith(color: const Color(0xFF0E8A43)),
        ),
      ),
      body: const HistoryBody(),
    );
  }
}

class _HistoryHerbCard extends StatelessWidget {
  const _HistoryHerbCard({required this.item});

  final _HistoryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFD9D9D9)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              item.imagePath,
              width: 52,
              height: 52,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: AppTextStyles.buttonText.copyWith(
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F5F3D),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.scientific,
                  style: AppTextStyles.quickSubTile.copyWith(
                    fontStyle: FontStyle.italic,
                    color: const Color(0xFF727D75),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFE7F7EC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Text(
              item.family,
              style: AppTextStyles.body5.copyWith(
                color: const Color(0xFF2D9E61),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HistoryItem {
  const _HistoryItem({
    required this.name,
    required this.scientific,
    required this.family,
    required this.imagePath,
  });

  final String name;
  final String scientific;
  final String family;
  final String imagePath;
}

const List<_HistoryItem> _items = [
  _HistoryItem(
    name: 'Joba',
    scientific: 'Hibiscus rosa-sinensis',
    family: 'Malvaceae',
    imagePath: 'assets/background_image/joba.webp',
  ),
  _HistoryItem(
    name: 'Neem',
    scientific: 'Azadirachta indica',
    family: 'Meliaceae',
    imagePath: 'assets/background_image/nim.jpeg',
  ),
  _HistoryItem(
    name: 'Moringa',
    scientific: 'Moringa oleifera',
    family: 'Moringaceae',
    imagePath: 'assets/background_image/moringa.jpg',
  ),
];
