import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/vehicle_Type.dart';

Widget buildLabelAndFieldByVehicleType({
  required String label,
  required TextEditingController controller,
  required VehicleType vehicleType,
  bool isRider = false,
  bool isNumber = false,
  bool isNumofSeats = false,
  int min = 0,
}) {
  int maxAmount = 10000;

  List<TextInputFormatter> getInputFormatters() {
    if (isRider) {
      // أرقام وحروف بحد أقصى 15
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
              // نرجع القيمة الجديدة بأقصى عدد مسموح
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
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(5),
        TextInputFormatter.withFunction((oldValue, newValue) {
          if (newValue.text.isEmpty) return newValue;
          final intValue = int.tryParse(newValue.text);
          if (intValue != null && intValue <= maxAmount) {
            return newValue;
          }
          return oldValue;
        }),
      ];
    }

    // النص العادي
    return [LengthLimitingTextInputFormatter(15)];
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
            enabled: !isRider,
            controller: controller,
            keyboardType:
                isNumber || isNumofSeats
                    ? TextInputType.number
                    : TextInputType.text,
            inputFormatters: getInputFormatters(),
            style: AppTextStyles.font17BlackRegular.copyWith(
              fontSize: 15.sp,
              color: isRider ? Colors.grey : AppColors.primary,
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
