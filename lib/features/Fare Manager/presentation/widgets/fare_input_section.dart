import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/ds.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FareInputSection extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const FareInputSection({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('اجرة السواق للفرد :', style: AppTextStyles.font20BlackBold),
        horizentalSpacing(16),
        SizedBox(
          width: 80.w,
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: onChanged,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: AppColors.primary),
              ),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            inputFormatters: [
              DecimalTextInputFormatter(
                maxDigitsBeforeDecimal: 3,
                maxDigitsAfterDecimal: 2,
              ),
            ],
            textAlign: TextAlign.center,
            style: AppTextStyles.font20BlackBold.copyWith(
              fontSize: 17.sp,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }
}
