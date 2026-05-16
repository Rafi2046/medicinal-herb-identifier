import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showMenuIcon;
  final bool resetForm;
  final VoidCallback? onPopOut;
  final bool? backArrow;
  final String? subtitle;

  static const double _toolbarHeight = 65;
  static const double _leadingWidth = 100;

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
    final bool showBack = backArrow == true;

    final shadowColor = isDark
        ? Colors.black.withOpacity(0.3)
        : Colors.black.withOpacity(0.03);

    final topBarBg = isDark ? colorScheme.surface : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: topBarBg,
        border: Border(bottom: BorderSide(color: Colors.teal, width: 2)),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            offset: const Offset(0, 4),
            blurRadius: 12,
          ),
        ],
      ),
      child: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: topBarBg,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
        toolbarHeight: _toolbarHeight,
        centerTitle: false,
        automaticallyImplyLeading: false,
        leadingWidth: showBack ? _leadingWidth : 0,
        leading: showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: resetForm && onPopOut != null
                    ? onPopOut
                    : () => Navigator.maybePop(context),
              )
            : null,
        titleSpacing: showBack ? NavigationToolbar.kMiddleSpacing : 0,
        title: showBack
            ? Text(
                title ?? '',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              )
            : Row(
                children: [
                  IconButton(
                    icon: Image.asset(
                      AppImages.arrowbackIcon,
                      height: 28,
                      width: 28,
                    ),
                    iconSize: 28,
                    onPressed: () => Navigator.pop(context),
                  ),

                  const SizedBox(width: 4),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.appBar,
                        ),

                        Text(
                          subtitle ?? '',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
