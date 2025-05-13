import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/core/theme/font_wieght.dart';


class AppTextStyles{
  static TextStyle font17WhiteMedium = GoogleFonts.marhey(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.white
  );
  static TextStyle font17BlackMedium = GoogleFonts.marhey(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.medium,
    color: AppColors.black
  );
  static TextStyle font17BlackRegular = GoogleFonts.marhey(
    fontSize: 17.sp,
    fontWeight: FontWeightHelper.regular,
    color: AppColors.black
  );
  static TextStyle font20BlackBold = GoogleFonts.marhey(
    fontSize: 20.sp,
    fontWeight: FontWeightHelper.bold,
    color: AppColors.black
  );
} 