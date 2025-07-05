import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/core/theme/font_wieght.dart';


abstract class AppTextStyles{
  static TextStyle font17WhiteMedium = TextStyle(
    fontFamily: 'Marhey',
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.white
  );
  static TextStyle font17BlackMedium = TextStyle(
    fontFamily: 'Marhey',
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.black
  );
  static TextStyle font17BlackRegular = TextStyle(
    fontFamily: 'Marhey',
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.black
  );
  static TextStyle font20BlackBold = TextStyle(
    fontFamily: 'Marhey',
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.black
  );
} 