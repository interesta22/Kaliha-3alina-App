import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/rider_model.dart';

class RidersTable extends StatelessWidget {
  const RidersTable({super.key, required this.riders});

  final List<RiderModel> riders;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.background, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(3),
            2: FlexColumnWidth(3),
            3: FlexColumnWidth(3),
            4: FlexColumnWidth(3),
          },
          border: TableBorder.symmetric(
            inside: BorderSide(color: AppColors.black.withOpacity(0.2)),
          ),
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.3),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  topLeft: Radius.circular(10),
                ),
              ),
              children: [
                headerCell('الراكب'),
                headerCell('دفع لكام واحد'),
                headerCell('اجرته (جم)'),
                headerCell('دفع كام (جم)'),
                headerCell('الباقي (جم)'),
              ],
            ),
            ...riders.map((rider) {
              return TableRow(
                children: [
                  dataCell(rider.name),
                  dataCell('${rider.seatsPaidFor}'),
                  dataCell('${rider.formattedTotalFare}'),
                  dataCell('${rider.formattedAmountPaid}'),
                  dataCell(
                    '${rider.difference > 0 ? '+' : ''}${rider.formattedDifference}',
                    color: rider.difference < 0 ? Colors.red : Colors.green,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget headerCell(String text) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      child: Center(
        child: Text(
          text,
          style: AppTextStyles.font20BlackBold.copyWith(
            color: AppColors.primary,
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }

  Widget dataCell(String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Text(
          text,
          style: AppTextStyles.font20BlackBold.copyWith(
            fontSize: 14.sp,
            color: color ?? Colors.black,
          ),
        ),
      ),
    );
  }
}
