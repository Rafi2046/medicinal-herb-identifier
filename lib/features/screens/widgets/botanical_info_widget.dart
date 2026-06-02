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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeaderWidget(
          title: 'Botanical Info',
          iconPath: AppImages.botanicalInfoIcon,
          iconColor: const Color(0xFF13C366),
        ),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: isDark ? Colors.white10 : Colors.grey.withOpacity(0.1)),
          ),
          child: Column(
            children: [
              _buildInfoRow('Scientific Name', scientificName, isDark),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: isDark ? Colors.white10 : Colors.grey.shade200),
              ),
              _buildInfoRow('Plant Family', family, isDark),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Divider(height: 1, color: isDark ? Colors.white10 : Colors.grey.shade200),
              ),
              _buildInfoRow('Native Region', region, isDark),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, bool isDark) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white54 : const Color(0xFF94A3B8),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF334155),
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}