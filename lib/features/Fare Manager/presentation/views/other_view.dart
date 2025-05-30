import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaliha_3alina/shared/ds.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:khaliha_3alina/shared/custom_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/shared/custom_tap_to_expand.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/riders_table.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/custom_button.dart';
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
  final List<int> selectedSeats = [];

  @override
  void dispose() {
    farePerPersonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        actions: [
          Image.asset(
            'lib/core/assets/images/Flutter Icon.png',
            height: double.infinity,
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text(
          'أخري',
          style: AppTextStyles.font20BlackBold.copyWith(fontSize: 25.sp),
        ),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTapToExpand(
                  title: 'طريقة استخدام التطبيق',
                  content:
                      '- أول حاجة، هتدخل أجرة الفرد (يعني السواق بياخد كام على الفرد الواحد).\n\n'
                      '- بعدين تبدأ تضيف كل راكب وتقول هو دفع عن كام فرد وقدّم كام جنيه.',
                ),
                verticaalSpacing(16),
                CustomTapToExpand(
                  title: 'تشوف مثال ؟',
                  content:
                      'محمد دفع عن 2 أفراد ودفع 30 جنيه، وسعر الفرد 10 جنيه، يبقى المفروض كان يدفع 20 جنيه، وكده يبقى له باقي 10 جنيه.\n\n'
                      'تقدر تضيف كل راكب بالطريقة دي، والتطبيق هيحسبلك هو عليه فلوس ولا ليه باقي.',
                ),
                verticaalSpacing(32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'اجرة السواق للفرد :',
                      style: AppTextStyles.font20BlackBold,
                    ),
                    SizedBox(width: 16),
                    SizedBox(
                      width: 60.w,
                      child: TextField(
                        controller: farePerPersonController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
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
                        onChanged: (value) {
                          final parsed = double.tryParse(value) ?? 0.0;
                          if (parsed != individualFare) {
                            setState(() {
                              individualFare = parsed;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                verticaalSpacing(16),
                CustomButton(
                  onPressed: () {
                    if (individualFare == 0.0) {
                      Alerts.failureDialog(
                        context: context,
                        title: 'خطأ',
                        message: 'من فضلك ادخل اجرة الفرد',
                      );
                      return;
                    }
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
                                    style: AppTextStyles.font20BlackBold
                                        .copyWith(
                                          fontSize: 25.sp,
                                          color: AppColors.white,
                                        ),
                                  ),
                                ),
                                verticaalSpacing(24),
                                buildLabelAndFieldByVehicleType(
                                  label: 'اجرة الفرد',
                                  controller: farePerPersonController,
                                  isRider: true, // الحقل معطل عشان ما يتغيرش
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
                                  vehicleType: VehicleType.other,
                                  isNumofSeats: true,
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
                                    onPressed: () {
                                      final name =
                                          modalRiderController.text.trim();
                                      final seats =
                                          int.tryParse(
                                            modalNumSeatsController.text.trim(),
                                          ) ??
                                          0;
                                      final amount =
                                          double.tryParse(
                                            modalAmountPaidController.text
                                                .trim(),
                                          ) ??
                                          0.0;

                                      if (name.isEmpty ||
                                          seats == 0 ||
                                          amount == 0.0) {
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
                                    buttonText: 'إضافة',
                                  ),
                                ),
                                verticaalSpacing(16),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                  buttonText: 'إضافة راكب',
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
