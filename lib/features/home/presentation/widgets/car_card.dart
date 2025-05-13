import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/calculating/presentation/views/calculate_view.dart';

class CarCard extends StatelessWidget {
  final Map<String, dynamic> option;

  const CarCard({super.key, required this.option});

  void _navigateToDetails(BuildContext context, String type) {
    Navigator.of(context).push(_createRoute(type));
  }

  Route _createRoute(String type) {
    return PageRouteBuilder(
      pageBuilder:
          (context, animation, secondaryAnimation) => CalculateView(type: type),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const beginLeft = Offset(-1.0, 0.0);
        const beginBottom = Offset(0.0, 1.0);
        const beginFade = Offset(0.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        Offset begin;
        switch (type) {
          case 'project':
            begin = beginLeft; // Slide from left
            break;
          case 'tonaya':
            begin = beginBottom; // Slide from bottom
            break;
          case 'other':
            begin = beginFade; // Fade only
            break;
          default:
            begin = beginLeft;
        }

        final tween =
            (begin == beginFade)
                ? Tween<double>(
                  begin: 0.0,
                  end: 1.0,
                ).chain(CurveTween(curve: curve))
                : Tween<Offset>(
                  begin: begin,
                  end: end,
                ).chain(CurveTween(curve: curve));

        return (begin == beginFade)
            ? FadeTransition(
              opacity: animation.drive(tween as Animatable<double>),
              child: child,
            )
            : SlideTransition(
              position: animation.drive(tween as Animatable<Offset>),
              child: child,
            );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetails(context, option['type']!.toString()),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        color: AppColors.secondary,
        shadowColor: Colors.black12,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
          child: Row(
            children: [
              Image.asset(
                option['icon'] as String,
                width: 105.w,
                height: 105.h,
              ),
              SizedBox(width: 20.w),
              Text(
                option['title']!.toString(),
                style: AppTextStyles.font17BlackMedium.copyWith(
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
