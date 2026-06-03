import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'section_header_widget.dart';

class GoodSidesWidget extends StatelessWidget {
  final List<String> sides;
  const GoodSidesWidget({super.key, this.sides = const []});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeaderWidget(
          title: 'Good Sides',
          iconPath: AppImages.detailsTickIcon,
          iconColor: Color(0xFF13C366),
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
                  color: const Color(0xFF13C366).withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, size: 12, color: Color(0xFF13C366)),
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
