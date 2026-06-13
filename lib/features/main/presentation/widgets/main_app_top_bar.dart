import 'package:flutter/material.dart';
import 'package:medical_herb/features/common_widgets/topbar_widget.dart';

class MainAppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppTopBar({super.key});

  @override
  Size get preferredSize {
    return const TopBarWidget(
      title: 'AyurVision',
      subtitle: 'Medicinal Herb Identifier',
      backArrow: false,
    ).preferredSize;
  }

  @override
  Widget build(BuildContext context) {
    return const TopBarWidget(
      title: 'AyurVision',
      subtitle: 'Medicinal Herb Identifier',
      backArrow: false,
    );
  }
}
