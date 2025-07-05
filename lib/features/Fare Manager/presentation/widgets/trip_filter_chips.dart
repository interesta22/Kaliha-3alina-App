import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/logic/read_cubit.dart';

class TripFilterChips extends StatelessWidget {
  final VehicleFilter selectedFilter;
  final Function(VehicleFilter) onFilterSelected;

  const TripFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  @override
  Widget build(BuildContext context) {
    final filters = {
      VehicleFilter.all: 'الكل',
      VehicleFilter.microbusOnly: 'مشروع',
      VehicleFilter.suzukiOnly: 'توناية',
      VehicleFilter.otherOnly: 'أخرى',
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          filters.entries.map((entry) {
            final isSelected = entry.key == selectedFilter;
            return GestureDetector(
              onTap: () => onFilterSelected(entry.key),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : AppColors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Text(
                  entry.value,
                  style: AppTextStyles.font17BlackMedium.copyWith(
                    fontSize: 16.sp,
                    color: isSelected ? Colors.white : AppColors.primary,
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            );
          }).toList(),
    );
  }
}
