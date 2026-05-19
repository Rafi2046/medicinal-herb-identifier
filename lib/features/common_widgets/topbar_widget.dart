import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/providers/theme_provider.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:provider/provider.dart';

class TopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenuIcon;
  final bool resetForm;
  final VoidCallback? onPopOut;
  final bool? backArrow;
  final String subtitle;

  static const double _toolbarHeight = 65;

  const TopBarWidget({
    super.key,
    required this.title,
    required this.subtitle,
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
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    final shadowColor = isDark
        ? Colors.black.withOpacity(0.3)
        : Colors.black.withOpacity(0.03);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.containerColorGreen,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: AppColors.containerColorGreen,
        border: const Border(bottom: BorderSide(color: Colors.teal, width: 2)),
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
      height: statusBarHeight + _toolbarHeight,
      child: Padding(
        padding: EdgeInsets.only(top: statusBarHeight),
        child: SizedBox(
          height: _toolbarHeight,
          child: showBack
              ? _buildBackBar(context, colorScheme)
              : _buildMainBar(context, colorScheme, isDark),
        ),
      ),
    );
  }

  Widget _buildBackBar(BuildContext context, ColorScheme colorScheme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: resetForm && onPopOut != null
              ? onPopOut
              : () => Navigator.maybePop(context),
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildMainBar(
    BuildContext context,
    ColorScheme colorScheme,
    bool isDark,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // LOGO
          Image.asset(
            AppImages.mediLeafLogo,
            height: 44,
            width: 44,
            fit: BoxFit.contain,
            filterQuality: FilterQuality.medium,
          ),

          const SizedBox(width: 8),

          // TITLE + SUBTITLE
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onSurface,
                    height: 1.2,
                  ),
                ),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: colorScheme.onSurface.withOpacity(0.6),
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),

          // RIGHT ICONS
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Theme toggle
              // Theme toggle
              GestureDetector(
                onTap: () => context.read<ThemeProvider>().toggleTheme(),
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    context.watch<ThemeProvider>().isDark
                        ? Icons.light_mode
                        : Icons.dark_mode,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'about':
                      break;
                    case 'settings':
                      break;
                    case 'rate':
                      break;
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: colorScheme.surface,
                elevation: 4,
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'about',
                    child: Text(
                      'About App',
                      style: TextStyle(
                        fontSize: 15,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'settings',
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 15,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'rate',
                    child: Text(
                      'Rate Us',
                      style: TextStyle(
                        fontSize: 15,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.more_vert,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
