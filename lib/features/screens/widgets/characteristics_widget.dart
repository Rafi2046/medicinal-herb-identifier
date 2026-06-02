import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'section_header_widget.dart';

class CharacteristicsWidget extends StatelessWidget {
  final List<String> traits;
  const CharacteristicsWidget({super.key, this.traits = const []});

  @override
  Widget build(BuildContext context) {
    if (traits.isEmpty) return const SizedBox.shrink();

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Added the header back so users know what these buttons mean!
        SectionHeaderWidget(
          title: 'Characteristics',
          iconPath: AppImages.characterIcon,
          iconColor: const Color(0xFF13C366),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: traits.map((t) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              t,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : const Color(0xFF64748B),
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }
}