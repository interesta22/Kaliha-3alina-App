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
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/seats.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/riders_table.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/custom_button.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/builld_label_and_field.dart';

class MicrobusView extends StatefulWidget {
  const MicrobusView({super.key});

  @override
  State<MicrobusView> createState() => _MicrobusViewState();
}

class _MicrobusViewState extends State<MicrobusView> {
  List<RiderModel> riders = [];
  double individualFare = 0.0;
  final farePerPersonController = TextEditingController();
  List<int> selectedSeats = [];
  String? selectedSeat;

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
          'اجرة المشروع',
          style: AppTextStyles.font20BlackBold.copyWith(fontSize: 25.sp),
        ),
        backgroundColor: AppColors.background,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
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
                      'محمد دفع عن 3 أفراد ودفع 20 جنيه، وسعر الفرد 3 جنيه، يبقى المفروض كان يدفع 9 جنيه، وكده يبقى له باقي 11 جنيه.\n\n'
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
                      width: 80.w,
                      child: TextField(
                        controller: farePerPersonController,
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
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
                verticaalSpacing(24),
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

                    // انشئ TextEditingControllers خاصة بالمودال عشان ما تأثرش على الصفحة الرئيسية
                    final modalFareController = TextEditingController(
                      text: individualFare.toStringAsFixed(2),
                    );
                    final modalRiderController = TextEditingController();
                    final modalNumSeatsController = TextEditingController();
                    final modalAmountPaidController = TextEditingController();
                    String? modalSelectedSeat;

                    showModalBottomSheet(
                      backgroundColor: AppColors.primary,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(
                          builder: (context, setModalState) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
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
                                        style: AppTextStyles.font20BlackBold
                                            .copyWith(
                                              fontSize: 23.sp,
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                    verticaalSpacing(16),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Seats(
                                          vehicleType: VehicleType.microbus,
                                          onSeatToggle: (index) {
                                            if (modalSelectedSeat !=
                                                index.toString()) {
                                              setModalState(() {
                                                modalSelectedSeat =
                                                    index.toString();
                                                modalRiderController.text =
                                                    modalSelectedSeat!;
                                              });
                                            }
                                          },
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              buildLabelAndFieldByVehicleType(
                                                label: 'اجرة الفرد',
                                                controller: modalFareController,
                                                vehicleType:
                                                    VehicleType.microbus,
                                                isNumber: true,
                                                isDisabled: true,
                                              ),
                                              verticaalSpacing(12),
                                              buildLabelAndFieldByVehicleType(
                                                label: 'اسم / رقم الراكب',
                                                controller:
                                                    modalRiderController,
                                                vehicleType:
                                                    VehicleType.microbus,
                                                isRider: true,
                                                isDisabled: true,
                                              ),
                                              verticaalSpacing(12),
                                              buildLabelAndFieldByVehicleType(
                                                label: 'دفع كام فرد',
                                                controller:
                                                    modalNumSeatsController,
                                                vehicleType:
                                                    VehicleType.microbus,
                                                isNumber: true,
                                                isNumofSeats: true,
                                              ),
                                              verticaalSpacing(12),
                                              buildLabelAndFieldByVehicleType(
                                                label: 'دفع كام',
                                                controller:
                                                    modalAmountPaidController,
                                                vehicleType:
                                                    VehicleType.microbus,
                                                isNumber: true,
                                              ),
                                              verticaalSpacing(16),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: CustomButton(
                                        backgroundColor: AppColors.white,
                                        buttonText: 'إضافة',
                                        onPressed: () {
                                          final name =
                                              modalRiderController.text.trim();
                                          final seats =
                                              int.tryParse(
                                                modalNumSeatsController.text
                                                    .trim(),
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
                                              message:
                                                  'من فضلك املأ كل البيانات',
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
                      },
                    );
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
