import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaliha_3alina/shared/ds.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';

Widget buildLabelAndFieldByVehicleType({
  required String label,
  required TextEditingController controller,
  required VehicleType vehicleType,
  TextEditingController? nameController,
  bool isRider = false,
  bool isDisabled = true,
  bool isOther = false,
  bool isNumber = false,
  bool isNumofSeats = false,
  int min = 0,
}) {
  List<TextInputFormatter> getInputFormatters() {
    if (isRider) {
      return [LengthLimitingTextInputFormatter(15)];
    }

    if (isNumofSeats) {
      int maxSeats;
      switch (vehicleType) {
        case VehicleType.microbus:
          maxSeats = 12;
          break;
        case VehicleType.suzuki:
          maxSeats = 6;
          break;
        case VehicleType.other:
          maxSeats = 20;
          break;
      }

      return [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(2),
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (newValue.text.isEmpty) return newValue;
          final intValue = int.tryParse(newValue.text);
          if (intValue != null) {
            if (intValue > maxSeats) {
              return TextEditingValue(
                text: maxSeats.toString(),
                selection: TextSelection.collapsed(
                  offset: maxSeats.toString().length,
                ),
              );
            }
            return newValue;
          }
          return oldValue;
        }),
      ];
    }

    if (isNumber) {
      return [
        DecimalTextInputFormatter(
          maxDigitsBeforeDecimal: 5,
          maxDigitsAfterDecimal: 2,
        ),
      ];
    }

    return [LengthLimitingTextInputFormatter(15)];
  }

  // ✳️ إعداد القيمة الديفولت على حسب النوع
  if (isRider && controller.text.isEmpty) {
    controller.text = 'فلان';
  } else if (isOther) {
    controller.text = 'فلان';
    isDisabled = false; // ✳️ نخليها مقفولة لو مش رايدر
  } else if (!isRider && controller.text.isEmpty) {
    isDisabled = false; // ✳️ نخليها مقفولة لو مش رايدر
  }

  return Row(
    children: [
      SizedBox(
        width: vehicleType == VehicleType.other ? 100.w : 90.w,
        child: Text(
          label,
          style: AppTextStyles.font17BlackRegular.copyWith(
            fontSize: 19.sp,
            color: AppColors.white,
          ),
        ),
      ),
      horizentalSpacing(10),
      Expanded(
        child: SizedBox(
          height: 60.h,
          child: TextField(
            textAlign: TextAlign.center,
            enabled: !isDisabled,
            controller: controller,
            keyboardType:
                isNumber || isNumofSeats
                    ? TextInputType.number
                    : TextInputType.text,
            inputFormatters: getInputFormatters(),
            style: AppTextStyles.font17BlackRegular.copyWith(
              fontSize: 15.sp,
              color: isDisabled ? Colors.grey : AppColors.primary,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
