import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:khaliha_3alina/shared/custom_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/riders_table.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/custom_button.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/fare_input_section.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/usage_tips_section.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/builld_label_and_field.dart';

class OtherView extends StatefulWidget {
  const OtherView({super.key});

  @override
  State<OtherView> createState() => _OtherViewState();
}

class _OtherViewState extends State<OtherView> {
  double individualFare = 0.0;
  List<RiderModel> riders = [];
  final farePerPersonController = TextEditingController();

  @override
  void dispose() {
    farePerPersonController.dispose();
    super.dispose();
  }

  void _showAddRiderModal() {
    final modalRiderController = TextEditingController();
    final modalNumSeatsController = TextEditingController();
    final modalAmountPaidController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.primary,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'اضافة راكب',
                    style: AppTextStyles.font20BlackBold.copyWith(
                      fontSize: 25.sp,
                      color: AppColors.white,
                    ),
                  ),
                ),
                verticaalSpacing(24),
                buildLabelAndFieldByVehicleType(
                  label: 'اجرة الفرد',
                  controller: farePerPersonController,
                  isRider: true,
                  isNumber: true,
                  vehicleType: VehicleType.other,
                ),
                verticaalSpacing(12),
                buildLabelAndFieldByVehicleType(
                  label: 'اسم / رقم الراكب',
                  controller: modalRiderController,
                  isNumber: false,
                  isOther: true,
                  vehicleType: VehicleType.other,
                ),
                verticaalSpacing(12),
                buildLabelAndFieldByVehicleType(
                  label: 'دفع كام فرد',
                  controller: modalNumSeatsController,
                  isNumber: true,
                  min: 1,
                  isNumofSeats: true,
                  vehicleType: VehicleType.other,
                ),
                verticaalSpacing(12),
                buildLabelAndFieldByVehicleType(
                  label: 'دفع كام',
                  controller: modalAmountPaidController,
                  isNumber: true,
                  vehicleType: VehicleType.other,
                ),
                verticaalSpacing(24),
                Center(
                  child: CustomButton(
                    backgroundColor: AppColors.white,
                    buttonText: 'إضافة',
                    onPressed: () {
                      final name = modalRiderController.text.trim();
                      final seats =
                          int.tryParse(modalNumSeatsController.text.trim()) ??
                          0;
                      final amount =
                          double.tryParse(
                            modalAmountPaidController.text.trim(),
                          ) ??
                          0.0;

                      if (name.isEmpty || seats == 0 || amount == 0.0) {
                        Alerts.failureDialog(
                          context: context,
                          title: 'خطأ',
                          message: 'من فضلك املأ كل البيانات',
                        );
                        return;
                      }

                      setState(() {
                        riders.add(
                          RiderModel(
                            name: name,
                            seatsPaidFor: seats,
                            amountPaid: amount,
                            farePerPerson: individualFare,
                          ),
                        );
                      });

                      Navigator.pop(context);
                    },
                  ),
                ),
                verticaalSpacing(16),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          actions: [
            Image.asset(
              'lib/core/assets/images/Flutter Icon.png',
              height: double.infinity,
            ),
          ],
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(
            'وسائل أخرى',
            style: AppTextStyles.font20BlackBold.copyWith(fontSize: 23.sp),
          ),
          backgroundColor: AppColors.background,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                UsageTipsSection(),
                verticaalSpacing(32),
                FareInputSection(
                  controller: farePerPersonController,
                  onChanged: (value) {
                    final parsed = double.tryParse(value) ?? 0.0;
                    if (parsed != individualFare) {
                      setState(() {
                        individualFare = parsed;
                      });
                    }
                  },
                ),
                verticaalSpacing(16),
                CustomButton(
                  buttonText: 'ضيف راكب',
                  onPressed: () {
                    if (individualFare == 0.0) {
                      Alerts.failureDialog(
                        context: context,
                        title: 'خطأ',
                        message: 'من فضلك ادخل اجرة الفرد',
                      );
                      return;
                    }
                    _showAddRiderModal();
                  },
                ),
                verticaalSpacing(15),
                if (riders.isNotEmpty) ...[RidersTable(riders: riders)],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
