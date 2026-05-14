import 'package:flutter/material.dart';
import 'package:medical_herb/features/common_widgets/topbar_widget.dart';

/// App bar for the main shell (MediLeaf header). Swap this widget to change the top bar.
class MainAppTopBar extends StatelessWidget implements PreferredSizeWidget {
  const MainAppTopBar({super.key});

  @override
  Size get preferredSize {
    return const TopBarWidget(
      title: 'MediLeaf',
      subtitle: 'Medicinal Herb Identifier',
      backArrow: false,
    ).preferredSize;
  }

  @override
  Widget build(BuildContext context) {
    return const TopBarWidget(
      title: 'MediLeaf',
      subtitle: 'Medicinal Herb Identifier',
      backArrow: false,
    );
  }
}
