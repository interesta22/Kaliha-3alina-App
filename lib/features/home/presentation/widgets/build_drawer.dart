import 'package:flutter/material.dart';
import 'package:khaliha_3alina/core/theme/colors.dart';
import 'package:khaliha_3alina/core/theme/text_style.dart';

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
              leading: Icon(Icons.trip_origin_outlined, color: Colors.white),
              title: Text(
                'رحلاتي السابقة',
                style: AppTextStyles.font17BlackMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // هنا ممكن تضيف كود لفتح صفحة الرحلات السابقة
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.white),
              title: Text(
                'الإعدادات',
                style: AppTextStyles.font17BlackMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.info_outline, color: Colors.white),
              title: Text(
                'عن التطبيق',
                style: AppTextStyles.font17BlackMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap: (){},
            ),

            ListTile(
              leading: Icon(Icons.contact_mail, color: Colors.white),
              title: Text(
                'تواصل معنا',
                style: AppTextStyles.font17BlackMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap: () {
                // هنا ممكن تضيف كود لفتح صفحة التواصل
              },
            ),
            ListTile(
              leading: Icon(Icons.share, color: Colors.white),
              title: Text(
                'مشاركة التطبيق',
                style: AppTextStyles.font17BlackMedium.copyWith(
                  color: Colors.white,
                ),
              ),
              onTap:  () {
                // هنا ممكن تضيف كود لمشاركة التطبيق
              },
            ),
          ],
        ),
      ),
    );
  }
