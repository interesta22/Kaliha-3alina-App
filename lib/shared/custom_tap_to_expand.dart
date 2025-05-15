import 'package:flutter/material.dart';
import 'package:tap_to_expand/tap_to_expand.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTapToExpand extends StatelessWidget {
  const CustomTapToExpand({
    super.key,
    required this.title,
    required this.content,
  });
  final String title;
  final String content;
  @override
  Widget build(BuildContext context) {
    return TapToExpand(
      duration: Duration(milliseconds: 300),
      borderRadius: BorderRadius.circular(20),
      width: double.infinity,
      backgroundcolor: AppColors.primary,
      title: Text(
        title,
        style: AppTextStyles.font17BlackRegular.copyWith(
          fontSize: 16.sp,
          color: AppColors.white,
        ),
      ),
      content: Text(
        content,
        style: AppTextStyles.font17BlackRegular.copyWith(
          fontSize: 15.sp,
          color: AppColors.white,
        ),
      ),
    );
  }
}
