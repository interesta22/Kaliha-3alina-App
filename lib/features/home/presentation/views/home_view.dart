import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:khaliha_3alina/features/home/presentation/widgets/build_drawer.dart';
import 'package:khaliha_3alina/features/home/presentation/widgets/build_main_screen.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final ZoomDrawerController _drawerController = ZoomDrawerController();

  

  

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _drawerController,
      menuScreen: buildDrawerContent(),
      mainScreen: buildMainScreen(_drawerController),
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

  

}