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
        const SectionHeaderWidget(
          title: 'Characteristics',
          iconPath: AppImages.characterIcon,
          iconColor: Color(0xFF13C366),
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: traits.map((t) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF1E293B), const Color(0xFF1a2332)]
                    : [const Color(0xFFF1F5F9), const Color(0xFFF8FAFC)],
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
              ),
            ),
            child: Text(
              t,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : const Color(0xFF475569),
              ),
            ),
          )).toList(),
        ),
      ],
    );
  }
}
