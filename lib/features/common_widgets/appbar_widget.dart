import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';


class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenuIcon;
  final bool resetForm;
  final VoidCallback? onPopOut;
  final bool? backArrow;

  const AppBarWidget({
    super.key,
    required this.title,
    this.showMenuIcon = false,
    this.onPopOut,
    this.resetForm = false,
    this.backArrow,
  });

  @override
  Size get preferredSize => const Size.fromHeight(50);

  Widget? _buildLeading(BuildContext context) {
    if (showMenuIcon) {
      return IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      );
    }

    if (backArrow == false) {
      return null;
    }

    return IconButton(
      icon: Image.asset(AppImages.arrowbackIcon),
      onPressed: resetForm && onPopOut != null
          ? onPopOut
          : () => Navigator.pop(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: AppColors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      centerTitle: true,
      toolbarHeight: 50,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      title: Text(title, style: AppTextStyles.appbarTitle),
      leading: _buildLeading(context),
    );
  }
}