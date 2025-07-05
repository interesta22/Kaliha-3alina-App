import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaliha_3alina/shared/spacing.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/data/models/enum.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/logic/read_cubit.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/logic/write_cubit.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/trip_widget.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/riders_table.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/widgets/trip_filter_chips.dart';

class TripsView extends StatefulWidget {
  const TripsView({super.key});

  @override
  State<TripsView> createState() => _TripsViewState();
}

class _TripsViewState extends State<TripsView> {
  VehicleFilter _selectedFilter = VehicleFilter.all;
  Set<int> _selectedRideIndexes = {};

  @override
  void initState() {
    super.initState();
    final readCubit = ReadCubit.get(context);
    readCubit.setVehicleFilter(_selectedFilter);
    readCubit.getRides();
  }

  String getVehicleTypeName(VehicleType type) {
    switch (type) {
      case VehicleType.microbus:
        return 'مشروع';
      case VehicleType.suzuki:
        return 'توناية';
      case VehicleType.other:
        return 'وسائل أخرى';
    }
  }

  @override
  Widget build(BuildContext context) {
    final readCubit = ReadCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        leading: IconButton(
          onPressed: () {
            if (_selectedRideIndexes.isNotEmpty) {
              setState(() => _selectedRideIndexes.clear());
            } else {
              Navigator.pop(context);
            }
          },
          icon: Icon(
            _selectedRideIndexes.isNotEmpty
                ? CupertinoIcons.clear_circled_solid
                : Icons.arrow_back_ios_new,
          ),
        ),
        title:
            _selectedRideIndexes.isEmpty
                ? Text('رحلاتي السابقة', style: AppTextStyles.font20BlackBold)
                : Text(
                  '${_selectedRideIndexes.length} محدد',
                  style: AppTextStyles.font20BlackBold.copyWith(
                    color: AppColors.primary,
                  ),
                ),
        actions:
            _selectedRideIndexes.isEmpty
                ? null
                : [
                  IconButton(
                    icon: Icon(
                      _selectedRideIndexes.length ==
                              (readCubit.state is ReadSuccess
                                  ? (readCubit.state as ReadSuccess)
                                      .ridesList
                                      .length
                                  : 0)
                          ? CupertinoIcons
                              .check_mark_circled_solid // الكل متحدد
                          : CupertinoIcons.check_mark_circled, // مش الكل متحدد
                      size: 20,
                      color: AppColors.primary,
                    ),
                    onPressed: () {
                      final state = readCubit.state;
                      if (state is ReadSuccess) {
                        final count = state.ridesList.length;

                        setState(() {
                          if (_selectedRideIndexes.length == count) {
                            // الكل متحدد → نلغي التحديد
                            _selectedRideIndexes.clear();
                          } else {
                            // مش الكل متحدد → نحدد الكل
                            _selectedRideIndexes = Set<int>.from(
                              List.generate(count, (i) => i),
                            );
                          }
                        });
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.delete,
                      size: 20,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      final state = readCubit.state;
                      if (state is ReadSuccess) {
                        final ridesList = state.ridesList;
                        final selectedRides =
                            _selectedRideIndexes
                                .map((index) => ridesList[index])
                                .toList();

                        // نعرض الديالوج الأول
                        showDialog(
                          context: context,
                          builder:
                              (context) => AlertDialog(
                                title: Text(
                                  'تأكيد الحذف',
                                  style: AppTextStyles.font20BlackBold.copyWith(
                                    color: AppColors.primary,
                                  ),
                                ),
                                content: Text(
                                  'هل أنت متأكد من حذف ${selectedRides.length} مشوار؟ لا يمكن التراجع عن هذا الإجراء.',
                                  style: AppTextStyles.font17BlackMedium
                                      .copyWith(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text(
                                      'إلغاء',
                                      style: AppTextStyles.font17BlackMedium
                                          .copyWith(color: AppColors.primary),
                                    ),
                                    onPressed:
                                        () => Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                    child: Text(
                                      'حذف',
                                      style: AppTextStyles.font17BlackMedium
                                          .copyWith(color: Colors.red),
                                    ),
                                    onPressed: () {
                                      WriteCubit.get(
                                        context,
                                      ).deleteMultipleRides(selectedRides);
                                      setState(
                                        () => _selectedRideIndexes.clear(),
                                      );
                                      readCubit.getRides();
                                      Navigator.of(context).pop();
                                      // نغلق الديالوج بعد التنفيذ
                                    },
                                  ),
                                ],
                              ),
                        );
                      }
                    },
                  ),
                ],
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Column(
            children: [
              TripFilterChips(
                selectedFilter: _selectedFilter,
                onFilterSelected: (selectedFilter) {
                  setState(() {
                    _selectedFilter = selectedFilter;
                    _selectedRideIndexes.clear(); // Clear selection
                  });
                  readCubit.setVehicleFilter(selectedFilter);
                  readCubit.getRides();
                },
              ),
              verticaalSpacing(10.h),
              Expanded(
                child: BlocBuilder<ReadCubit, ReadState>(
                  builder: (context, state) {
                    if (state is ReadLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ReadSuccess) {
                      final ridesList = state.ridesList;
                      if (ridesList.isEmpty) {
                        return Center(
                          child: Text(
                            'لا توجد رحلات سابقة',
                            style: AppTextStyles.font17BlackMedium,
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: ridesList.length,
                        itemBuilder: (context, index) {
                          final ride = ridesList[index];
                          final isSelected = _selectedRideIndexes.contains(
                            index,
                          );
                          return GestureDetector(
                            onLongPress: () {
                              setState(() {
                                isSelected
                                    ? _selectedRideIndexes.remove(index)
                                    : _selectedRideIndexes.add(index);
                              });
                            },
                            child: Opacity(
                              opacity: isSelected ? 0.5 : 1.0,
                              child: TripWidget(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'مشوار رقم ${ride.indexAtDB + 1}  |  ${getVehicleTypeName(ride.vehicleType)}',
                                      style: AppTextStyles.font20BlackBold
                                          .copyWith(
                                            color: AppColors.white,
                                            fontSize: 18.sp,
                                          ),
                                    ),
                                    verticaalSpacing(5),
                                    Text(
                                      ride.date,
                                      style: AppTextStyles.font17BlackMedium
                                          .copyWith(
                                            color: AppColors.white,
                                            fontSize: 16.sp,
                                          ),
                                    ),
                                  ],
                                ),
                                content: RidersTable(riders: ride.riders),
                              ),
                            ),
                          );
                        },
                      );
                    } else if (state is ReadEmpty) {
                      return Center(
                        child: Text(
                          'لا توجد رحلات سابقة',
                          style: AppTextStyles.font17BlackMedium,
                        ),
                      );
                    } else if (state is ReadFailed) {
                      return Center(
                        child: Text(
                          'حدث خطأ أثناء تحميل الرحلات: ${state.errorMessage}',
                          style: AppTextStyles.font17BlackMedium,
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
