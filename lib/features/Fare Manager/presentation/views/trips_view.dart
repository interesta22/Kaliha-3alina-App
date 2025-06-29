import 'package:flutter/material.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/trip_widget.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/riders_table.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/trip_filter_chips.dart';

class TripsView extends StatelessWidget {
  TripsView({super.key});

  final List<RiderModel> riders = [
    RiderModel(
      name: 'أحمد',
      farePerPerson: 25.0,
      seatsPaidFor: 2,
      amountPaid: 60.0, // دافع زيادة
    ),
    RiderModel(
      name: 'منى',
      farePerPerson: 25.0,
      seatsPaidFor: 1,
      amountPaid: 20.0, // دافع أقل
    ),
    RiderModel(
      name: 'سامي',
      farePerPerson: 25.0,
      seatsPaidFor: 3,
      amountPaid: 75.0, // دافع تمامًا
    ),
    RiderModel(
      name: 'ياسمين',
      farePerPerson: 25.0,
      seatsPaidFor: 1,
      amountPaid: 30.0, // دافع أكتر شوية
    ),
    RiderModel(
      name: 'خالد',
      farePerPerson: 25.0,
      seatsPaidFor: 2,
      amountPaid: 40.0, // دافع أقل شوية
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        backgroundColor: AppColors.background,
        title: Text('رحلاتي السابقة', style: AppTextStyles.font20BlackBold),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Column(
            children: [
              TripFilterChips(
                onFilterSelected: (selectedFilter) {
                  // هنا الفلترة حسب نوع الرحلة
                },
              ),
              verticaalSpacing(10.h),
              TripWidget(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'الرحلة رقم 12345',
                      style: AppTextStyles.font20BlackBold.copyWith(
                        color: AppColors.white,
                        fontSize: 18.sp,
                      ),
                    ),
                    Text(
                      'الوقت : 4:55 | التاريخ : 24/10',
                      style: AppTextStyles.font17BlackMedium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
                content: RidersTable(riders: riders),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
