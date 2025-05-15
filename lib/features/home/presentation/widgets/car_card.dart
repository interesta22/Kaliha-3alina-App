import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:khaliha_3alina/features/Fare%20Manager/presentation/views/vehicle_view.dart';

class CarCard extends StatelessWidget {
  final Map<String, dynamic> option;

  const CarCard({super.key, required this.option});

  void _navigateToDetails(BuildContext context, String type) {
    Navigator.of(context).push(_createRoute(type));
  }

  Route _createRoute(String type) {
    const beginLeft = Offset(-1.0, 0.0);
    const beginBottom = Offset(0.0, 1.0);
    const beginFade = Offset(0.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.easeInOut;

    Offset begin;
    switch (type) {
      case 'project':
        begin = beginLeft;
        break;
      case 'tonaya':
        begin = beginBottom;
        break;
      case 'other':
        begin = beginFade;
        break;
      default:
        begin = beginLeft;
    }

    return PageRouteBuilder(
      pageBuilder:
          (context, animation, secondaryAnimation) => VehicleView(type: type),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        if (begin == beginFade) {
          final fadeTween = Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).chain(CurveTween(curve: curve));
          return FadeTransition(
            opacity: animation.drive(fadeTween),
            child: child,
          );
        } else {
          final slideTween = Tween<Offset>(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(slideTween),
            child: child,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20.r),
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.r),
        onTap: () => _navigateToDetails(context, option['type']!.toString()),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xff2DAA9E), Color(0xff66D2CE)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.15),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
          child: Row(
            children: [
              Container(
                width: 90.w,
                height: 90.h,
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Image.asset(
                  option['icon'] as String,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: Text(
                  option['title']!.toString(),
                  style: AppTextStyles.font17BlackMedium.copyWith(
                    fontSize: 20.sp,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
