import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/providers/theme_provider.dart';
import 'package:medical_herb/core/theme/app_colors.dart';
import 'package:medical_herb/features/screens/widgets/screen_guide_bottom_sheet.dart';
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
        ? Colors.black.withValues(alpha: 0.3)
        : Colors.black.withValues(alpha: 0.03);

    final topBarBg = isDark
        ? const Color(0xFF1a2e1a)
        : AppColors.containerColorGreen;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: topBarBg,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: topBarBg,
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
                    color: isDark ? Colors.white : colorScheme.onSurface,
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
                    color: isDark
                        ? Colors.white70
                        : colorScheme.onSurface.withValues(alpha: 0.6),
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

              GestureDetector(
                onTap: () => ScanGuideBottomSheet.show(context),
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.help_outline_rounded,
                    color: Colors.green,
                    size: 20,
                  ),
                ),
              ),

              const SizedBox(width: 8),

              // Theme toggle
              GestureDetector(
                onTap: () => context.read<ThemeProvider>().toggleTheme(),
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
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
                      _showAboutDialog(context);
                      break;
                    case 'contact':
                      _showContactDialog(context);
                      break;
                    case 'rate':
                      _showRateDialog(context);
                      break;
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: colorScheme.surface,
                elevation: 4,
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'about',
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, size: 20),
                        SizedBox(width: 12),
                        Text('About App'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: 'contact',
                    child: Row(
                      children: [
                        Icon(Icons.mail_outline, size: 20),
                        SizedBox(width: 12),
                        Text('Contact Us'),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem(
                    value: 'rate',
                    child: Row(
                      children: [
                        Icon(Icons.star_outline, size: 20),
                        SizedBox(width: 12),
                        Text('Rate Us'),
                      ],
                    ),
                  ),
                ],
                child: Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: Colors.green.withValues(alpha: 0.15),
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

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Image.asset(AppImages.mediLeafLogo, height: 32, width: 32),
            const SizedBox(width: 12),
            const Text('AyurVision'),
          ],
        ),
        content: const SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AyurVision is an intelligent medicinal herb identification app. Simply capture or upload a photo of any herb, and AyurVision will instantly identify it, providing detailed information about its medicinal properties, benefits, side effects, and botanical classification.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
              SizedBox(height: 16),
              Text(
                'Explore a database of 24+ medicinal herbs, save your favorites, and build your personal herb knowledge collection — all in one place.',
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.mail_outline),
            SizedBox(width: 12),
            Text('Contact Us'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Have questions, feedback, or suggestions? We\'d love to hear from you!',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Text(
              'Email: support@medileaf.app',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showRateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Row(
          children: [
            Icon(Icons.star_outline, color: Colors.amber),
            SizedBox(width: 12),
            Text('Rate Us'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.construction, size: 48, color: Colors.orange),
            SizedBox(height: 16),
            Text(
              'MediLeaf is coming soon to the App Store and Google Play! Stay tuned — once we launch, we\'d love for you to rate and review the app.',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }
}