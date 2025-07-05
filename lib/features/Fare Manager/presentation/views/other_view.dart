import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/shared/custom_snackbar.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/logic/read_cubit.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/logic/write_cubit.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/ride_model.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/riders_table.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/custom_button.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/fare_input_section.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/usage_tips_section.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/other_show_model_rider.dart';

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

  Future<void> _addRider() async {
    final rider = await showAddRiderModalForOther(context, individualFare);
    if (rider != null) {
      setState(() => riders.add(rider));
    }
  }

  void _saveRide() {
    final readCubit = BlocProvider.of<ReadCubit>(context, listen: false);
    final writeCubit = BlocProvider.of<WriteCubit>(context, listen: false);

    List<RideModel> rides = [];
    if (readCubit.state is ReadSuccess) {
      rides = (readCubit.state as ReadSuccess).ridesList;
    }

    final tripNumber = rides.length + 1;
    final ride = RideModel(
      indexAtDB: tripNumber,
      date: DateFormat('dd/MM/yyyy | hh:mm a').format(DateTime.now()),
      riders: riders,
      vehicleType: VehicleType.other,
    );

    writeCubit.addRide(ride);

    setState(() {
      riders = [];
      farePerPersonController.clear();
      individualFare = 0.0;
    });

    Alerts.successDialog(
      context: context,
      title: 'تم الحفظ',
      message: 'تم حفظ الرحلة بنجاح',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.background,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          title: Text(
            'أجرة وسائل أخرى',
            style: AppTextStyles.font20BlackBold.copyWith(fontSize: 23.sp),
          ),
          actions: [
            Image.asset(
              'lib/core/assets/images/Flutter Icon.png',
              height: double.infinity,
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
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
                      setState(() => individualFare = parsed);
                    }
                  },
                ),
                verticaalSpacing(16),
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
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
                          _addRider();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(
                        Icons.save,
                        color: AppColors.primary,
                        size: 32,
                      ),
                      onPressed: riders.isEmpty ? null : _saveRide,
                    ),
                  ],
                ),
                verticaalSpacing(15),
                if (riders.isNotEmpty) RidersTable(riders: riders),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
