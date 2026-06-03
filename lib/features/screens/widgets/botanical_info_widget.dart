import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'section_header_widget.dart';

class BotanicalInfoWidget extends StatelessWidget {
  final String scientificName;
  final String family;
  final String region;

  const BotanicalInfoWidget({
    super.key,
    this.scientificName = '',
    this.family = '',
    this.region = '',
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final items = [
      _InfoItem(icon: Icons.biotech_outlined, label: 'Scientific Name', value: scientificName),
      _InfoItem(icon: Icons.account_tree_outlined, label: 'Family', value: family),
      _InfoItem(icon: Icons.public_outlined, label: 'Origin', value: region),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(
          title: 'Botanical Info',
          iconPath: AppImages.botanicalInfoIcon,
          iconColor: Color(0xFF13C366),
        ),
        Column(
          children: items
              .where((e) =>
                  e.value.isNotEmpty && !e.value.contains('To be'))
              .toList()
              .asMap()
              .entries
              .map((entry) {
            final i = entry.key;
            final item = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: i < items.length - 1 ? 10 : 0),
              child: Row(
                children: [
                  Icon(item.icon, size: 18, color: isDark ? Colors.white54 : const Color(0xFF94A3B8)),
                  const SizedBox(width: 10),
                  Text(
                    '${item.label}: ',
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white54 : const Color(0xFF94A3B8),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item.value,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF334155),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _InfoItem {
  final IconData icon;
  final String label;
  final String value;
  const _InfoItem({required this.icon, required this.label, required this.value});
}
