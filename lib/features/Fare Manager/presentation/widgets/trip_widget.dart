import 'package:flutter/material.dart';
import 'package:tap_to_expand/tap_to_expand.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TripWidget extends StatelessWidget {
  const TripWidget({super.key, required this.title, required this.content});
  final Widget title;
  final Widget content;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: TapToExpand(
        duration: Duration(milliseconds: 300),
        borderRadius: BorderRadius.circular(20),
        width: double.infinity,
        backgroundcolor: AppColors.primary,
        title: title,
        content: content,
      ),
    );
  }
}
