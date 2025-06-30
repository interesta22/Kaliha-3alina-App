import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final String buttonText;
  final VoidCallback onPressed;

  static const Color defaultBackgroundColor = AppColors.primary;

  const CustomButton({
    super.key,
    this.backgroundColor = defaultBackgroundColor,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final Color effectiveBackgroundColor =
        backgroundColor ?? defaultBackgroundColor;
    final bool isPrimary = effectiveBackgroundColor == AppColors.primary;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: effectiveBackgroundColor,
        foregroundColor: isPrimary ? Colors.white : AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        textStyle: AppTextStyles.font20BlackBold.copyWith(
          color: isPrimary ? Colors.white : AppColors.primary,
          fontSize: 19.sp,
          fontWeight: FontWeight.w600,
        ),
        elevation: 2,
      ),
      child: Text(buttonText),
    );
  }
}
