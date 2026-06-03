import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'section_header_widget.dart';

class DescriptionWidget extends StatelessWidget {
  final String description;
  const DescriptionWidget({super.key, this.description = ''});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(
          title: 'Description',
          iconPath: AppImages.descriptionIcon,
          iconColor: Color(0xFF13C366),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            description,
            style: TextStyle(
              fontSize: 15,
              height: 1.7,
              color: isDark ? Colors.white70 : const Color(0xFF475569),
            ),
          ),
        ),
      ],
    );
  }
}
