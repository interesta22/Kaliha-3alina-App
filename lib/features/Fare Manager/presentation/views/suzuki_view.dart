import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/custom_button.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/shared/custom_tap_to_expand.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/vehicle_Type.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/seats.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/builld_label_and_field.dart';

class SuzukiView extends StatefulWidget {
  const SuzukiView({super.key});

  @override
  State<SuzukiView> createState() => _SuzukiViewState();
}

class _SuzukiViewState extends State<SuzukiView> {
  double individualFare = 0.0;
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
          'اجرة السوزوكي',
          style: AppTextStyles.font20BlackBold.copyWith(fontSize: 25.sp),
        ),
        backgroundColor: AppColors.background,
      ),
      body: SafeArea(
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
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 60.w,
                    child: TextField(
                      controller: farePerPersonController,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+(\.\d{0,2})?$'),
                        ),
                      ],
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (value) {
                        final parsed = double.tryParse(value);
                        if (parsed != null && parsed > 0) {
                          setState(() {
                            individualFare = parsed;
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomButton(
                onPressed: (){
                  if (individualFare == 0.0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'من فضلك ادخل أجرة الفرد قبل إضافة راكب',
                          ),
                        ),
                      );
                      return;
                    }
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
            void onSeatToggle(int seatIndex) {
              setModalState(() {
                modalSelectedSeat = seatIndex.toString();
                modalRiderController.text = modalSelectedSeat!;
              });
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                left: 16,
                right: 16,
                top: 16,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'إضافة راكب',
                      style: AppTextStyles.font20BlackBold.copyWith(
                        fontSize: 23.sp,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Seats(
                          vehicleType: VehicleType.suzuki,
                          onSeatToggle: (index) {
                            if (modalSelectedSeat != index.toString()) {
                              onSeatToggle(int.parse(index.toString()));
                            }
                          },
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            children: [
                              buildLabelAndFieldByVehicleType(
                                label: 'اجرة الفرد',
                                controller: farePerPersonController,
                                vehicleType: VehicleType.suzuki,
                                isNumber: true,
                                isRider: true,
                              ),
                              verticaalSpacing(12),
                              buildLabelAndFieldByVehicleType(
                                label: 'اسم / رقم الراكب',
                                controller: modalRiderController,
                                vehicleType: VehicleType.suzuki,
                                isRider: true,
                              ),
                              verticaalSpacing(12),
                              buildLabelAndFieldByVehicleType(
                                label: 'دفع كام فرد',
                                controller: modalNumSeatsController,
                                vehicleType: VehicleType.suzuki,
                                isNumber: true,
                                isNumofSeats: true,
                              ),
                              verticaalSpacing(12),
                              buildLabelAndFieldByVehicleType(
                                label: 'دفع كام',
                                controller: modalAmountPaidController,
                                vehicleType: VehicleType.suzuki,
                                isNumber: true,
                              ),
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
                buttonText: 'إضافة راكب',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
