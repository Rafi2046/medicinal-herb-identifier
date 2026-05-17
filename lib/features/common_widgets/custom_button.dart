import 'package:flutter/material.dart';
import 'package:medical_herb/core/constants/app_images.dart';
import 'package:medical_herb/core/constants/app_spacing.dart';
import 'package:medical_herb/core/constants/app_text_styles.dart';
import 'package:medical_herb/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color? textColor;
  final Widget? icon;
  final bool trailIcon;
  final bool leadingIcon;
  final Widget? trailing;
  final Widget? leading;
  final bool showBorder;
  final Color? borderColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.backgroundColor = const Color(0xFF198740),
    this.textColor,
    this.leadingIcon = false,
    this.trailIcon = false,
    this.leading,
    this.trailing,
    this.showBorder = false,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.h50,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: showBorder
                  ? borderColor ?? AppColors.primaryColor
                  : Colors.transparent,
            ),
            color: backgroundColor,
            borderRadius: BorderRadius.circular(AppSpacing.br12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.p4),
                  child: leading!,
                ),
              if (leadingIcon)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.p4),
                  child: Image.asset(
                    AppImages.arrowbackIcon,
                    height: AppSpacing.h16,
                  ),
                ),
              Text(text, style: AppTextStyles.buttonWhite.copyWith(color: textColor)),
              if (trailIcon)
                Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.p4),
                  child: Image.asset(
                    AppImages.arrowNextIcon,
                    height: AppSpacing.h16,
                  ),
                ),
              if (trailing != null)
                Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.p4),
                  child: trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
