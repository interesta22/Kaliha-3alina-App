import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:khaliha_3alina/features/home/presentation/widgets/car_card.dart';
import 'package:khaliha_3alina/features/home/presentation/widgets/custom_app_bar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ZoomDrawerController _drawerController = ZoomDrawerController();

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
      'title': 'أخري',
      'icon': 'lib/core/assets/images/19733-removebg-preview.png',
      'type': 'other',
    },
  ];

  void toggleMenu() {
    _drawerController.toggle!();
    HapticFeedback.selectionClick();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      menuScreen: buildDrawerContent(),
      mainScreen: buildMainScreen(),
      borderRadius: 24.0,
      isRtl: true,
      showShadow: true,
      mainScreenScale: 0.1,
      angle: 25,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      menuBackgroundColor: AppColors.secondary,
      openCurve: Curves.easeIn,
      closeCurve: Curves.easeOut,
      menuScreenTapClose: true,
      mainScreenTapClose: true,
      drawerShadowsBackgroundColor: Colors.black54,
      style: DrawerStyle.style2, // اختيار الشكل المناسب
    );
  }

  Widget buildMainScreen() {
    return Scaffold(
      appBar: CustomAppBar(onMenuPressed: toggleMenu),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'راكب ايه؟',
                style: AppTextStyles.font20BlackBold.copyWith(
                  fontSize: 22.sp,
                  color: AppColors.dark,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.separated(
                  itemCount: options.length,
                  separatorBuilder: (_, __) => SizedBox(height: 16.h),
                  itemBuilder: (context, index) {
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

  Widget buildDrawerContent() {
    return Scaffold(
      backgroundColor: AppColors.secondary,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.secondary),
              child: Center(
                child: Image.asset('lib/core/assets/images/Frame 35.png'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.white),
              title: Text(
                'عن التطبيق',
                style: AppTextStyles.font17BlackMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap: toggleMenu,
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.white),
              title: Text(
                'مشاركة التطبيق',
                style: AppTextStyles.font17BlackMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap: toggleMenu,
            ),
            ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.white),
              title: Text(
                'تواصل معنا',
                style: AppTextStyles.font17BlackMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap: toggleMenu,
            ),
          ],
        ),
      ),
    );
  }
}
