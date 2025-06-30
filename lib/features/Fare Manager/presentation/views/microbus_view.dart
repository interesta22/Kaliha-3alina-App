import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:khaliha_3alina/shared/custom_snackbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/seats.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/riders_table.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/custom_button.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/usage_tips_section.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/fare_input_section.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/builld_label_and_field.dart';

class MicrobusView extends StatefulWidget {
  const MicrobusView({super.key});

  @override
  State<MicrobusView> createState() => _MicrobusViewState();
}

class _MicrobusViewState extends State<MicrobusView> {
  final farePerPersonController = TextEditingController();
  List<RiderModel> riders = [];
  double individualFare = 0.0;

  @override
  void dispose() {
    farePerPersonController.dispose();
    super.dispose();
  }

  void _showAddRiderModal() {
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Seats(
                          vehicleType: VehicleType.microbus,
                          onSeatToggle: (index) {
                            if (modalSelectedSeat != index.toString()) {
                              setModalState(() {
                                modalSelectedSeat = index.toString();
                                modalRiderController.text = modalSelectedSeat!;
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
                                vehicleType: VehicleType.microbus,
                                isNumber: true,
                                isDisabled: true,
                              ),
                              verticaalSpacing(12),
                              buildLabelAndFieldByVehicleType(
                                label: 'اسم / رقم الراكب',
                                controller: modalRiderController,
                                vehicleType: VehicleType.microbus,
                                isRider: true,
                                isDisabled: true,
                              ),
                              verticaalSpacing(12),
                              buildLabelAndFieldByVehicleType(
                                label: 'دفع كام فرد',
                                controller: modalNumSeatsController,
                                vehicleType: VehicleType.microbus,
                                isNumber: true,
                                isNumofSeats: true,
                              ),
                              verticaalSpacing(12),
                              buildLabelAndFieldByVehicleType(
                                label: 'دفع كام',
                                controller: modalAmountPaidController,
                                vehicleType: VehicleType.microbus,
                                isNumber: true,
                              ),
                              verticaalSpacing(16),
                            ],
                          ),
                        ),
                      ],
                    ),
                    CustomButton(
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
                    verticaalSpacing(16),
                  ],
                ),
              ),
            );
          },
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
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(
            'اجرة المشروع',
            style: AppTextStyles.font20BlackBold.copyWith(fontSize: 23.sp),
          ),
          backgroundColor: AppColors.background,
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const UsageTipsSection(),
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
                      _showAddRiderModal();
                    },
                  ),
                  verticaalSpacing(15),
                  if (riders.isNotEmpty) RidersTable(riders: riders),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
