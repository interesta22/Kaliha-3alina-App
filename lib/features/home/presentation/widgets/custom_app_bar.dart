import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key, this.onMenuPressed,
  });
  final VoidCallback? onMenuPressed;
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      leading: IconButton(onPressed: onMenuPressed, icon: Icon(Icons.menu_outlined)),
      title: Text(
        'خليها علينا',
        style: AppTextStyles.font20BlackBold.copyWith(fontSize: 27.sp),
      ),
      centerTitle: false,
    );
  }
}