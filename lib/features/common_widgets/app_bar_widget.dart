import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showMenuIcon;
  final bool resetForm;
  final VoidCallback? onPopOut;
  final bool? backArrow;
  final String? subtitle;

  static const double _toolbarHeight = 65;

  const AppBarWidget({
    super.key,
    this.title,
    this.subtitle,
    this.showMenuIcon = false,
    this.onPopOut,
    this.resetForm = false,
    this.backArrow,
  });

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colorScheme = Theme.of(context).colorScheme;

    final headerBg = isDark
        ? const Color(0xFF1a2e1a)
        : AppColors.containerColorGreen;
    final titleColor = isDark ? Colors.white : AppColors.herbName;
    final subtitleColor = isDark ? Colors.white70 : const Color(0xFF545C66);

    return Container(
      decoration: BoxDecoration(
        color: headerBg,
        border: const Border(bottom: BorderSide(color: Colors.teal, width: 2)),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: headerBg,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
        toolbarHeight: _toolbarHeight,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leadingWidth: 56,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDark ? Colors.white : Colors.black,
            size: 28,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        titleSpacing: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title ?? '',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.appBar.copyWith(color: titleColor),
            ),
            if (subtitle != null)
              Text(

                subtitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: subtitleColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
