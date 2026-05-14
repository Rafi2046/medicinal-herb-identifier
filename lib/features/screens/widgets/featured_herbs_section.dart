import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

class FeaturedHerbsSection extends StatelessWidget {
  const FeaturedHerbsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
            GestureDetector(
              onTap: () {},
              child: Text(
                'See all  >',
                style: AppTextStyles.body3.copyWith(
                  color: const Color(0xFF0F9A4C),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ..._items.map(
          (item) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _FeaturedHerbCard(item: item),
          ),
        ),
      ],
    );
  }
}

class _FeaturedHerbCard extends StatelessWidget {
  const _FeaturedHerbCard({required this.item});

  final _FeaturedHerb item;

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
              errorBuilder: (_, __, ___) => Container(
                width: 52,
                height: 52,
                color: const Color(0xFFE7F7EC),
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported_outlined, size: 18),
              ),
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
                  item.scientificName,
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

class _FeaturedHerb {
  const _FeaturedHerb({
    required this.name,
    required this.scientificName,
    required this.family,
    required this.imagePath,
  });

  final String name;
  final String scientificName;
  final String family;
  final String imagePath;
}

const List<_FeaturedHerb> _items = [
  _FeaturedHerb(
    name: 'Joba',
    scientificName: 'Hibiscus rosa-sinensis',
    family: 'Malvaceae',
    imagePath: 'assets/background_image/joba.webp',
  ),
  _FeaturedHerb(
    name: 'Neem',
    scientificName: 'Azadirachta indica',
    family: 'Meliaceae',
    imagePath: 'assets/background_image/nim.jpeg',
  ),
  _FeaturedHerb(
    name: 'Moringa',
    scientificName: 'Moringa oleifera',
    family: 'Moringaceae',
    imagePath: 'assets/background_image/moringa.jpg',
  ),
];
