// import 'seats.dart';
// import 'custom_button.dart';
// import 'builld_label_and_field.dart';
// import 'package:flutter/material.dart';
// import '../../data/models/vehicle_Type.dart';
// import 'package:khaliha_3alina/shared/spacing.dart';
// import 'package:khaliha_3alina/core/theme/colors.dart';
// import 'package:khaliha_3alina/core/theme/text_style.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';





// Future<dynamic> BottomSheet(BuildContext context, String? modalSelectedSeat, TextEditingController modalRiderController, TextEditingController modalFareController, TextEditingController modalNumSeatsController, TextEditingController modalAmountPaidController) {
//     return showModalBottomSheet(
//                     backgroundColor: AppColors.primary,
//                     isScrollControlled: true,
//                     context: context,
//                     builder: (context) {
//                       return StatefulBuilder(
//                         builder: (context, setModalState) {
//                           return Padding(
//                             padding: EdgeInsets.only(
//                               bottom:
//                                   MediaQuery.of(context).viewInsets.bottom,
//                               left: 16,
//                               right: 16,
//                               top: 16,
//                             ),
//                             child: SingleChildScrollView(
//                               child: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Center(
//                                     child: Text(
//                                       'إضافة راكب',
//                                       style: AppTextStyles.font20BlackBold
//                                           .copyWith(
//                                             fontSize: 23.sp,
//                                             color: Colors.white,
//                                           ),
//                                     ),
//                                   ),
//                                   verticaalSpacing(16),
//                                   Row(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Seats(
//                                         vehicleType: VehicleType.microbus,
//                                         onSeatToggle: (index) {
//                                           if (modalSelectedSeat !=
//                                               index.toString()) {
//                                             setModalState(() {
//                                               modalSelectedSeat =
//                                                   index.toString();
//                                               modalRiderController.text =
//                                                   modalSelectedSeat!;
//                                             });
//                                           }
//                                         },
//                                       ),
//                                       Expanded(
//                                         child: Column(
//                                           children: [
//                                             buildLabelAndFieldByVehicleType(
//                                               label: 'اجرة الفرد',
//                                               controller: modalFareController,
//                                               vehicleType:
//                                                   VehicleType.microbus,
//                                               isNumber: true,
//                                               isRider: true,
//                                             ),
//                                             verticaalSpacing(12),
//                                             buildLabelAndFieldByVehicleType(
//                                               label: 'اسم / رقم الراكب',
//                                               controller:
//                                                   modalRiderController,
//                                               vehicleType:
//                                                   VehicleType.microbus,
//                                               isRider: true,
//                                             ),
//                                             verticaalSpacing(12),
//                                             buildLabelAndFieldByVehicleType(
//                                               label: 'دفع كام فرد',
//                                               controller:
//                                                   modalNumSeatsController,
//                                               vehicleType:
//                                                   VehicleType.microbus,
//                                               isNumber: true,
//                                               isNumofSeats: true,
//                                             ),
//                                             verticaalSpacing(12),
//                                             buildLabelAndFieldByVehicleType(
//                                               label: 'دفع كام',
//                                               controller:
//                                                   modalAmountPaidController,
//                                               vehicleType:
//                                                   VehicleType.microbus,
//                                               isNumber: true,
//                                             ),
//                                             verticaalSpacing(16),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   Center(
//                                     child: CustomButton(
//                                       backgroundColor: AppColors.white,
//                                       buttonText: 'إضافة',
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                       },
//                                     ),
//                                   ),
//                                   verticaalSpacing(16),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       );
//                     },
//                   );
//   }