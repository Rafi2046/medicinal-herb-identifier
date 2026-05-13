import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class TopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showMenuIcon;
  final bool resetForm;
  final VoidCallback? onPopOut;
  final bool? backArrow;
  final String subtitle;

  static const double _toolbarHeight = 65;
  static const double _logoSize = 60;
  static const double _logoAlphabeticBaselineFromTop = _logoSize * 0.90;

  static const double _leadingWidth = 100;

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
    final titleStyle = AppTextStyles.appbarTitle;
    final bool showBack = backArrow == true;

    return AppBar(
      scrolledUnderElevation: 0,
      elevation: 0,
      backgroundColor: AppColors.white,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.white,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      toolbarHeight: _toolbarHeight,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
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
          ? Text(title, style: titleStyle)
          : Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Baseline(
                  baseline: _logoAlphabeticBaselineFromTop,
                  baselineType: TextBaseline.alphabetic,
                  child: SizedBox(
                    height: _logoSize,
                    width: _logoSize,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Image.asset(
                        AppImages.mediLeafLogo,
                        height: 55,
                        width: 55,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: titleStyle.copyWith(height: 1.0),
                    ),

                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.subtitle,
                    ),
                  ],
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image(image: AssetImage(AppImages.darkLight,),height: AppSpacing.h40,width: AppSpacing.w40,),
                    Image(image: AssetImage(AppImages.threeDot,),height: AppSpacing.h40,width: AppSpacing.w40,),
                  ],
                )
                
              ],
            ),
    );
  }
}
