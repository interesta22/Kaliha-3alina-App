import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/shared/custom_snackbar.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/custom_button.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/builld_label_and_field.dart';

Future<RiderModel?> showAddRiderModalForOther(BuildContext context, double farePerPerson) async {
  final fareController = TextEditingController(text: farePerPerson.toStringAsFixed(2));
  final nameController = TextEditingController();
  final numSeatsController = TextEditingController();
  final amountPaidController = TextEditingController();

  return await showModalBottomSheet<RiderModel>(
    backgroundColor: AppColors.primary,
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          left: 16,
          right: 16,
          top: 16,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'إضافة راكب',
                  style: AppTextStyles.font20BlackBold.copyWith(
                    fontSize: 23.sp,
                    color: Colors.white,
                  ),
                ),
              ),
              verticaalSpacing(16),
              buildLabelAndFieldByVehicleType(
                label: 'اجرة الفرد',
                controller: fareController,
                vehicleType: VehicleType.other,
                isNumber: true,
                isDisabled: true,
              ),
              verticaalSpacing(12),
              buildLabelAndFieldByVehicleType(
                label: 'اسم / رقم الراكب',
                controller: nameController,
                vehicleType: VehicleType.other,
                isRider: true,
              ),
              verticaalSpacing(12),
              buildLabelAndFieldByVehicleType(
                label: 'دفع كام فرد',
                controller: numSeatsController,
                vehicleType: VehicleType.other,
                isNumber: true,
                isNumofSeats: true,
              ),
              verticaalSpacing(12),
              buildLabelAndFieldByVehicleType(
                label: 'دفع كام',
                controller: amountPaidController,
                vehicleType: VehicleType.other,
                isNumber: true,
              ),
              verticaalSpacing(16),
              CustomButton(
                backgroundColor: AppColors.white,
                buttonText: 'إضافة',
                onPressed: () {
                  final name = nameController.text.trim();
                  final seats = int.tryParse(numSeatsController.text.trim()) ?? 0;
                  final amount = double.tryParse(amountPaidController.text.trim()) ?? 0.0;

                  if (name.isEmpty || seats == 0 || amount == 0.0) {
                    Alerts.failureDialog(
                      context: context,
                      title: 'خطأ',
                      message: 'من فضلك املأ كل البيانات',
                    );
                    return;
                  }

                  final rider = RiderModel(
                    name: name,
                    seatsPaidFor: seats,
                    amountPaid: amount,
                    farePerPerson: farePerPerson,
                  );

                  Navigator.of(context).pop(rider);
                },
              ),
              verticaalSpacing(16),
            ],
          ),
        ),
      );
    },
  );
}
