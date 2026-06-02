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
        SectionHeaderWidget(
          title: 'Good Sides',
          iconPath: AppImages.detailsTickIcon,
          iconColor: const Color(0xFF13C366),
        ),
        ...sides.map((side) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Image(
                  image: AssetImage(AppImages.detailsTickIcon),
                  height: 16,
                  width: 16,
                  color: const Color(0xFF13C366),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  side,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.4,
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