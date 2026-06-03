import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'section_header_widget.dart';

class BadSidesWidget extends StatelessWidget {
  final List<String> sides;
  const BadSidesWidget({super.key, this.sides = const []});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(
          title: 'Precautions',
          iconPath: AppImages.detailsTickIcon,
          iconColor: Colors.orange,
        ),
        ...sides.map((side) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 4),
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.warning_amber_rounded, size: 12, color: Colors.orange),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  side,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.5,
                    color: isDark ? Colors.white70 : const Color(0xFF475569),
                  ),
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
