import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final String buttonText;
  final VoidCallback onPressed;
  static const Color defaultBackgroundColor = Color(0xFF2DAA9E);
  const CustomButton({super.key, this.backgroundColor = defaultBackgroundColor, required this.buttonText, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor ?? Color(0xFF2DAA9E), // اللون المطلوب
                    foregroundColor: (backgroundColor == Color(0xFF2DAA9E)) ? Colors.white : Color(0xFF2DAA9E), // لون النص
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        16,
                      ), // زوايا مش دائرية
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    textStyle: (backgroundColor == Color(0xFF2DAA9E)) ?
                    AppTextStyles.font20BlackBold.copyWith(
                      color: AppColors.white,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                    ) : AppTextStyles.font20BlackBold.copyWith(
                      color: Color(0xFF2DAA9E),
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: onPressed,
                  child: Text(buttonText),
                );
  }
}