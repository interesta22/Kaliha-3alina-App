import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/home/presentation/widgets/car_card.dart';
import 'package:khaliha_3alina/features/home/presentation/widgets/custom_app_bar.dart';
import 'package:khaliha_3alina/features/How%20to%20Go/presentation/views/how_to_go_view.dart';

Widget buildMainScreen(final controller) {
  final options = [
    {
      'title': 'مشروع',
      'icon': 'lib/core/assets/images/pngwing.com (1).png',
      'type': 'project',
    },
    {
      'title': 'توناية',
      'icon':
          'lib/core/assets/images/big-up_0dcbd839b49d7d08f1bfce6c436b8a3f-removebg-preview.png',
      'type': 'tonaya',
    },
    {
      'title': 'وسائل أخرى',
      'icon': 'lib/core/assets/images/19733-removebg-preview.png',
      'type': 'other',
    },
  ];
  void toggleMenu() {
    controller.toggle!();
    HapticFeedback.selectionClick();
  }

  return Scaffold(
    appBar: CustomAppBar(onMenuPressed: toggleMenu),
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'راكب ايه؟',
                  style: AppTextStyles.font20BlackBold.copyWith(
                    fontSize: 24.sp,
                    color: AppColors.secondary,
                  ),
                ),
                SizedBox(width: 8.w), // مسافة بسيطة بين النص والصورة
                Image.asset(
                  'lib/core/assets/images/Curious-pana.png',
                  height: 160.h, // صغّر الحجم عشان يبقى مناسب جنب النص
                ),
              ],
            ),

            SizedBox(height: 20.h),
            Expanded(
              child: ListView.separated(
                itemCount: options.length + 1,
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  if (index == options.length) {
                    // ده العنصر الأخير - زرار InkWell
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0.h),
                        child: InkWell(
                          onTap:
                              () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HowToGoView(),
                                ),
                              ),
                          borderRadius: BorderRadius.circular(20.r),
                          child: Text(
                            'لسه مش عارف تروح المكان ازاي؟',
                            style: AppTextStyles.font20BlackBold.copyWith(
                              fontSize: 20.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }

                  final option = options[index];
                  return CarCard(option: option);
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
